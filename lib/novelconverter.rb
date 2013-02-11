# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "stringio"
require_relative "novelsetting"
require_relative "inspector"
require_relative "illustration"
require_relative "loadconverter"
require_relative "downloader"
require_relative "template"
require_relative "progressbar"
require_relative "helper"

class NovelConverter
  NOVEL_TEXT_TEMPLATE_NAME = "novel.txt"
  CONVERTED_FILENAME_PREFIX = "[変換]"
  CONVERTED_FILE_EXT = ".txt"

  #
  # 指定の小説を整形・変換する
  #
  # 返り値は保存したファイルのパス
  #
  def self.convert(target, output_filename = nil)
    setting = NovelSetting.create(target)
    if setting
      novel_converter = new(setting, output_filename)
      return novel_converter.convert_main
    end
    nil
  end

  #
  # テキストファイルを整形・変換する
  #
  # 返り値は保存したファイルのパス
  #
  def self.convert_file(filename, encoding, output_filename = nil)
    if output_filename
      archive_path = File.dirname(output_filename) + "/"
    else
      archive_path = File.dirname(filename) + "/"
    end
    setting = NovelSetting.new(archive_path)
    setting.name = File.basename(filename)
    novel_converter = new(setting, output_filename)
    text = File.read(filename)
    if encoding
      text.force_encoding(encoding).encode!(Encoding::UTF_8)
    end
    return novel_converter.convert_main(text)
  end

  #
  # AozoraEpub3でEPUBファイル作成
  #
  # AozoraEpub3は.jarがあるところがカレントディレクトリじゃないとうまく動かない
  # TODO:
  # 逆にカレントディレクトリにAozoraEpub3の必須ファイルを置いて手を加えることで、
  # テンプレート等の差し替えが容易になる
  #
  # 返り値：正常終了 :success、エラー終了 :error、AozoraEpub3が見つからなかった nil
  #
  def self.txt_to_epub(filename, dst_dir = nil)
    abs_srcpath = File.expand_path(filename)
    dst_option = ""
    if dst_dir
      dst_option = %!-dst "#{File.expand_path(dst_dir)}"!
    end
    pwd = Dir.pwd
    aozoraepub3_path = Narou.get_aozoraepub3_path
    aozoraepub3_basename = File.basename(aozoraepub3_path)
    aozoraepub3_dir = File.dirname(aozoraepub3_path)
    unless File.exists?(aozoraepub3_path)
      puts "AozoraEpub3が見つからなかったので、EPUBが出力出来ませんでした"
      return nil
    end
    Dir.chdir(aozoraepub3_dir)
    command = %!java -cp "#{aozoraepub3_basename}" AozoraEpub3 -enc UTF-8 #{dst_option} "#{abs_srcpath}"!
    if Helper.os_windows?
      command = "cmd /c " + command.encode(Encoding::Windows_31J)
    end
    print "AozoraEpub3でEPUBに変換しています"
    res = Helper::AsyncCommand.exec(command) do
      print "."
    end
    # MEMO: Windows環境以外での出力される文字コードはSJISなのか？
    stdout_capture = res[0].force_encoding(Encoding::Shift_JIS).encode(Encoding::UTF_8)
    Dir.chdir(pwd)
    if stdout_capture =~ /^\[ERROR\]/
      puts
      puts "AozoraEpub3実行中にエラーが発生したため、EPUBが出力出来ませんでした"
      puts stdout_capture.rstrip
      return :error
    end
    warn_list = stdout_capture.scan(/^\[WARN\].+$/)
    unless warn_list.empty?
      puts
      puts warn_list
    end
    puts "変換しました"
    :success
  end

  #
  # EPUBファイルをkindlegenでMOBIへ
  # AozoraEpub3.jar と同じ場所に kindlegen が無ければ何もしない
  #
  # 返り値：正常終了 :success、エラー終了 :error、中断終了 :abort、kindlegenがなかった nil
  #
  def self.epub_to_mobi(epub_path)
    kindlegen_path = File.join(File.dirname(Narou.get_aozoraepub3_path), "kindlegen")
    return nil if Dir.glob(kindlegen_path + "*").empty?

    if Helper.os_windows?
      epub_path.encode!(Encoding::Windows_31J)
    end
    command = %!"#{kindlegen_path}" "#{epub_path}"!
    print "kindlegen実行中"
    res = Helper::AsyncCommand.exec(command) do
      print "."
    end
    stdout_capture, _, proccess_status = res
    stdout_capture.force_encoding(Encoding::UTF_8)
    if proccess_status.exited?
      if proccess_status.exitstatus == 2
        puts
        puts "kindlegen実行中にエラーが発生したため、MOBIが出力出来ませんでした"
        if stdout_capture.scan(/(エラー\(.+?\):\w+?:.+)$/)
          puts $1
        end
        return :error
      end
    else
      puts
      puts "kindlegenが中断させられたぽいのでMOBIは出力出来ませんでした"
      return :abort
    end
    puts "変換しました"
    :success
  end

  def initialize(setting, output_filename = nil)
    @setting = setting
    @novel_name = setting.name
    @output_filename = output_filename
    @inspector = Inspector.new(@setting)
    @illustration = Illustration.new(@setting, @inspector)
  end

  def load_novel_section(subtitle_info)
    path = File.join(@section_save_dir, "#{subtitle_info["index"]} #{subtitle_info["subtitle"]}.yaml")
    YAML.load_file(path)
  end

  def create_novel_text_by_template(toc, sections)
    Template.get(NOVEL_TEXT_TEMPLATE_NAME, binding)
  end

  def convert_text_by_load_converter(text, text_type, converter)
    return "" if text == ""
    conv = converter.new(@setting, @inspector, @illustration)
    io = StringIO.new(rstrip_all_lines(text))
    (io = conv.before_convert(io, text_type)).rewind   # 特殊事前変換処理
    (io = conv.convert(io, text_type)).rewind          # 共通変換処理
    (io = conv.after_convert(io, text_type)).rewind    # 特殊事後変換処理
    return io.read
  end
  

  #
  # 変換処理メイン
  #
  def convert_main(text = nil)
    puts "#{@novel_name} の変換を開始"
    sections = []

    converter = load_converter(@setting.archive_path)
    if text
      result = convert_text_by_load_converter(text, "textfile",  converter)
      unless @setting.enable_enchant_midashi
        @inspector.info "テキストファイルの処理を実行しましたが、改行直後の見出し付与は有効になっていません。" +
                        "setting.ini の enable_enchant_midashi を true にすることをお薦めします。"
      end
    else
      @section_save_dir = Downloader.get_novel_section_save_dir(@setting.archive_path)
      @toc = Downloader.get_toc_data(@setting.archive_path)
      progressbar = ProgressBar.new(@toc["subtitles"].count)
      @toc["subtitles"].each_with_index do |subinfo, i|
        progressbar.output(i)
        section = load_novel_section(subinfo)
        element = section["element"]
        element.each do |text_type, elm_text|
          element[text_type] = convert_text_by_load_converter(elm_text, text_type,  converter)
        end
        section["subtitle"] = convert_text_by_load_converter(section["subtitle"], "subtitle",  converter)
        sections << section
      end
      progressbar.clear
      result = create_novel_text_by_template(@toc, sections)
    end

    make_midashi_and_save(result)
    inspect_novel(result)

    if @output_filename
      save_path = File.join(@setting.archive_path, File.basename(@output_filename))
    else
      save_path = File.join(@setting.archive_path, CONVERTED_FILENAME_PREFIX + @novel_name)
      if save_path !~ /\.\w+$/
        save_path += CONVERTED_FILE_EXT
      end
    end
    open(save_path, "w") do |fp|
      fp.write(result)
    end
    puts "#{File.basename(save_path)} を出力しました"
    save_path
  end

  def make_midashi_and_save(text)
    midashi_list = listup_midashi(text)
    open(File.join(@setting.archive_path, "見出しリスト.txt"), "w") do |fp|
      fp.write(midashi_list)
    end
  end

  def inspect_novel(text)
    # 行末読点の現在状況を調査する
    @inspector.check_end_touten_conditions(text)
    @inspector.check_return_count_in_brackets(text)

    # 小説の監視・検査状況を出力・保存する
    if @inspector.error? || @inspector.warning?
      puts "―― 小説にエラーもしくは警告が存在します ――"
      @inspector.display(Inspector::ERROR | Inspector::WARNING)
      puts
    end
    if @inspector.info?
      puts "―― 小説の検査状況を表示します ――"
      @inspector.display(Inspector::INFO)
      puts
    end
    @inspector.save
  end

  #
  # 見出しのリストを取得する
  #
  def listup_midashi(data)
    list = ""
    data.each_line.with_index(1) do |line, no|
      if line =~ /［＃ここから(?<scale>[大中小])見出し］(?<title>.+?)［＃ここで\g<scale>見出し終わり］/ ||
        line =~ /［＃「(?<title>.+?)は(?<scale>[大中小])見出し］/
        list << "#{$~[:scale]}:#{no}:#{$~[:title]}\n"
      end
    end
    list
  end

  #
  # すべての行の行末空白を削除
  #
  def rstrip_all_lines(data)
    data.gsub(/^[ 　\t]+$/, "")
  end
end
