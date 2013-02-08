# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "fileutils"
require_relative "narou"
require_relative "sitesetting"
require_relative "template"
require_relative "database"

#
# 小説サイトからのダウンロード
#
class Downloader
  NOVEL_SITE_SETTING_DIR = "webnovel/"
  SECTION_SAVE_DIR_NAME = "本文"    # 本文を保存するディレクトリの名前(否パス)
  TOC_FILE_NAME = "toc.yaml"
  WAITING_TIME_FOR_503 = 20   # 503 のときに待機する秒数
  RETRY_MAX_FOR_503 = 5   # 503 のときに何回再試行するか

  #
  # ターゲット(ID、URL、Nコード、小説名)を指定して小説データのダウンロードを開始する
  #
  # force が true なら全話強制ダウンロード
  #
  def self.start(target, force = false)
    setting = nil
    case get_target_type(target)
    when :url, :ncode
      toc_url = get_toc_url(target)
      setting = @@settings.find { |s| s.multi_match(toc_url, "url") }
      unless setting
        puts "対応外のURLです(#{target})"
        exit 1
      end
    when :id
      data = @@database[target.to_i]
      unless data
        puts "指定のID(#{target})は存在しません"
        exit 1
      end
      setting = get_setting(data["sitename"])
      setting.multi_match(data["toc_url"], "url")
    when :other
      detected = false
      data = @@database.get_data_by_type("title", target)
      if data
        setting = get_setting(data["sitename"])
        setting.multi_match(data["toc_url"], "url")
      else
        puts "指定の小説(#{target})は存在しません"
        exit 1
      end
    end
    downloader = Downloader.new(setting)
    result = downloader.start_download(force)
    setting.clear
    result
  end

  #
  # 本文格納用ディレクトリを取得
  #
  def self.get_novel_section_save_dir(archive_path)
    File.join(archive_path, SECTION_SAVE_DIR_NAME)
  end

  #
  # target の種別を判別する
  #
  def self.get_target_type(target)
    case target
    when URI.regexp
      :url
    when /^n\d+[a-z]+$/
      :ncode
    when /^\d+$/
      :id
    else
      :other
    end
  end

  #
  # 指定されたIDとかから小説の保存ディレクトリを取得
  #
  def self.get_novel_data_dir_by_target(target)
    type = get_target_type(target)
    data = nil
    id = nil
    case type
    when :url, :ncode
      toc_url = get_toc_url(target)
      @@database.each do |i, d|
        if d["toc_url"] == toc_url
          id = i
          data = d
          break
        end
      end
    when :other
      @@database.each do |i, d|
        if d["title"] == target
          id = i
          data = d
          break
        end
      end
    when :id
      id = target.to_i
      data = @@database[target.to_i]
    end
    return nil unless data
    path = File.join(Database.archive_root_path, data["sitename"], data["title"])
    if File.exists?(path)
      return path
    else
      @@database.delete(id)
      save_database
      puts "#{path} が見つかりません。"
      puts "保存ディレクトリが消去されていたため、管理リストから削除しました。"
      return nil
    end
  end

  #
  # target のIDを取得
  #
  def self.get_id_by_database(target)
    toc_url = get_toc_url(target)
    @@database.get_id("toc_url", toc_url)
  end

  #
  # target からデータベースのデータを取得
  #
  def self.get_data_by_database(target)
    toc_url = get_toc_url(target)
    @@database.get_data("toc_url", toc_url)
  end

  #
  # toc 読込
  #
  def self.get_toc_data(archive_path)
    YAML.load_file(File.join(archive_path, TOC_FILE_NAME))
  end

  #
  # 指定の小説の目次ページのURLを取得する
  #
  # 書式にのっとって生成しているだけで、存在しないURLが返ってくる可能性もある
  #
  def self.get_toc_url(target)
    case get_target_type(target)
    when :url
      setting = @@setting.find { |s| s.multi_match(target, "url") }
      return setting["toc_url"] if setting
    when :ncode
      return "#{@@narou["domain"]}/#{target}/"
    when :id
      data = @@database[target.to_i]
      if data
        return data["toc_url"]
      end
    when :other
      @@database.each do |id, data|
        if data["title"] == target
          return data["toc_url"]
        end
      end
    end
    nil
  end

  def self.novel_exists?(target)
    id = get_id_by_database(target) or return nil
    @@database.novel_exists?(id)
  end

  def self.get_setting(sitename)
    setting = @@settings.find { |s| s["name"] == sitename }
    return setting if setting
    puts "#{data["sitename"]} の設定ファイルが見つかりません"
    exit 1
  end

  #
  # 小説サイトの定義ファイルを全部読み込む
  #
  def self.load_settings
    settings = []
    Dir.glob(File.join(Narou.get_script_dir, NOVEL_SITE_SETTING_DIR, "*.yaml")) do |path|
      setting = SiteSetting.load_file(path)
      if setting["name"] == "小説家になろう"
        @@narou = setting
      end
      settings << setting
    end
    if settings.empty?
      puts "小説サイトの定義ファイルがひとつもありません"
      exit 1
    end
    unless @@narou
      puts "小説家になろうの定義ファイルが見つかりませんでした"
      exit 1
    end
    settings
  end

  if Narou.already_init?
    @@settings = load_settings
    @@database = Database.instance
  end

  #
  # コンストラクタ
  #
  def initialize(site_setting)
    @setting = site_setting
    @id = @@database.get_id("toc_url", @setting["toc_url"]) || @@database.get_new_id
  end

  #
  # ダウンロード処理本体
  #
  # force が true なら全話強制ダウンロード
  # 返り値：ダウンロードしたものが１話でもあったかどうか(Boolean)
  #
  def start_download(force = false)
    latest_toc = get_latest_table_of_contents
    unless latest_toc
      puts "目次データが取得出来ませんでした"
      exit 1
    end
    old_toc = load_novel_data(TOC_FILE_NAME)
    unless old_toc
      init_novel_dir
      old_toc = {}
    end
    if force
      update_subtitles = latest_toc["subtitles"]
    else
      update_subtitles = update_check(old_toc["subtitles"], latest_toc["subtitles"])
    end
    if update_subtitles.count > 0
      update_database
      save_novel_data(TOC_FILE_NAME, latest_toc)
      sections_download_and_save(update_subtitles)
      return true
    else
      return false
    end
  end

  #
  # データベース更新
  #
  def update_database
    @@database[@id] = {
      "id" => @id,
      "author" => @setting["author"],
      "title" => @setting["title"],
      "toc_url" => @setting["toc_url"],
      "sitename" => @setting["name"],
      "last_update" => Time.now
    }
    @@database.save_database
  end

  #
  # 目次データを取得する
  #
  def get_latest_table_of_contents
    toc_url = @setting["toc_url"]
    return nil unless toc_url
    toc_source = ""
    begin
      open(toc_url) do |toc_fp|
        toc_source = pretreatment_source(toc_fp.read)
      end
    rescue OpenURI::HTTPError => e
      if e.message =~ /^404/
        puts "指定された小説は存在しません"
        exit 1
      else
        raise
      end
    end
    @setting.multi_match(toc_source, "title", "author", "story", "tcode")
    @title = @setting["title"]
    toc_objects = {
      "title" => @title,
      "author" => @setting["author"],
      "toc_url" => @setting["toc_url"],
      "story" => @setting["story"],
      "subtitles" => get_subtitles(toc_source)
    }
    toc_objects
  end

  #
  # 更新チェック
  #
  # 更新された subtitle だけまとまった配列を返す
  #
  def update_check(old_subtitles, latest_subtitles)
    return latest_subtitles unless old_subtitles
    latest_subtitles.dup.keep_if do |latest|
      index = latest["index"]
      index_in_old_toc = old_subtitles.index { |item| item["index"] == index }
      next true unless index_in_old_toc
      old = old_subtitles[index_in_old_toc]
      old_subupdate = old["subupdate"]
      latest_subupdate = latest["subupdate"]
      if old_subupdate == ""
        next latest_subupdate != ""
      end
      latest_subupdate > old_subupdate
    end
  end

  #
  # 各話の情報を取得
  #
  def get_subtitles(toc_source)
    subtitles = []
    toc_post = toc_source.dup
    loop do
      match_data = @setting.multi_match(toc_post, "subtitles")
      break unless match_data
      toc_post = match_data.post_match
      subtitles << {
        "index" => @setting["index"],
        "href" => @setting["href"],
        "chapter" => @setting["chapter"],
        "subtitle" => @setting["subtitle"],
        "subdate" => @setting["subdate"],
        "subupdate" => @setting["subupdate"]
      }
    end
    subtitles
  end

  #
  # 小説本文をまとめてダウンロードして保存
  #
  # subtitles にダウンロードしたいものをまとめた subtitle info を渡す
  #
  def sections_download_and_save(subtitles)
    puts "hogehogehoge"
    max = subtitles.count
    return if max == 0
    puts @title
    subtitles.each_with_index do |subtitle_info, i|
      if @setting == @@narou
        # 小説家になろうは連続DL規制があるため、ウェイトを入れる必要がある
        if i % 10 == 0 && i >= 10
          sleep(6)
        end
      end
      index, subtitle = subtitle_info["index"], subtitle_info["subtitle"]
      puts "第#{index}部分　#{subtitle} (#{i+1}/#{max})"
      section_element = a_section_download(subtitle_info)
      subtitle_info["element"] = section_element
      save_novel_data(File.join(SECTION_SAVE_DIR_NAME, "#{index} #{subtitle}.yaml"), subtitle_info)
    end
  end

  #
  # 指定された話数の本文をダウンロード
  #
  def a_section_download(subtitle_info)
    href = subtitle_info["href"]
    if @setting["tcode"]
      subtitle_url = @setting.replace_group_values("txtdownload_url", subtitle_info)
    elsif href[0] == "/"
      subtitle_url = @setting["domain"] + href
    else
      subtitle_url = @setting["toc_url"] + href
    end
    section = nil
    retry_count = RETRY_MAX_FOR_503
    begin
      open(subtitle_url) do |fp|
        section = pretreatment_source(fp.read)
      end
    rescue OpenURI::HTTPError => e
      if e.message =~ /^503/
        if retry_count == 0
          puts "上限までリトライしましたがファイルがダウンロード出来ませんでした"
          exit 1
        end
        retry_count -= 1
        puts "server message: #{e.message}"
        puts "リトライ待機中……"
        sleep(WAITING_TIME_FOR_503)
        retry
      else
        raise
      end
    end
    element = extract_elements_in_section(section, subtitle_info["subtitle"])
    element
  end

  #
  # 本文を解析して前書き・本文・後書きの要素に分解する
  #
  # 本文に含まれるタイトルは消す
  #
  def extract_elements_in_section(section, subtitle)
    lines = section.lines.map(&:rstrip)
    introduction = slice_introduction(lines)
    postscript = slice_postscript(lines)
    if lines[0] == subtitle
      if lines[1] == ""
        lines.slice!(0, 2)
      else
        lines.slice!(0, 1)
      end
    end
    {
      "introduction" => introduction,
      "body" => lines.join("\n"),
      "postscript" => postscript
    }
  end

  def slice_introduction(lines)
    lines.each_with_index do |line, lineno|
      if line =~ ConverterBase::AUTHOR_INTRODUCTION_SPLITTER
        lines.slice!(lineno, 1)
        return lines.slice!(0...lineno).join("\n")
      end
    end
    ""
  end

  def slice_postscript(lines)
    lines.each_with_index do |line, lineno|
      if line =~ ConverterBase::AUTHOR_POSTSCRIPT_SPLITTER
        lines.slice!(lineno, 1)
        return lines.slice!(lineno..-1).join("\n")
      end
    end
    ""
  end

  #
  # 小説データの格納ディレクトリパス
  def get_novel_data_dir
    raise "小説名がまだ設定されていません" unless @title
    File.join(Database.archive_root_path, @setting["name"], @title)
  end

  #
  # 小説データの格納ディレクトリに保存
  #
  def save_novel_data(filename, object)
    path = File.join(get_novel_data_dir, filename)
    dir_path = File.dirname(path)
    unless File.exists?(dir_path)
      FileUtils.mkdir(dir_path)
    end
    open(path, "w") do |fp|
      fp.write(YAML.dump(object))
    end
  end

  #
  # 小説データの格納ディレクトリから読み込む
  def load_novel_data(filename)
    dir_path = get_novel_data_dir
    YAML.load_file(File.join(dir_path, filename))
  rescue Errno::ENOENT
    nil
  end

  #
  # 小説データの格納ディレクトリを初期設定する
  #
  def init_novel_dir
    dir_path = get_novel_data_dir
    return if File.exists?(dir_path)
    FileUtils.mkdir_p(dir_path)
    default_settings = NovelSetting::DEFAULT_SETTINGS
    Template.write(NovelSetting::INI_NAME, dir_path, binding)
    Template.write("converter.rb", dir_path, binding)
  end

  #
  # ダウンロードしてきたデータを使いやすいように処理
  #
  def pretreatment_source(src)
    restor_entity(src.force_encoding(@setting["encoding"])).gsub("\r", "")
  end

  ENTITIES = { quot: '"', amp: "&", nbsp: " ", lt: "<", gt: ">", copy: "c" }
  #
  # エンティティ復号
  #
  def restor_entity(str)
    result = str.dup
    ENTITIES.each do |key, value|
      result.gsub!("&#{key};", value)
    end
    result
  end
end

if __FILE__ == $0
  Encoding.default_external = Encoding::UTF_8
  Downloader.start "http://ncode.syosetu.com/n4259s/1/"
end
