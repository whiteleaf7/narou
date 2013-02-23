# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "fileutils"
require "stringio"
require_relative "novelsetting"
require_relative "inspector"
require_relative "illustration"
require_relative "loadconverter"
require_relative "downloader"
require_relative "template"
require_relative "progressbar"
require_relative "helper"
require_relative "localsetting"

class NovelConverter
  NOVEL_TEXT_TEMPLATE_NAME = "novel.txt"

  attr_reader :use_dakuten_font

  #
  # 指定の小説を整形・変換する
  #
  def self.convert(target, output_filename = nil, display_inspector = false)
    setting = NovelSetting.load(target)
    if setting
      novel_converter = new(setting, output_filename, display_inspector)
      return {
        converted_txt_path: novel_converter.convert_main,
        use_dakuten_font: novel_converter.use_dakuten_font
      }
    end
    nil
  end

  #
  # テキストファイルを整形・変換する
  #
  def self.convert_file(filename, encoding = nil, output_filename = nil, display_inspector = false)
    if output_filename
      archive_path = File.dirname(output_filename) + "/"
    else
      archive_path = File.dirname(filename) + "/"
    end
    setting = NovelSetting.new(archive_path)
    setting.author = ""
    setting.title = File.basename(filename)
    novel_converter = new(setting, output_filename, display_inspector)
    text = open(filename, "r:BOM|UTF-8") { |fp| fp.read }
    if encoding
      text.force_encoding(encoding).encode!(Encoding::UTF_8)
    end
    {
      converted_txt_path: novel_converter.convert_main(text),
      use_dakuten_font: novel_converter.use_dakuten_font
    }
  end

  def self.stash_aozora_fonts_directory
    fonts_path = File.join(File.dirname(Narou.get_aozoraepub3_path), "template/OPS/fonts")
    return unless File.exists?(fonts_path)
    FileUtils.mv(fonts_path, fonts_path + "_hide")
  end

  def self.visible_aozora_fonts_directory
    fonts_path = File.join(File.dirname(Narou.get_aozoraepub3_path), "template/OPS/fonts")
    return unless File.exists?(fonts_path + "_hide")
    FileUtils.mv(fonts_path + "_hide", fonts_path)
  end

  #
  # AozoraEpub3でEPUBファイル作成
  #
  # AozoraEpub3は.jarがあるところがカレントディレクトリじゃないとうまく動かない
  # MEMO:
  # 逆にカレントディレクトリにAozoraEpub3の必須ファイルを置いて手を加えることで、
  # テンプレート等の差し替えが容易になる
  #
  # 返り値：正常終了 :success、エラー終了 :error、AozoraEpub3が見つからなかった nil
  #
  def self.txt_to_epub(filename, use_dakuten_font = false, dst_dir = nil, device = nil)
    abs_srcpath = File.expand_path(filename)
    #cover_path = File.join(File.dirname(filename), "cover.jpg")
    cover_option = ""
    # MEMO: 外部実行からだと -c FILENAME, -c 1 オプションはぬるぽが出て動かない
    #if File.exists?(cover_path)
      #cover_option = %!--cover "#{cover_path}"!
      cover_option = "-c 0"   # 先頭の挿絵を表紙として利用
    #end

    dst_option = ""
    if dst_dir
      dst_option = %!-dst "#{File.expand_path(dst_dir)}"!
    end

    ext_option = ""
    if device && device.kobo?
      ext_option = "-ext " + device.ebook_file_ext
    end

    pwd = Dir.pwd

    aozoraepub3_path = Narou.get_aozoraepub3_path
    aozoraepub3_basename = File.basename(aozoraepub3_path)
    aozoraepub3_dir = File.dirname(aozoraepub3_path)
    unless File.exists?(aozoraepub3_path)
      warn "AozoraEpub3が見つからなかったので、EPUBが出力出来ませんでした"
      return nil
    end

    Dir.chdir(aozoraepub3_dir)
    command = %!java -cp #{aozoraepub3_basename} AozoraEpub3 -enc UTF-8 ! +
              %!#{cover_option} #{dst_option} #{ext_option} "#{abs_srcpath}"!
    if Helper.os_windows?
      command = "cmd /c " + command.encode(Encoding::Windows_31J)
    end
    stash_aozora_fonts_directory unless use_dakuten_font
    print "AozoraEpub3でEPUBに変換しています"
    res = Helper::AsyncCommand.exec(command) do
      print "."
    end
    # MEMO: Windows環境以外で出力される文字コードはSJISなのか？
    stdout_capture = res[0].force_encoding(Encoding::Shift_JIS).encode(Encoding::UTF_8)

    Dir.chdir(pwd)
    error_list = stdout_capture.scan(/^\[ERROR\].+$/)
    warn_list = stdout_capture.scan(/^\[WARN\].+$/)
    info_list = stdout_capture.scan(/^\[INFO\].+$/)
    if !error_list.empty? || !warn_list.empty? || !info_list.empty?
      puts
      puts error_list
      puts warn_list
      puts info_list
      unless error_list.empty?
        # AozoraEpub3 のエラーにはEPUBが出力されないエラーとEPUBが出力されるエラーの2種類ある。
        # EPUBが出力される場合は「変換完了」という文字があるのでそれを検出する
        if stdout_capture !~ /^変換完了/
          warn "AozoraEpub3実行中にエラーが発生したため、EPUBが出力出来ませんでした"
          return :error
        end
      end
    end
    puts "変換しました"
    :success
  ensure
    visible_aozora_fonts_directory unless use_dakuten_font
  end

  #
  # EPUBファイルをkindlegenでMOBIへ
  # AozoraEpub3.jar と同じ場所に kindlegen が無ければ何もしない
  #
  # 返り値：正常終了 :success、エラー終了 :error、中断終了 :abort、kindlegenがなかった nil
  #
  def self.epub_to_mobi(epub_path)
    kindlegen_path = File.join(File.dirname(Narou.get_aozoraepub3_path), "kindlegen")
    if Dir.glob(kindlegen_path + "*").empty?
      warn "kindlegenが見つかりませんでした。AozoraEpub3と同じディレクトリにインストールして下さい"
      return :error
    end

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
        puts ""
        warn "kindlegen実行中にエラーが発生したため、MOBIが出力出来ませんでした"
        if stdout_capture.scan(/(エラー\(.+?\):\w+?:.+)$/)
          warn $1
        end
        return :error
      end
    else
      puts ""
      warn "kindlegenが中断させられたぽいのでMOBIは出力出来ませんでした"
      return :abort
    end
    puts "変換しました"
    :success
  end

  def initialize(setting, output_filename = nil, display_inspector = false)
    @setting = setting
    @novel_id = setting.id
    @novel_author = setting.author
    @novel_title = setting.title
    @output_filename = output_filename
    @inspector = Inspector.new(@setting)
    @illustration = Illustration.new(@setting, @inspector)
    @display_inspector = display_inspector
    @use_dakuten_font = false
  end

  def load_novel_section(subtitle_info)
    path = File.join(@section_save_dir, "#{subtitle_info["index"]} #{subtitle_info["subtitle"]}.yaml")
    YAML.load_file(path)
  end

  def create_novel_text_by_template(sections)
    toc = @toc
    cover_chuki = @cover_chuki
    Template.get(NOVEL_TEXT_TEMPLATE_NAME, binding)
  end

  def convert_text_by_load_converter(text, text_type, converter)
    return "" if text == ""
    conv = converter.new(@setting, @inspector, @illustration)
    io = StringIO.new(rstrip_all_lines(text))
    (io = conv.before_convert(io, text_type)).rewind   # 特殊事前変換処理
    (io = conv.convert(io, text_type)).rewind          # 共通変換処理
    (io = conv.after_convert(io, text_type)).rewind    # 特殊事後変換処理
    @use_dakuten_font = true if conv.use_dakuten_font
    return io.read
  end

  #
  # 表紙用挿絵注記作成
  #
  def create_cover_chuki
    result = ""
    [".jpg", ".png", ".jpeg"].each do |ext|
      filename = "cover#{ext}"
      cover_path = File.join(@setting.archive_path, filename)
      if File.exists?(cover_path)
        result = "［＃挿絵（#{filename}）入る］"
        break
      end
    end
    result
  end

  #
  # 変換処理メイン
  #
  def convert_main(text = nil)
    puts "ID:#{@novel_id} #{@novel_title} の変換を開始"
    sections = []
    @cover_chuki = create_cover_chuki

    converter = load_converter(@setting.archive_path)
    if text
      result = convert_text_by_load_converter(text, "textfile",  converter)
      unless @setting.enable_enchant_midashi
        @inspector.info "テキストファイルの処理を実行しましたが、改行直後の見出し付与は有効になっていません。" +
                        "setting.ini の enable_enchant_midashi を true にすることをお薦めします。"
      end
      splited = result.split("\n", 3)
      result = [splited[0], splited[1], @cover_chuki, splited[2]].join("\n")   # 表紙の挿絵注記を3行目に挟み込む
    else
      @section_save_dir = Downloader.get_novel_section_save_dir(@setting.archive_path)
      @toc = Downloader.get_toc_data(@setting.archive_path)
      progressbar = ProgressBar.new(@toc["subtitles"].count)
      @toc["subtitles"].each_with_index do |subinfo, i|
        progressbar.output(i)
        section = load_novel_section(subinfo)
        @inspector.subtitle = section["subtitle"]
        element = section["element"]
        element.each do |text_type, elm_text|
          element[text_type] = convert_text_by_load_converter(elm_text, text_type, converter)
        end
        section["subtitle"] = convert_text_by_load_converter(section["subtitle"], "subtitle",  converter)
        sections << section
      end
      progressbar.clear
      result = create_novel_text_by_template(sections)
    end

    midashi_save(result)
    inspect_novel(result)

    if @output_filename
      save_path = File.join(@setting.archive_path, File.basename(@output_filename))
    else
      if text
        info = get_title_and_author_by_text(result)
        save_filename = "[#{info["author"]}] #{info["title"]}"
      else
        save_filename = "[#{@novel_author}] #{@novel_title}"
      end
      save_path = File.join(@setting.archive_path, save_filename)
      if save_path !~ /\.\w+$/
        save_path += ".txt"
      end
    end
    File.write(save_path, result)
    puts "#{File.basename(save_path)} を出力しました"

    update_latest_convert_novel

    save_path
  end

  #
  # テキストデータ先頭二行からタイトルと作者名を取得
  #
  def get_title_and_author_by_text(text)
    title, author = text.split("\n", 3)
    { "title" => title, "author" => author }
  end

  def midashi_save(text)
    midashi_list = listup_midashi(text)
    path = File.join(@setting.archive_path, "見出しリスト.txt")
    File.write(path, midashi_list)
  end

  def inspect_novel(text)
    # 行末読点の現在状況を調査する
    @inspector.inspect_end_touten_conditions(text)
    @inspector.countup_return_in_brackets(text)

    if !@display_inspector
      unless @inspector.empty?
        puts "小説状態の調査結果を #{Inspector::INSPECT_LOG_NAME} に出力しました"
      end
    else
      # 小説の監視・検査状況を表示する
      if @inspector.error? || @inspector.warning?
        warn "―――― 小説にエラーもしくは警告が存在します ――――"
        warn ""
        @inspector.display(Inspector::ERROR | Inspector::WARNING)
        warn ""
      end
      if @inspector.info?
        warn "―――― 小説の検査状況を表示します ――――"
        warn ""
        @inspector.display(Inspector::INFO)
        warn ""
      end
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
  # 最近変換した小説IDを記録更新
  #
  def update_latest_convert_novel
    id = Downloader.get_id_by_target(@novel_title)
    LocalSetting.get["latest_convert"]["id"] = id
    LocalSetting.get.save_settings
  end

  #
  # すべての行の行末空白を削除
  #
  def rstrip_all_lines(data)
    data.gsub(/^[ 　\t]+$/, "")
  end
end
