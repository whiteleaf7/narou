# -*- coding: utf-8 -*-
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
require_relative "inventory"
require_relative "html"

class NovelConverter
  NOVEL_TEXT_TEMPLATE_NAME = "novel.txt"
  NOVEL_TEXT_TEMPLATE_NAME_FOR_IBUNKO = "ibunko_novel.txt"

  attr_reader :use_dakuten_font

  if Narou.already_init?
    @@site_settings = Downloader.load_settings
  end

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
  def self.txt_to_epub(filename, use_dakuten_font = false, dst_dir = nil, device = nil, verbose = false)
    abs_srcpath = File.expand_path(filename)
    src_dir = File.dirname(abs_srcpath)

    cover_option = ""
    # MEMO: 外部実行からだと -c FILENAME, -c 1 オプションはぬるぽが出て動かない
    cover_filename = get_cover_filename(src_dir)
    if cover_filename
      cover_option = "-c 0"   # 先頭の挿絵を表紙として利用
    end

    dst_option = ""
    if dst_dir
      dst_option = %!-dst "#{File.expand_path(dst_dir)}"!
    end

    ext_option = ""
    device_option = ""
    if device
      case device.name
      when "Kobo"
        ext_option = "-ext " + device.ebook_file_ext
      when "Kindle"
        device_option = "-device kindle"
      end
    end

    pwd = Dir.pwd

    aozoraepub3_path = Narou.get_aozoraepub3_path
    unless aozoraepub3_path
      error "AozoraEpub3が見つからなかったのでEPUBが出力出来ませんでした。" +
            "narou initでAozoraEpub3の設定を行なって下さい"
      return nil
    end
    aozoraepub3_basename = File.basename(aozoraepub3_path)
    aozoraepub3_dir = File.dirname(aozoraepub3_path)

    java_encoding = "-Dfile.encoding=UTF-8"

    if Helper.os_cygwin?
      abs_srcpath = Helper.convert_to_windows_path(abs_srcpath)
    end
    Dir.chdir(aozoraepub3_dir)
    command = %!java #{java_encoding} -cp #{aozoraepub3_basename} AozoraEpub3 -enc UTF-8 -of #{device_option} ! +
              %!#{cover_option} #{dst_option} #{ext_option} "#{abs_srcpath}"!
    if Helper.os_windows?
      command = "cmd /c " + command.encode(Encoding::Windows_31J)
    end
    stash_aozora_fonts_directory unless use_dakuten_font
    print "AozoraEpub3でEPUBに変換しています"
    begin
      res = Helper::AsyncCommand.exec(command) do
        print "."
      end
    ensure
      visible_aozora_fonts_directory unless use_dakuten_font
      Dir.chdir(pwd)
    end

    stdout_capture = res[0]

    if verbose
      puts
      puts "==== AozoraEpub3 stdout capture " + "=" * 47
      puts stdout_capture.strip
      puts "=" * 79
    end

    error_list = stdout_capture.scan(/^(?:\[ERROR\]|エラーが発生しました :).+$/)
    warn_list = stdout_capture.scan(/^\[WARN\].+$/)
    info_list = stdout_capture.scan(/^\[INFO\].+$/)
    if !error_list.empty? || !warn_list.empty? || !info_list.empty?
      puts
      puts error_list, warn_list, info_list
      unless error_list.empty?
        # AozoraEpub3 のエラーにはEPUBが出力されないエラーとEPUBが出力されるエラーの2種類ある。
        # EPUBが出力される場合は「変換完了」という文字があるのでそれを検出する
        if stdout_capture !~ /^変換完了/
          error "AozoraEpub3実行中にエラーが発生したため、EPUBが出力出来ませんでした"
          return :error
        end
      end
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
  def self.epub_to_mobi(epub_path, verbose = false)
    kindlegen_path = File.join(File.dirname(Narou.get_aozoraepub3_path), "kindlegen")
    if Dir.glob(kindlegen_path + "*").empty?
      error "kindlegenが見つかりませんでした。AozoraEpub3と同じディレクトリにインストールして下さい"
      return :error
    end

    if Helper.os_cygwin?
      epub_path = Helper.convert_to_windows_path(epub_path)
    end
    command = %!"#{kindlegen_path}" -locale ja "#{epub_path}"!
    if Helper.os_windows?
      command.encode!(Encoding::Windows_31J)
    end
    print "kindlegen実行中"
    res = Helper::AsyncCommand.exec(command) do
      print "."
    end
    stdout_capture, _, proccess_status = res
    stdout_capture.force_encoding(Encoding::UTF_8)

    if verbose
      puts
      puts "==== kindlegen stdout capture " + "=" * 49
      puts stdout_capture.gsub("\n\n", "\n").strip
      puts "=" * 79
    end

    if proccess_status.exited?
      if proccess_status.exitstatus == 2
        puts ""
        error "kindlegen実行中にエラーが発生したため、MOBIが出力出来ませんでした"
        if stdout_capture.scan(/(エラー\(.+?\):\w+?:.+)$/)
          error $1
        end
        return :error
      end
    else
      puts ""
      error "kindlegenが中断させられたぽいのでMOBIは出力出来ませんでした"
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
    file_subtitle = subtitle_info["file_subtitle"] || subtitle_info["subtitle"]   # 互換性維持のため
    path = File.join(@section_save_dir, "#{subtitle_info["index"]} #{file_subtitle}.yaml")
    YAML.load_file(path)
  end

  def create_novel_text_by_template(sections)
    toc = @toc
    cover_chuki = @cover_chuki
    device = Narou.get_device
    setting = @setting
    processed_title = toc["title"]
    data = Database.instance.get_data("id", @novel_id)
    # タイトルに新着更新日を付加する
    if @setting.enable_add_date_to_title
      new_arrivals_date = data["new_arrivals_date"] || data["last_update"]
      date_str = new_arrivals_date.strftime(@setting.title_date_format)
      if @setting.title_date_align == "left"
        processed_title = date_str + processed_title
      else  # right
        processed_title += date_str
      end
    end
    # タイトルに完結したかどうかを付加する
    flags = data["flags"] || {}
    if flags["end"]
      processed_title += " (完結)"
    end
    # タイトルがルビ化されてしまうのを抑制
    toc["title"] = toc["title"].gsub("《", "※［＃始め二重山括弧］").gsub("》", "※［＃終わり二重山括弧］")
    tempalte_name = (device && device.ibunko? ? NOVEL_TEXT_TEMPLATE_NAME_FOR_IBUNKO : NOVEL_TEXT_TEMPLATE_NAME)
    Template.get(tempalte_name, binding)
  end

  #
  # 表紙用の画像名取得
  #
  def self.get_cover_filename(archive_path)
    [".jpg", ".png", ".jpeg"].each do |ext|
      filename = "cover#{ext}"
      cover_path = File.join(archive_path, filename)
      if File.exists?(cover_path)
        return filename
      end
    end
    nil
  end

  #
  # 表紙用挿絵注記作成
  #
  def create_cover_chuki
    cover_filename = self.class.get_cover_filename(@setting.archive_path)
    if cover_filename
      "［＃挿絵（#{cover_filename}）入る］"
    else
      ""
    end
  end

  def find_site_setting
    @@site_settings.find { |s| s.multi_match(@toc["toc_url"], "url") }
  end

  #
  # 変換処理メイン
  #
  def convert_main(text = nil)
    print "ID:#{@novel_id}　" if @novel_id
    puts "#{@novel_title} の変換を開始"
    sections = []
    @cover_chuki = create_cover_chuki

    conv = load_converter(@novel_title, @setting.archive_path).new(@setting, @inspector, @illustration)
    if text
      result = conv.convert(text, "textfile")
      unless @setting.enable_enchant_midashi
        @inspector.info "テキストファイルの処理を実行しましたが、改行直後の見出し付与は有効になっていません。" +
                        "setting.ini の enable_enchant_midashi を true にすることをお薦めします。"
      end
      splited = result.split("\n", 3)
      result = [splited[0], splited[1], @cover_chuki, splited[2]].join("\n")   # 表紙の挿絵注記を3行目に挟み込む
    else
      @section_save_dir = Downloader.get_novel_section_save_dir(@setting.archive_path)
      @toc = Downloader.get_toc_data(@setting.archive_path)
      @toc["story"] = conv.convert(@toc["story"], "story")
      html = HTML.new
      site_setting = find_site_setting
      html.set_illust_setting(current_url: site_setting["illust_current_url"],
                              grep_pattern: site_setting["illust_grep_pattern"])
      progressbar = ProgressBar.new(@toc["subtitles"].count)
      @toc["subtitles"].each_with_index do |subinfo, i|
        progressbar.output(i)
        section = load_novel_section(subinfo)
        if section["chapter"].length > 0
          section["chapter"] = conv.convert(section["chapter"], "chapter")
        end
        @inspector.subtitle = section["subtitle"]
        element = section["element"]
        data_type = element.delete("data_type") || "text"
        element.each do |text_type, elm_text|
          if data_type == "html"
            html.string = elm_text
            elm_text = html.to_aozora
          end
          element[text_type] = conv.convert(elm_text, text_type)
        end
        section["subtitle"] = conv.convert(section["subtitle"], "subtitle")
        sections << section
      end
      progressbar.clear
      result = create_novel_text_by_template(sections)
    end

    @use_dakuten_font = conv.use_dakuten_font
    conv.replace_by_replace_txt(result)

    midashi_save(result)
    inspect_novel(result)

    if @output_filename
      save_path = File.join(@setting.archive_path, File.basename(@output_filename))
    else
      if text
        info = get_title_and_author_by_text(result)
      else
        info = { "author" => @novel_author, "title" => @novel_title }
      end
      save_filename = Narou.create_novel_filename(info)
      save_path = File.join(@setting.archive_path, save_filename)
      if save_path !~ /\.\w+$/
        save_path += ".txt"
      end
    end
    File.write(save_path, result)
    puts "縦書用の変換が終了しました"

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
        puts "<bold><yellow>―――― 小説にエラーもしくは警告が存在します ――――</yellow></bold>".termcolor
        puts ""
        @inspector.display(Inspector::ERROR | Inspector::WARNING)
        puts ""
      end
      if @inspector.info?
        puts "<bold><yellow>―――― 小説の検査状況を表示します ――――</yellow></bold>".termcolor
        puts ""
        @inspector.display(Inspector::INFO)
        puts ""
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
    Inventory.load("latest_convert", :local).tap { |inv|
      inv["id"] = id
      inv.save
    }
  end
end
