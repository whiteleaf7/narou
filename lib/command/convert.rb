# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../novelconverter"

module Command
  class Convert < CommandBase
    def initialize
      super("<target> [<target2> ...] [option]")
      @opt.separator <<-EOS

  ・変換したい小説のNコード、URL、タイトルもしくはIDを指定して下さい。
    IDは #{@opt.program_name} list を参照して下さい。
  ・一度に複数の小説を指定する場合は空白で区切って下さい。
  ※-oオプションがない場合、[変換]小説名.txtが小説の保存ディレクトリに出力されます。
  ※複数指定した場合に-oオプションがあった場合、ファイル名に連番がつきます。
  ・管理小説以外にもテキストファイルを変換出来ます。
    テキストファイルのファイルパスを指定します。
  ・デフォルトでは変換終了後にAozoraEpub3を使ってEPUB化を実行します。

  Example:
    narou convert n9669bk
    narou convert http://ncode.syosetu.com/n9669bk/
    narou convert 異世界迷宮で奴隷ハーレムを
    narou convert 1 -o "ハーレム -変換済み-.txt"
    narou convert mynovel.txt

  Options:
      EOS
      @opt.on("-o FILE", "--output FILE", "出力ファイル先を指定する") { |filename|
        @options["output"] = filename
      }
      @opt.on("-e ENCODING", "--enc ENCODING", "テキストファイルのエンコーディングを指定する") { |encoding|
        @options["encoding"] = encoding
      }
      @opt.on("--no-epub", "AozoraEpub3でEPUB化はしない") {
        @options["no-epub"] = true
      }
    end

    def execute(argv)
      super
      return if argv.empty?
      output_filename = @options["output"]
      if output_filename && argv.length > 1
        ext = File.extname(output_filename)
        basename = File.basename(output_filename, ext)
      end
      enc = Encoding.find(@options["encoding"]) rescue nil
      argv.each.with_index(1) do |target, i|
        if i > 1
          puts "―" * 30
        end
        output_filename = "#{basename} (#{i})#{ext}" if basename
        if File.exists?(target) && File::ftype(target) == "file"
          begin
            NovelConverter.convert_file(target, enc, output_filename)
          rescue ArgumentError => e
            if e.message =~ /invalid byte sequence in UTF-8/
              puts "テキストファイルの文字コードがUTF-8ではありません。--enc オプションでテキストのエンコーディングを指定して下さい"
              puts "(#{e.message})"
              exit 1
            else
              raise
            end
          end
        else
          unless Downloader.novel_exists?(target)
            puts "#{target} は存在しません"
            next
          end
          converted_txt_path = NovelConverter.convert(target, output_filename)
          unless converted_txt_path
            next
          end
          if @options["no-epub"]
            next
          end
          # epub
          # TODO: 出力ファイル名をこっちで指定する
          dst_dir = output_filename ? File.dirname(output_filename) : nil
          res = NovelConverter.convert_to_epub(converted_txt_path, dst_dir)
          if res =~ /^\[ERROR\]/
            puts res.rstrip
            next
          end
          # mobi
          data = Downloader.get_data_by_database(target)
          epub_path = File.join(File.dirname(converted_txt_path), %![#{data["author"]}] #{data["title"]}.epub!)
          #epub_path = Dir.glob(File.join(File.dirname(converted_txt_path), "*.epub"))[0]
          if Helper.os_windows?
            epub_path.encode!(Encoding::Windows_31J)
          end
          command = "./kindlegen \"#{epub_path}\""
          print "kindlegen実行中"
          res = Helper::AsyncCommand.exec(command) do
            print "."
          end
          puts
          kindlegen_response, _, proccess_status = res
          kindlegen_response.force_encoding(Encoding::UTF_8)
          if proccess_status.exited?
            if proccess_status.exitstatus == 2
              puts "kindlegen実行中にエラーが発生したため、MOBIが出力出来ませんでした"
              if kindlegen_response.scan(/(エラー\(.+?\):\w+?:.+)$/)
                puts $1
              end
              next
            end
          else
            puts "kindlegenが中断させられたぽいのでMOBIは出来ませんでした"
          end
          # strip
          mobi_path = epub_path.sub(/\.epub$/, "") + ".mobi"
          command = "python kindlestrip.py \"#{mobi_path}\" \"#{mobi_path}\""
          `#{command}`
=begin
          case proccess_status.exitstatus
          when 0
            puts "MOBIファイルを出力しました"
          when 1
            puts "MOBIファイルは出力しましたが警告があります！"
          end
=end
          puts "MOBIファイルを出力しました"   # AozorazEPUB3じゃどう頑張っても警告が出ちゃう
        end
      end
    end

    def txt_to_epub
    end

    def epub_to_mobi
    end

    def mobistrip
    end

    def oneline_help
      "小説を整形します。管理小説以外にテキストファイルも変換可能"
    end
  end
end
