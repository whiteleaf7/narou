# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../helper"

module Command
  class Remove < CommandBase
    def initialize
      super("<target> [<target2> ...] [options]")
      @opt.separator <<-EOS

  ・削除したい小説のNコード、URL、タイトルもしくはIDを指定して下さい。
    IDは #{@opt.program_name} list を参照して下さい。
  ・一度に複数の小説を指定する場合は空白で区切って下さい。
  ・削除確認をスキップするには -y オプションを有効にして下さい。
  ・削除するのはデータベースのインデックスだけで、変換済みテキストファイルやMOBIファイル等はそのまま残ります。

  Example:
    narou remove n9669bk
    narou remove http://ncode.syosetu.com/n9669bk/
    narou remove n9669bk http://ncode.syosetu.com/n4259s/
    narou remove 0 1 -y
    narou remove n9669bk --with-file   # ファイルも完全に削除する

  Options:
      EOS
      @opt.on("-y", "--yes", "削除確認メッセージを表示しない") {
        @options["yes"] = true
      }
      @opt.on("--with-file", "小説の保存ディレクトリ・ファイルも全て削除する") {
        @options["with-file"] = true
      }
    end

    def execute(argv)
      super
      argv.each_with_index do |target, i|
        if i > 0
          puts "―" * 30
        end
        unless Downloader.novel_exists?(target)
          puts "#{target} は存在しません"
          next
        end
        title = Downloader.get_data_by_database(target)["title"]
        unless @options["yes"]
          next unless Helper.confirm("#{title} を#{(@options["with-file"] ? "“完全に”" : "")}削除しますか")
        end
        Downloader.remove_novel(target, @options["with-file"])
        puts "削除しました"
      end
    end

    def oneline_help
      "小説を削除します"
    end
  end
end
