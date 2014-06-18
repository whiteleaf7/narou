# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../narou"
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
  ・--remove オプションをつけてダウンロードすると、ダウンロード（とその後の変換、送信）が終わったあと削除します。データベースのインデックスを外すだけなので、変換した書籍データは残ったままになります。ファイルを全て消す場合は手動で削除する必要があります。

  Example:
    narou download n9669bk
    narou download http://ncode.syosetu.com/n9669bk/
    narou download n9669bk http://ncode.syosetu.com/n4259s/
    narou download 0 1 -f
    narou download n9669bk -n
    narou download n6864bt --remove

  Options:
      EOS
      @opt.on("-f", "--force", "全話を強制再ダウンロードする") {
        @options["force"] = true
      }
      @opt.on("-n", "--no-convert", "変換をせずダウンロードのみ実行する") {
        @options["no-convert"] = true
      }
      @opt.on("-z", "--freeze", "ダウンロードが終了したあと凍結する") {
        @options["freeze"] = true
      }
      @opt.on("-r", "--remove", "ダウンロードが終了したあと削除する") {
        @options["remove"] = true
      }
    end

    def execute(argv)
      super
      if argv.empty?
        puts @opt.help
        return
      end
      argv.each.with_index(1) do |target, i|
        download_target ||= target
        Helper.print_horizontal_rule if i > 1
        data = Downloader.get_data_by_target(download_target)
        if Narou.novel_frozen?(download_target)
          puts "#{data["title"]} は凍結中です\nダウンロードを中止しました"
          next
        end
        if !@options["force"] && data
          if Downloader.get_novel_data_dir_by_target(download_target)
            puts "#{download_target} はダウンロード済みです。"
            puts "ID: #{data["id"]}"
            puts "title: #{data["title"]}"
          else
            if Helper.confirm("再ダウンロードしますか")
              download_target = data["toc_url"]
              redo
            end
          end
          next
        end
        if Downloader.start(download_target, @options["force"], true) != :ok
          next
        end
        unless @options["no-convert"]
          Convert.execute!([download_target])
        end
        if @options["freeze"]
          Freeze.execute!([download_target])
        elsif @options["remove"]
          # --freeze オプションが指定された場合は --remove オプションは無視する
          Remove.execute!([download_target, "-y"])
        end
      end
    end

    def oneline_help
      "指定した小説をダウンロードします"
    end
  end
end
