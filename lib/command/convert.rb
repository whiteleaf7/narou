# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../database"
require_relative "../downloader"
require_relative "../novelconverter"

module Command
  class Convert < CommandBase
    @@database = Database.instance

    def initialize
      super("<target> [<target2> ...] [option]")
      @opt.separator <<-EOS

  ・指定した小説を縦書用に整形及びEPUB、MOBIに変換します。
  ・変換したい小説のNコード、URL、タイトルもしくはIDを指定して下さい。
    IDは #{@opt.program_name} list を参照して下さい。
  ・一度に複数の小説を指定する場合は空白で区切って下さい。
  ※-oオプションがない場合、[変換]小説名.txtが小説の保存フォルダに出力されます。
  ※複数指定した場合に-oオプションがあった場合、ファイル名に連番がつきます。
  ・管理小説以外にもテキストファイルを変換出来ます。
    テキストファイルのファイルパスを指定します。
  ・デフォルトでは変換終了後にAozoraEpub3を使ってEPUB化を実行します。

  Example:
    narou convert n9669bk
    narou convert http://ncode.syosetu.com/n9669bk/
    narou convert 異世界迷宮で奴隷ハーレムを
    narou convert 1 -o "ハーレム -変換済み-.txt"
    narou convert mynovel.txt --enc sjis

  Options:
      EOS
      @opt.on("-o FILE", "--output FILE", "出力ファイル名を指定する。フォルダパス部分は無視される") { |filename|
        @options["output"] = filename
      }
      @opt.on("-e ENCODING", "--enc ENCODING", "テキストファイル指定時のエンコーディングを指定する") { |encoding|
        @options["encoding"] = encoding
      }
      @opt.on("--no-epub", "AozoraEpub3でEPUB化しない") {
        @options["no-epub"] = true
      }
      @opt.on("--no-mobi", "kindlegenでMOBI化しない") {
        @options["no-mobi"] = true
      }
      @opt.on("--no-open", "出力時に保存フォルダを開かない") {
        @options["no-open"] = true
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
        if File.file?(target)
          argument_target_type = :file
          begin
            converted_txt_path = NovelConverter.convert_file(target, enc, output_filename)
            next unless converted_txt_path
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
          argument_target_type = :novel
          unless Downloader.novel_exists?(target)
            puts "#{target} は存在しません"
            next
          end
          converted_txt_path = NovelConverter.convert(target, output_filename)
          next unless converted_txt_path
        end
        converted_txt_dir = File.dirname(converted_txt_path)
        unless @options["no-epub"]
          # epub
          res = NovelConverter.txt_to_epub(converted_txt_path)
          next if res != :success

          unless @options["no-mobi"]
            # mobi
            if argument_target_type == :file
              data = get_title_and_author_by_textfile(converted_txt_path)
            else
              data = Downloader.get_data_by_database(target)
            end
            epub_path = File.join(converted_txt_dir, %![#{data["author"]}] #{data["title"]}.epub!)
            res = NovelConverter.epub_to_mobi(epub_path)
            next if res != :success
            # strip
            mobi_path = epub_path.sub(/\.epub$/, "") + ".mobi"
            puts "kindlestrip実行中"
            kindlestrip_path = File.join(Narou.get_script_dir, "kindlestrip.py")
            command = %!python "#{kindlestrip_path}" "#{mobi_path}" "#{mobi_path}"!
            `#{command}`

            puts "MOBIファイルを出力しました"
          end
        end

        unless @options["no-open"]
          Helper.open_directory_by_os_filer(converted_txt_dir, "小説の保存フォルダを開きますか")
        end
      end
    end

    #
    # テキストファイル先頭二行からタイトルと作者名を取得
    #
    def get_title_and_author_by_textfile(textfile_path)
      title = author = ""
      open(textfile_path) do |fp|
        title = fp.gets.rstrip
        author = fp.gets.rstrip
      end
      { "title" => title, "author" => author }
    end

    def oneline_help
      "小説を変換します。管理小説以外にテキストファイルも変換可能"
    end
  end
end
