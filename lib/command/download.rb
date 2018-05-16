# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../narou"
require_relative "../downloader"
require_relative "../input"

module Command
  class Download < CommandBase
    SUPPORT_NOVEL_SITES = %w(小説家になろう(小説を読もう) ノクターンノベルズ ムーンライトノベルズ Arcadia ハーメルン 暁 カクヨム)

    def initialize
      super("[<target> <target2> ...] [options]")
      @opt.separator <<-EOS

  ・ダウンロードしたい小説のNコードもしくはURLを指定して下さい。
  ・対応サイトは#{SUPPORT_NOVEL_SITES.join("、")}です。
  ・ArcadiaのURLを入力するときは" "で囲って下さい。
  ・ダウンロード終了後に変換処理を行います。ダウンロードのみする場合は-nオプションを指定して下さい。
  ・すでにダウンロード済みの小説の場合は何もしません。
  ・--remove オプションをつけてダウンロードすると、ダウンロード（とその後の変換、送信）が終わったあと削除します。データベースのインデックスを外すだけなので、変換した書籍データは残ったままになります。ファイルを全て消す場合は手動で削除する必要があります。
  ・NコードもURLも指定しなかった場合、対話モード移行します。

  Examples:
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

    def valid_target?(target)
      case Downloader.get_target_type(target)
      when :ncode
        true
      when :url
        !!SiteSetting.find(target)
      else
        false
      end
    end

    def print_prompt(targets)
      print "#{targets.size}> "
    end

    def interactive_mode
      targets = []
      return targets if Narou.web?
      puts "【対話モード】"
      puts "ダウンロードしたい小説のNコードもしくはURLを入力して下さい。(1行に1つ)"
      puts "連続して複数の小説を入力していきます。"
      puts "対応サイトは#{SUPPORT_NOVEL_SITES.join("、")}です。"
      puts "入力を終了してダウンロードを開始するには未入力のままエンターを押して下さい。"
      puts
      print_prompt(targets)
      while input = $stdin.gets
        input.strip!
        break if input == ""
        if valid_target?(input)
          if targets.include?(input)
            error "入力済みです"
          else
            targets << input
          end
        else
          error "対応外の小説です"
        end
        print_prompt(targets)
      end
      targets
    end

    def execute(argv)
      super
      mistook_count = 0
      if argv.empty?
        targets = interactive_mode
        return if targets.size == 0
        argv += targets
      end
      tagname_to_ids(argv)
      argv.each.with_index(1) do |target, i|
        download_target ||= target
        Helper.print_horizontal_rule if i > 1
        data = Downloader.get_data_by_target(download_target)
        if Narou.novel_frozen?(download_target)
          puts "#{data["title"]} は凍結中です\nダウンロードを中止しました"
          mistook_count += 1
          next
        end
        if !@options["force"] && data
          if Downloader.get_novel_data_dir_by_target(download_target)
            puts "#{download_target} はダウンロード済みです。"
            puts "ID: #{data["id"]}"
            puts "title: #{data["title"]}"
            mistook_count += 1
          else
            if Narou::Input.confirm("再ダウンロードしますか")
              download_target = data["toc_url"]
              redo
            else
              mistook_count += 1
            end
          end
          next
        end
        begin
          downloader = Downloader.new(download_target, force: @options["force"], from_download: true)
        rescue Downloader::InvalidTarget => e
          error e.message
          mistook_count += 1
          next
        end
        if downloader.start_download.status != :ok
          mistook_count += 1
          next
        end
        unless @options["no-convert"]
          convert_status = Convert.execute!([download_target])
          if convert_status > 0
            # 変換に失敗したか、中断された
            data = Downloader.get_data_by_target(download_target)   # 新規はDL後に取得しないとデータが存在しない
            data["_convert_failure"] = true
            # 中断された場合には残りのダウンロードも中止する
            raise Interrupt if convert_status == Narou::EXIT_INTERRUPT
          end
        end
        if @options["freeze"]
          Freeze.execute!([download_target])
        elsif @options["remove"]
          # --freeze オプションが指定された場合は --remove オプションは無視する
          Remove.execute!([download_target, "-y"])
        end
      end
      exit mistook_count if mistook_count > 0
    rescue Interrupt
      puts "ダウンロードを中断しました"
      exit Narou::EXIT_INTERRUPT
    ensure
      Database.instance.save_database
    end

    def self.oneline_help
      "指定した小説をダウンロードします"
    end
  end
end
