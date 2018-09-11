# frozen_string_literal: true

#
# Copyright 2013 whiteleaf. All rights reserved.
#

module Command
  class List < CommandBase
    class NovelDecorator
      attr_accessor(*%i(id frozen novel_type novel options parent))

      def initialize(novel, parent)
        self.id = novel["id"]
        self.frozen = Narou.novel_frozen?(id)
        self.novel_type = novel["novel_type"].to_i
        self.novel = novel
        self.options = parent.options
        self.parent = parent
      end

      def decorate_id
        disp_id = ((frozen ? "*" : "") + id.to_s).rjust(4)
        if frozen
          disp_id.sub("*", "<bold><cyan>*</cyan></bold>")
        else
          disp_id
        end
      end

      def decorate_date
        date = novel[parent.view_date_type].strftime("%y/%m/%d")
        new_arrivals_date = novel["new_arrivals_date"]
        last_update = novel["last_update"]
        if new_arrivals_date && new_arrivals_date >= last_update &&
           new_arrivals_date + ANNOTATION_COLOR_TIME_LIMIT >= now
          # 新着表示色
          "<bold><magenta>#{date}</magenta></bold>"
        elsif last_update + ANNOTATION_COLOR_TIME_LIMIT >= now
          # 更新だけあった色
          "<bold><green>#{date}</green></bold>"
        else
          date
        end
      end

      def decorate_kind
        options["kind"] ? NOVEL_TYPE_LABEL[novel_type] : nil
      end

      def decorate_author
        options["author"] ? novel["author"].escape : nil
      end

      def decorate_site
        options["site"] ? novel["sitename"].escape : nil
      end

      def decorate_title
        if !options["kind"] && novel_type == 2
          type = " <bold><black>(#{NOVEL_TYPE_LABEL[novel_type]})</black></bold>"
        end
        the_end = "<bold><black>(完結)</black></bold>" if tags.include?("end")
        delete = "<bold><black>(削除)</black></bold>" if tags.include?("404")
        [
          novel["title"].escape,
          type,
          the_end,
          delete
        ].compact.join(" ")
      end

      def decorate_url
        options["url"] ? novel["toc_url"].escape : nil
      end

      def decorate_tags
        return nil unless options["tags"] || options["all-tags"]
        tags.empty? ? nil : tags.map { |tag|
          color = Tag.get_color(tag)
          "<bold><#{color}>#{tag.escape}</#{color}></bold>"
        }.join(",")
      end

      def decorate_line
        [
          decorate_id,
          decorate_date,
          decorate_kind,
          decorate_author,
          decorate_site,
          decorate_title,
          decorate_url,
          decorate_tags
        ].compact.join(" | ")
      end

      private

      def tags
        @__tags ||= novel["tags"] || []
      end

      def now
        parent.now
      end
    end
  end
end
