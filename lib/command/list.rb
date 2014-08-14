# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../database"

module Command
  class List < CommandBase
    NEW_ARRIVALS_LIMIT = 6 * 60 * 60   # 更新してから何秒までを新着色にするか

    # MEMO: 0 は昔の小説を凍結したままな場合、novel_type が設定されていないので、
    #       nil.to_i → 0 という互換性維持のため
    NOVEL_TYPE_LABEL = ["連載", "連載", "短編"]

    def initialize
      super("[<number>] [options]")
      @opt.separator <<-EOS

  ・現在管理している小説の一覧を表示します。
  ・表示されるIDは各コマンドで指定することで小説名等を入力する手間を省けます。
  ・個数を与えることで、最大表示数を制限できます(デフォルトは全て表示)
  ・narou listのデフォルト動作を narou s default_arg.list= で設定すると便利です

  Example:
    narou list             # IDの小さい順に全て表示
    narou list 10 -r       # IDの大きい順に10件表示
    narou list 5 -l        # 最近更新のあった5件表示
    narou list 10 -rl      # 古い順に10件表示
    narou list -f ss       # 短編小説だけ表示

  Options:
      EOS
      @opt.on("-l", "--latest", "最近更新のあった順に小説を表示する") {
        @options["latest"] = true
      }
      @opt.on("-r", "--reverse", "逆順に表示する") {
        @options["reverse"] = true
      }
      @opt.on("-u", "--url", "小説の掲載ページも表示する") {
        @options["url"] = true
      }
      @opt.on("-t", "--type", "小説の種別（短編／連載）も表示する") {
        @options["type"] = true
      }
      @opt.on("-s", "--site", "掲載小説サイト名も表示") {
        @options["site"] = true
      }
      @opt.on("-f", "--filter VAL", String,
              "表示を絞るためのフィルターの種類(連載:series, 短編:ss)") { |filter|
        @options["filter"] = filter
      }
    end

    def output_list(novels)
      now = Time.now
      today = now.strftime("%y/%m/%d")
      filter = @options["filter"]
      header = [" ID ", " 更新日 ",
                @options["type"] ? "種別" : nil,
                @options["site"] ? "サイト名" : nil,
                "     タイトル"].compact
      puts header.join(" | ")
      novels.each do |novel|
        novel_type = novel["novel_type"].to_i
        if filter
          if filter == "series" && novel_type != 0 && novel_type != 1
            next
          elsif filter == "ss" && novel_type != 2
            next
          end
        end
        id = novel["id"]
        frozen = Narou.novel_frozen?(id)
        disp_id = ((frozen ? "*" : "") + id.to_s).rjust(4)
        disp_id = disp_id.sub("*", "<cyan>*</cyan>").termcolor if frozen
        flags = novel["flags"] || {}
        puts [
          disp_id,
          novel["last_update"].strftime("%y/%m/%d").tap { |s|
            if novel["new_arrivals_date"] && novel["new_arrivals_date"] + NEW_ARRIVALS_LIMIT >= now
              # 新着表示色
              s.replace "<bold><magenta>#{s}</magenta></bold>".termcolor
            elsif s == today
              # 更新だけあった色
              s.replace "<bold><green>#{s}</green></bold>".termcolor
            end
          },
          @options["type"] ? NOVEL_TYPE_LABEL[novel_type] : nil,
          @options["site"] ? novel["sitename"] : nil,
          novel["title"] + (!@options["type"] && novel_type == 2 ?
                           "  <gray>(#{NOVEL_TYPE_LABEL[novel_type]})</gray>".termcolor :
                           "") +
                           (flags["end"] ? " <gray>(完結)</gray>".termcolor : "") +
                           (flags["delete"] ? " <gray>(削除)</gray>".termcolor : ""),
          @options["url"] ? novel["toc_url"] : nil
        ].compact.join(" | ")
      end
    end

    def execute(argv)
      super
      database_values = Database.instance.get_object.values
      if !argv.empty? && argv.first =~ /^\d+$/
        num = argv.first.to_i
      else
        num = database_values.count
      end
      if @options["latest"]
        database_values = Database.instance.sort_by_last_update
      end
      database_values.reverse! if @options["reverse"]
      novels = database_values[0, num]
      output_list(novels)
    end

    def self.oneline_help
      "現在管理している小説の一覧を表示します"
    end
  end
end
