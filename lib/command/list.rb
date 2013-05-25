# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../database"

module Command
  class List < CommandBase
    def initialize
      super("[<number>] [options]")
      @opt.separator <<-EOS

  ・現在管理している小説の一覧を表示します。
  ・表示されるIDは各コマンドで指定することで小説名等を入力する手間を省けます。
  ・個数を与えることで、最大表示数を制限できます(デフォルトは全て表示)

  Example:
    narou list             # IDの小さい順に全て表示
    narou list 10 -r       # IDの大きい順に10件表示
    narou list 5 -l        # 最近更新のあった5件表示
    narou list 10 -rl      # 最新10件を古い順に表示

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
    end

    def output_list(novels)
      today = Time.now.strftime("%y/%m/%d")
      puts "  ID |  更新日  |     タイトル"
      novels.each do |novel|
        id = novel["id"]
        frozen = Narou.novel_frozen?(id)
        disp_id = ((frozen ? "*" : "") + id.to_s).rjust(4)
        disp_id = disp_id.sub("*", "<cyan>*</cyan>").termcolor if frozen
        puts [
          disp_id,
          novel["last_update"].strftime("%y/%m/%d").tap { |s|
            if novel["new_arrivals_date"] && novel["new_arrivals_date"].strftime("%y/%m/%d") == today
              s.replace "<bold><magenta>#{s}</magenta></bold>".termcolor
            elsif s == today
              s.replace "<bold><green>#{s}</green></bold>".termcolor
            end
          },
          novel["title"],
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

    def oneline_help
      "現在管理している小説の一覧を表示します"
    end
  end
end
