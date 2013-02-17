# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "fileutils"
require_relative "narou"
require_relative "sitesetting"
require_relative "template"
require_relative "database"
require_relative "localsetting"

#
# 小説サイトからのダウンロード
#
class Downloader
  NOVEL_SITE_SETTING_DIR = "webnovel/"
  SECTION_SAVE_DIR_NAME = "本文"    # 本文を保存するディレクトリの名前
  CACHE_SAVE_DIR_NAME = "cache"   # 差分用キャッシュ保存用ディレクトリの名前
  TOC_FILE_NAME = "toc.yaml"
  WAITING_TIME_FOR_503 = 20   # 503 のときに待機する秒数
  RETRY_MAX_FOR_503 = 5   # 503 のときに何回再試行するか

  attr_reader :id

  #
  # ターゲット(ID、URL、Nコード、小説名)を指定して小説データのダウンロードを開始する
  #
  # force が true なら全話強制ダウンロード
  #
  def self.start(target, force = false)
    setting = nil
    target = Narou.alias_to_id(target)
    case type = get_target_type(target)
    when :url, :ncode
      setting = get_sitesetting_by_target(target)
      unless setting
        warn "対応外の#{type}です(#{target})"
        return false
      end
    when :id
      data = @@database[target.to_i]
      unless data
        warn "指定のID(#{target})は存在しません"
        return false
      end
      setting = get_sitesetting_by_sitename(data["sitename"])
      setting.multi_match(data["toc_url"], "url")
    when :other
      detected = false
      data = @@database.get_data("title", target)
      if data
        setting = get_sitesetting_by_sitename(data["sitename"])
        setting.multi_match(data["toc_url"], "url")
      else
        warn "指定の小説(#{target})は存在しません"
        return false
      end
    end
    downloader = Downloader.new(setting)
    result = downloader.start_download(force)
    setting.clear
    result
  end

  #
  # 小説サイト設定を取得する
  #
  def self.get_sitesetting_by_target(target)
    toc_url = get_toc_url(target)
    setting = nil
    if toc_url
      setting = @@settings.find { |s| s.multi_match(toc_url, "url") }
    end
    setting
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
    when /^\d+$/, Fixnum
      :id
    else
      :other
    end
  end

  #
  # 指定されたIDとかから小説の保存ディレクトリを取得
  #
  def self.get_novel_data_dir_by_target(target)
    target = Narou.alias_to_id(target)
    type = get_target_type(target)
    data = nil
    id = nil
    case type
    when :url, :ncode
      toc_url = get_toc_url(target)
      data = @@database.get_data("toc_url", toc_url)
      id = data["id"]
    when :other
      data = @@database.get_data("title", target)
      id = data["id"]
    when :id
      id = target.to_i
      data = @@database[id]
    end
    return nil unless data
    path = File.join(Database.archive_root_path, data["sitename"], data["title"])
    if File.exists?(path)
      return path
    else
      @@database.delete(id)
      @@database.save_database
      warn "#{path} が見つかりません。"
      warn "保存ディレクトリが消去されていたため、管理リストから削除しました。"
      return nil
    end
  end

  #
  # target のIDを取得
  #
  def self.get_id_by_target(target)
    target = Narou.alias_to_id(target)
    toc_url = get_toc_url(target) or return nil
    @@database.get_id("toc_url", toc_url)
  end

  #
  # target からデータベースのデータを取得
  #
  def self.get_data_by_target(target)
    target = Narou.alias_to_id(target)
    toc_url = get_toc_url(target) or return nil
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
  # targetがURLかNコードの場合、実際には小説が存在しないURLが返ってくることがあるのを留意する
  #
  def self.get_toc_url(target)
    target = Narou.alias_to_id(target)
    case get_target_type(target)
    when :url
      setting = @@settings.find { |s| s.multi_match(target, "url") }
      return setting["toc_url"] if setting
    when :ncode
      @@database.each do |_, data|
        if data["toc_url"] =~ %r!#{target}/$!
          return data["toc_url"]
        end
      end
      return "#{@@narou["domain"]}/#{target}/"
    when :id
      data = @@database[target.to_i]
      return data["toc_url"] if data
    when :other
      data = @@database.get_data("title", target)
      return data["toc_url"] if data
    end
    nil
  end

  def self.novel_exists?(target)
    target = Narou.alias_to_id(target)
    id = get_id_by_target(target) or return nil
    @@database.novel_exists?(id)
  end

  def self.remove_novel(target, with_file = false)
    target = Narou.alias_to_id(target)
    data = get_data_by_target(target) or return nil
    data_dir = get_novel_data_dir_by_target(target)
    if with_file
      FileUtils.remove_entry_secure(data_dir)
      puts "#{data_dir} を完全に削除しました"
    else
      # TOCは消しておかないと再DL時に古いデータがあると誤認する
      File.delete(File.join(data_dir, TOC_FILE_NAME))
    end
    @@database.delete(data["id"])
    @@database.save_database
    data["title"]
  end

  def self.get_sitesetting_by_sitename(sitename)
    setting = @@settings.find { |s| s["name"] == sitename }
    return setting if setting
    warn "#{data["sitename"]} の設定ファイルが見つかりません"
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
      warn "小説サイトの定義ファイルがひとつもありません"
      exit 1
    end
    unless @@narou
      warn "小説家になろうの定義ファイルが見つかりませんでした"
      exit 1
    end
    settings
  end

  #
  # 差分用キャッシュのディレクトリ一覧取得
  #
  def self.get_cache_list(target)
    novel_data_dir = get_novel_data_dir_by_target(target)
    save_dir = File.join(novel_data_dir, SECTION_SAVE_DIR_NAME, CACHE_SAVE_DIR_NAME)
    Dir.glob("#{save_dir}/*")
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
      warn "目次データが取得出来ませんでした"
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
      @cache_dir = create_cache_dir if old_toc.length > 0
      sections_download_and_save(update_subtitles)
      update_database
      save_novel_data(TOC_FILE_NAME, latest_toc)
      return true
    else
      return false
    end
  end

  #
  # 差分用キャッシュ保存ディレクトリ作成
  #
  def create_cache_dir
    now = Time.now
    name = now.strftime("%Y%m%d%H%M%S#{now.usec.to_s[0, 3]}")
    cache_dir = File.join(get_novel_data_dir, SECTION_SAVE_DIR_NAME, CACHE_SAVE_DIR_NAME, name)
    FileUtils.mkdir_p(cache_dir)
    cache_dir
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
        if toc_fp.base_uri.to_s != toc_url
          # リダイレクトされた場合。
          # ノクターン・ムーンライトのNコードを ncode.syosetu.com に渡すと、novel18.syosetu.com に飛ばされる
          # 目次の定義が微妙に ncode.syosetu.com と違うので、設定を取得し直す
          @setting.clear
          @setting = Downloader.get_sitesetting_by_target(toc_fp.base_uri.to_s)
          toc_url = @setting["toc_url"]
        end
        toc_source = pretreatment_source(toc_fp.read)
      end
    rescue OpenURI::HTTPError => e
      if e.message =~ /^404/
        warn "指定されたURLは存在しません"
        return false
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
    max = subtitles.count
    return if max == 0
    puts @title + " のDL開始"
    interval_sleep_time = LocalSetting.get["local_setting"]["download.interval"] || 0
    interval_sleep_time = 0 if interval_sleep_time < 0
    subtitles.each_with_index do |subtitle_info, i|
      if interval_sleep_time > 0
        sleep(interval_sleep_time) if i > 0
      elsif @setting["domain"] =~ /syosetu.com/
        # 小説家になろうは連続DL規制があるため、ウェイトを入れる必要がある
        # 10話ごとに規制が入るため、10話ごとにウェイトを挟む
        sleep(6) if i % 10 == 0 && i >= 10
      end
      index, subtitle = subtitle_info["index"], subtitle_info["subtitle"]
      puts "第#{index}部分　#{subtitle} (#{i+1}/#{max})"
      section_element = a_section_download(subtitle_info)
      info = subtitle_info.dup
      info["element"] = section_element
      section_file_name = "#{index} #{subtitle}.yaml"
      section_file_path = File.join(SECTION_SAVE_DIR_NAME, section_file_name)
      move_to_cache_dir(section_file_path)
      save_novel_data(section_file_path, info)
    end
  end

  #
  # 差分用のキャッシュとして保存
  #
  def move_to_cache_dir(relative_path)
    path = File.join(get_novel_data_dir, relative_path)
    if File.exists?(path)
      FileUtils.mv(path, @cache_dir)
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
          warn "上限までリトライしましたがファイルがダウンロード出来ませんでした"
          exit 1
        end
        retry_count -= 1
        warn "server message: #{e.message}"
        warn "リトライ待機中……"
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
      FileUtils.mkdir_p(dir_path)
    end
    File.write(path, YAML.dump(object))
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
    FileUtils.mkdir_p(dir_path) unless File.exists?(dir_path)
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

  ENTITIES = { quot: '"', amp: "&", nbsp: " ", lt: "<", gt: ">", copy: "(c)" }
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
