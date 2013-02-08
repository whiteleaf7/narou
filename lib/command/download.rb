# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../downloader"

module Command
  class Download < CommandBase
    def initialize
      super("<target> [<target2> ...] [options]")
      @opt.separator <<-EOS

  ・ダウンロードしたい小説のNコードもしくはURLを指定して下さい。
  ・一度に複数の小説を指定する場合は空白で区切って下さい。
  ・ダウンロード終了後に変換処理を行います。ダウンロードのみする場合は-nオプションを指定して下さい。
  ・すでにダウンロード済みの小説の場合は何もしません。
  ・ダウンロード済みの小説を再度ダウンロードする場合、IDや小説名を指定出来ますが、-fオプションを付けて下さい。

  Example:
    narou download n9669bk
    narou download http://ncode.syosetu.com/n9669bk/
    narou download n9669bk http://ncode.syosetu.com/n4259s/
    narou download 0 1 -f
    narou download n9669bk -n

  Options:
      EOS
      @opt.on("-f", "--force", "ダウンロード済みでも強制ダウンロードして上書きする") {
        @options["force"] = true
      }
      @opt.on("-n", "--no-convert", "変換をせずダウンロードのみ実行する") {
        @options["no-convert"] = true
      }
    end

    def execute(argv)
      super
      return if argv.empty?
      argv.each.with_index(1) do |target, i|
        if i > 1
          puts "―" * 30
        end
        if !@options["force"] && Downloader.novel_exists?(target)
          data = Downloader.get_data_by_database(target)
          puts "#{target} はダウンロード済みです。"
          puts "ID: #{data["id"]}"
          puts "title: #{data["title"]}"
          next
        end
        unless Downloader.start(target, @options["force"])
          puts "ダウンロードに失敗しました(#{target})"
          next
        end
        unless @options["no-convert"]
          Convert.execute_and_rescue_exit([target])
        end
      end
    end

    def oneline_help
      "指定した小説をダウンロードします"
    end
  end
end
