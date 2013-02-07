# -*- Encoding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../template"

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
      @opt.on("-l", "--latest", "最近更新のあった順に小説を表示します。") {
        @options["latest"] = true
      }
      @opt.on("-r", "--reverse", "逆順に表示します。") {
        @options["reverse"] = true
      }
      @opt.on("-u", "--url", "小説の掲載ページも表示します。") {
        @options["url"] = true
      }
    end

    # String#rjust の全角考慮版
    def rjust_zenkaku(value, max)
      value_length = value.dup.force_encoding(Encoding::ASCII_8BIT).length
      return value + " " * (max - value_length)
    end

    # String#length の全角文字は2文字と数える版
    def length_zenkaku(value)
    end

    def output_list(novels)
      puts " ID |  更新日  |     タイトル"
      novels.each do |novel|
        puts [
          novel["id"].to_s.rjust(3),
          novel["last_update"].strftime("%y/%m/%d"),
          novel["title"],
          @options["url"] ? novel["toc_url"] : nil
        ].compact.join(" | ")
      end
    end

    def execute(argv)
      super
      database = Downloader.get_database.values
      if !argv.empty? && argv.first =~ /^\d+$/
        num = argv.first.to_i
      else
        num = database.count
      end
      if @options["latest"]
        database.sort_by! { |v| v["last_update"] }
        database.reverse!   # 更新順に表示する場合は新しい順に表示する
      end
      database.reverse! if @options["reverse"]
      novels = database[0, num]
      output_list(novels)
    end

    def oneline_help
      "現在管理している小説の一覧を表示します。"
    end
  end
end
