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

    def self.oneline_help
      "現在管理している小説の一覧を表示します"
    end

    def initialize
      super("[<limit>] [options]")
      @opt.separator <<-EOS.termcolor

  ・現在管理している小説の一覧を表示します
  ・表示されるIDは各コマンドで指定することで小説名等を入力する手間を省けます
  ・個数を与えることで、最大表示数を制限できます(デフォルトは全て表示)
  ・narou listのデフォルト動作を narou s default_arg.list= で設定すると便利です
  ・パイプで他のnarouコマンドに繋ぐとID入力の代わりにできます

  Examples:
    narou list             # IDの小さい順に全て表示
    narou list 10 -r       # IDの大きい順に10件表示
    narou list 5 -l        # 最近更新のあった5件表示
    narou list 10 -rl      # 古い順に10件表示
    narou list -f ss       # 短編小説だけ表示

    # 小説家になろうの小説のみを表示
    narou list --site --grep 小説家になろう
    narou l -sg 小説家になろう    # 上記と同じ意味
    # 作者“紫炎”を含む小説を表示
    narou list --author --grep 紫炎
    narou l -ag 紫炎              # 上記と同じ意味
    # “紫炎”と“なろう”を含む小説を表示(AND検索)
    narou l -asg "紫炎 なろう"
    # “なろう”を含まない小説を表示(NOT検索)
    narou l -sg "-なろう"

    # ハーメルンを含む小説にhamelnタグを付ける
    narou l -sg ハーメルン | narou t -a hameln
    # 短編を全て凍結する
    narou l -f ss | narou freeze --on

    # リストをそのまま保存したい時(echoオプション)
    narou l -e > list.txt

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
      @opt.on("-k", "--kind", "小説の種別（短編／連載）も表示する") {
        @options["kind"] = true
      }
      @opt.on("-s", "--site", "掲載小説サイト名も表示する") {
        @options["site"] = true
      }
      @opt.on("-a", "--author", "作者名も表示する") {
        @options["author"] = true
      }
      @opt.on("-f", "--filter VAL", String,
              "表示を絞るためのフィルターの種類(連載:series, 短編:ss)") { |filter|
        @options["filter"] = filter
      }
      @opt.on("-g", "--grep VAL", String,
              "指定された文字列でリストを検索する") { |search|
        @options["grep"] = search.split
      }
      @opt.on("-t", "--tag [TAGS]", String,
              "タグも表示。引数を指定した場合そのタグを含む小説を表示") { |tags|
        if tags
          @options["tags"] = tags.split
        else
          @options["all-tags"] = true
        end
      }
      @opt.on("-e", "--echo", "パイプやリダイレクトでもそのまま出力する") {
        @options["echo"] = true
      }
    end

    def valid_tags?(novel, tags)
      novel_tags = novel["tags"] or return false
      tags.each do |tag|
        return false unless novel_tags.include?(tag)
      end
      true
    end

    def header
      [
         " ID ", " 更新日 ",
         @options["kind"] ? "種別" : nil,
         @options["author"] ? "作者名" : nil,
         @options["site"] ? "サイト名" : nil,
         "     タイトル"
      ].compact.join(" | ")
    end

    def output_list(novels)
      now = Time.now
      today = now.strftime("%y/%m/%d")
      filter = @options["filter"]
      selected_lines = {}
      novels.each do |novel|
        novel_type = novel["novel_type"].to_i
        if filter
          if filter == "series" && novel_type != 0 && novel_type != 1
            next
          elsif filter == "ss" && novel_type != 2
            next
          end
        end
        if @options["tags"]
          next unless valid_tags?(novel, @options["tags"])
        end
        id = novel["id"]
        frozen = Narou.novel_frozen?(id)
        disp_id = ((frozen ? "*" : "") + id.to_s).rjust(4)
        disp_id = disp_id.sub("*", "<bold><cyan>*</cyan></bold>").termcolor if frozen
        flags = novel["flags"] || {}   # flagコマンドは1.6.0から非推奨
        tags = novel["tags"] || []
        flags["end"] ||= tags.include?("end")
        flags["404"] ||= tags.include?("404")
        selected_lines[id] = [
          disp_id,
          novel["last_update"].strftime("%y/%m/%d").tap { |s|
            if novel["new_arrivals_date"] && novel["new_arrivals_date"] + NEW_ARRIVALS_LIMIT >= now
              # 新着表示色
              s.replace "<bold><magenta>#{s}</magenta></bold>"
            elsif s == today
              # 更新だけあった色
              s.replace "<bold><green>#{s}</green></bold>"
            end
          },
          @options["kind"] ? NOVEL_TYPE_LABEL[novel_type] : nil,
          @options["author"] ? novel["author"].escape : nil,
          @options["site"] ? novel["sitename"].escape : nil,
          novel["title"].escape + (!@options["kind"] && novel_type == 2 ?
                           "  <bold><black>(#{NOVEL_TYPE_LABEL[novel_type]})</black></bold>" :
                           "") +
                           (flags["end"] ? " <bold><black>(完結)</black></bold>" : "") +
                           (flags["404"] ? " <bold><black>(削除)</black></bold>" : ""),
          @options["url"] ? novel["toc_url"].escape : nil,
          @options["tags"] || @options["all-tags"] ?
              tags.empty? ? nil : tags.map{ |tag|
                color = Tag.get_color(tag)
                "<bold><#{color}>#{tag.escape}</#{color}></bold>"
              }.join(",") : nil,
        ].compact.join(" | ").termcolor
      end
      if @options["grep"]
        @options["grep"].each do |search_word|
          selected_lines.keep_if { |id, line|
            if search_word =~ /^-(.+)/
              # NOT検索
              not line.include?($1)
            else
              line.include?(search_word)
            end
          }
        end
      end
      if STDOUT.tty?
        puts header
        puts selected_lines.values
      else
        if @options["echo"]
          # pipeにそのまま出力するときはansicolorコードが邪魔なので削除
          puts header
          puts $stdout.strip_color(selected_lines.values.join("\n"))
        else
          # pipeに接続するときはIDを渡す
          puts selected_lines.keys.join(" ")
        end
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
  end
end
