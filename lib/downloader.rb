# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "yaml"
require "fileutils"
require "ostruct"
require_relative "narou"
require_relative "sitesetting"
require_relative "template"
require_relative "database"
require_relative "localsetting"
require_relative "narou/api"
require_relative "html"

#
# 小説サイトからのダウンロード
#
class Downloader
  NOVEL_SITE_SETTING_DIR = "webnovel/"
  SECTION_SAVE_DIR_NAME = "本文"    # 本文を保存するディレクトリ名
  CACHE_SAVE_DIR_NAME = "cache"   # 差分用キャッシュ保存用ディレクトリ名
  RAW_DATA_DIR_NAME = "raw"    # 本文の生データを保存するディレクトリ名
  TOC_FILE_NAME = "toc.yaml"
  STEPS_WAIT_TIME = 5   # 数話ごとにかかるwaitの秒数
  WAITING_TIME_FOR_503 = 20   # 503 のときに待機する秒数
  RETRY_MAX_FOR_503 = 5   # 503 のときに何回再試行するか
  NOVEL_TYPE_SERIES = 1   # 連載
  NOVEL_TYPE_SS = 2       # 短編
  DISPLAY_LIMIT_DIGITS = 4   # indexの表示桁数限界

  attr_reader :id

  #
  # ターゲット(ID、URL、Nコード、小説名)を指定して小説データのダウンロードを開始する
  #
  # force が true なら全話強制ダウンロード
  #
  def self.start(target, force = false, from_download = false)
    setting = nil
    target = Narou.alias_to_id(target)
    case type = get_target_type(target)
    when :url, :ncode
      setting = get_sitesetting_by_target(target)
      unless setting
        error "対応外の#{type}です(#{target})"
        return false
      end
    when :id
      data = @@database[target.to_i]
      unless data
        error "指定のID(#{target})は存在しません"
        return false
      end
      setting = get_sitesetting_by_sitename(data["sitename"])
      setting.multi_match(data["toc_url"], "url")
    when :other
      data = @@database.get_data("title", target)
      if data
        setting = get_sitesetting_by_sitename(data["sitename"])
        setting.multi_match(data["toc_url"], "url")
      else
        error "指定の小説(#{target})は存在しません"
        return false
      end
    end
    downloader = Downloader.new(setting, force, from_download)
    result = downloader.start_download
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
  # ncodeの場合、targetを破壊的に変更する
  #
  def self.get_target_type(target)
    case target
    when URI.regexp
      :url
    when /^n\d+[a-z]+$/i
      target.downcase!
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
    when :other
      data = @@database.get_data("title", target)
    when :id
      data = @@database[target.to_i]
    end
    return nil unless data
    id = data["id"]
    file_title = data["file_title"] || data["title"]   # 互換性維持のための処理
    path = File.join(Database.archive_root_path, data["sitename"], file_title)
    if File.exists?(path)
      return path
    else
      @@database.delete(id)
      @@database.save_database
      error "#{path} が見つかりません。"
      warn "保存フォルダが消去されていたため、データベースのインデックスを削除しました。"
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
      return "#{@@narou["top_url"]}/#{target}/"
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
      FileUtils.remove_entry_secure(data_dir, true)
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
    error "#{sitename} の設定ファイルが見つかりません"
    exit 1
  end

  #
  # 小説サイトの定義ファイルを全部読み込む
  #
  def self.load_settings
    settings = @@__settings_cache ||= []
    return settings unless settings.empty?
    Dir.glob(File.join(Narou.get_script_dir, NOVEL_SITE_SETTING_DIR, "*.yaml")) do |path|
      setting = SiteSetting.load_file(path)
      if setting["name"] == "小説家になろう"
        @@narou = setting
      end
      settings << setting
    end
    if settings.empty?
      error "小説サイトの定義ファイルがひとつもありません"
      exit 1
    end
    unless @@narou
      error "小説家になろうの定義ファイルが見つかりませんでした"
      exit 1
    end
    settings
  end

  #
  # 差分用キャッシュの保存ディレクトリ取得
  #
  def self.get_cache_root_dir(target)
    dir = get_novel_data_dir_by_target(target)
    if dir
      return File.join(dir, SECTION_SAVE_DIR_NAME, CACHE_SAVE_DIR_NAME)
    end
    nil
  end

  #
  # 差分用キャッシュのディレクトリ一覧取得
  #
  def self.get_cache_list(target)
    dir = get_cache_root_dir(target)
    if dir
      return Dir.glob("#{dir}/*")
    end
    nil
  end

  if Narou.already_init?
    @@settings = load_settings
    @@database = Database.instance
  end

  #
  # コンストラクタ
  #
  def initialize(site_setting, force = false, from_download = false)
    @title = nil
    @file_title = nil
    @setting = site_setting
    @force = force
    @from_download = from_download
    @cache_dir = nil
    @new_arrivals = false
    @novel_type = nil
    @novel_data_dir = nil
    @id = @@database.get_id("toc_url", @setting["toc_url"]) || @@database.get_new_id
  end

  #
  # 18歳以上か確認する
  #
  def confirm_over18?
    global_setting = GlobalSetting.get["global_setting"]
    if global_setting.include?("over18")
      return global_setting["over18"]
    end
    if Helper.confirm("年齢認証：あなたは18歳以上ですか")
      global_setting["over18"] = true
      GlobalSetting.get.save_settings
      return true
    else
      return false
    end
  end


  #
  # ダウンロードを処理本体を起動
  #
  def start_download
    @status = run_download
    OpenStruct.new(
      :id => @id,
      :new_arrivals => @new_arrivals,
      :status => @status
      ).freeze
  end

  #
  # ダウンロード処理本体
  #
  def run_download
    latest_toc = get_latest_table_of_contents
    unless latest_toc
      error @setting["toc_url"] + " の目次データが取得出来ませんでした"
      return :failed
    end
    if @setting["confirm_over18"]
      unless confirm_over18?
        puts "18歳以上のみ閲覧出来る小説です。ダウンロードを中止しました"
        return :canceled
      end
    end
    old_toc = load_novel_data(TOC_FILE_NAME)
    unless old_toc
      init_novel_dir
      old_toc = {}
      @new_arrivals = true
    end
    init_raw_dir
    if @force
      update_subtitles = latest_toc["subtitles"]
    else
      update_subtitles = update_body_check(old_toc["subtitles"], latest_toc["subtitles"])
    end
    if update_subtitles.count > 0
      unless @force
        if process_digest(old_toc, latest_toc)
          return :canceled
        end
      end
      @cache_dir = create_cache_dir if old_toc.length > 0
      begin
        sections_download_and_save(update_subtitles)
      rescue Interrupt
        remove_cache_dir
        puts "ダウンロードを中断しました"
        exit 1
      end
      update_database
      save_novel_data(TOC_FILE_NAME, latest_toc)
      return :ok
    else
      return :none
    end
  ensure
    @setting.clear
  end

  #
  # ダイジェスト化に関する処理
  #
  def process_digest(old_toc, latest_toc)
    return false unless old_toc["subtitles"]
    latest_subtitles_count = latest_toc["subtitles"].count
    old_subtitles_count = old_toc["subtitles"].count
    if latest_subtitles_count < old_subtitles_count
      STDOUT.puts "#{latest_toc["title"]}"
      STDOUT.puts "更新後の話数が保存されている話数より減少していることを検知しました"
      STDOUT.puts "ダイジェスト化されている可能性があるので、更新に関しての処理を選択して下さい"
      digest_output_interface(old_subtitles_count, latest_subtitles_count)
      while input = $stdin.gets
        case input[0]
        when "1"
          return false
        when "2"
          return true
        when "3"
          Command::Freeze.execute!([old_toc["title"]])
          return true
        when "4"
          STDOUT.puts "あらすじ"
          STDOUT.puts latest_toc["story"]
        when "5"
          Helper.open_browser(latest_toc["toc_url"])
        end
        digest_output_interface(old_subtitles_count, latest_subtitles_count)
      end
    else
      return false
    end
  end

  def digest_output_interface(old_subtitles_count, latest_subtitles_count)
    STDOUT.puts
    STDOUT.puts "保存済み話数: #{old_subtitles_count}\n更新後の話数: #{latest_subtitles_count}"
    STDOUT.puts
    STDOUT.puts "1: このまま更新する"
    STDOUT.puts "2: 更新をキャンセル"
    STDOUT.puts "3: 更新をキャンセルして小説を凍結する"
    STDOUT.puts "4: 最新のあらすじを表示する"
    STDOUT.puts "5: 小説ページを開く"
    STDOUT.print "選択する処理の番号を入力: "
  end

  #
  # 差分用キャッシュ保存ディレクトリ作成
  #
  def create_cache_dir
    now = Time.now
    name = now.strftime("%Y.%m.%d@%H;%M;%S")
    cache_dir = File.join(get_novel_data_dir, SECTION_SAVE_DIR_NAME, CACHE_SAVE_DIR_NAME, name)
    FileUtils.mkdir_p(cache_dir)
    cache_dir
  end

  #
  # 差分用キャッシュ保存ディレクトリを削除
  #
  def remove_cache_dir
    FileUtils.remove_entry_secure(@cache_dir) if @cache_dir
  end

  #
  # データベース更新
  #
  def update_database
    data = {
      "id" => @id,
      "author" => @setting["author"],
      "title" => get_title,
      "file_title" => get_file_title,
      "toc_url" => @setting["toc_url"],
      "sitename" => @setting["name"],
      "novel_type" => get_novel_type,
      "last_update" => Time.now,
      "new_arrivals_date" => (@new_arrivals ? Time.now : @@database[@id]["new_arrivals_date"]),
    }
    if @@database[@id]
      @@database[@id].merge!(data)
    else
      @@database[@id] = data
    end
    @@database.save_database
  end

  def get_novel_type
    return @novel_type if @novel_type
    @novel_type = @@database[@id] ? @@database[@id]["novel_type"] : nil
    unless @novel_type
      if @setting["narou_api_url"]
        info = Narou::API.new(@setting, "nt")
      else
        info = NovelInfo.load(@setting)
      end
      @novel_type = info ? info["novel_type"] : NOVEL_TYPE_SERIES
    end
    @novel_type
  end

  #
  # 連載小説かどうか調べる
  #
  def series_novel?
    get_novel_type == NOVEL_TYPE_SERIES
  end

  #
  # 小説を格納するためのディレクトリ名を取得する
  #
  def get_file_title
    return @file_title if @file_title
    # すでにデータベースに登録されているならそれを引き続き使うようにする
    if @@database[@id] && @@database[@id]["file_title"]
      @file_title = @@database[@id]["file_title"]
      return @file_title
    end
    @file_title = @setting["ncode"]
    if @setting["append_title_to_folder_name"]
      @file_title += " " + Helper.replace_filename_special_chars(get_title, true).strip
    end
    @file_title
  end

  #
  # 小説のタイトルを取得する
  #
  def get_title
    return @title if @title
    @title = @setting["title"]
    if @setting["title_strip_pattern"]
      @title = @title.gsub(/#{@setting["title_strip_pattern"]}/, "").gsub(/^[　\s]*(.+?)[　\s]*?$/, "\\1")
    end
    @title
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
          @setting.clear   # 今まで使っていたのは一旦クリア
          @setting = Downloader.get_sitesetting_by_target(toc_fp.base_uri.to_s)
          toc_url = @setting["toc_url"]
        end
        toc_source = Helper.pretreatment_source(toc_fp.read, @setting["encoding"])
      end
    rescue OpenURI::HTTPError => e
      if e.message =~ /^404/
        error "<red>[404]</red> 小説が削除されている可能性があります"
        $stdout.silence do
          Command::Flag.execute!(["delete", "--on", @id])
        end
      else
        error "何らかの理由により目次が取得できませんでした(#{e.message})"
      end
      return false
    end
    @setting.multi_match(toc_source, "title", "author", "story", "tcode")
    @setting["title"] = get_title
    if series_novel?
      # 連載小説
      subtitles = get_subtitles(toc_source)
    else
      # 短編小説
      if @setting["narou_api_url"]
        info = Narou::API.new(@setting, "s-gf-nu-w")
      else
        info = NovelInfo.load(@setting)
      end
      @setting["story"] = info["story"]
      @setting["author"] = info["writer"]
      subtitles = create_short_story_subtitles(info)
    end
    @setting["story"] = HTML.new(@setting["story"]).to_aozora
    toc_objects = {
      "title" => get_title,
      "author" => @setting["author"],
      "toc_url" => @setting["toc_url"],
      "story" => @setting["story"],
      "subtitles" => subtitles
    }
    toc_objects
  end

  def __search_index_in_subtitles(subtitles, index)
    subtitles.index { |item|
      item["index"] == index
    }
  end

  def __strdate_to_ymd(date)
    Date.parse(date.to_s.tr("年月日時分秒", "///:::")).strftime("%Y%m%d")
  end

  #
  # 本文更新チェック
  #
  # 更新された subtitle だけまとまった配列を返す
  #
  def update_body_check(old_subtitles, latest_subtitles)
    return latest_subtitles unless old_subtitles
    strong_update = LocalSetting.get["local_setting"]["update.strong"]
    latest_subtitles.dup.keep_if do |latest|
      index = latest["index"]
      index_in_old_toc = __search_index_in_subtitles(old_subtitles, index)
      next true unless index_in_old_toc
      old = old_subtitles[index_in_old_toc]
      # タイトルチェック
      if old["subtitle"] != latest["subtitle"]
        next true
      end
      # 章チェック
      if old["chapter"] != latest["chapter"]
        next true
      end
      # 更新日チェック
      # subdate : 初稿投稿日(Arcadiaでは改稿日)
      # subupdate : 改稿日
      old_subupdate = old["subupdate"]
      latest_subupdate = latest["subupdate"]
      if old_subupdate
        if old_subupdate == ""
          next latest_subupdate != ""
        end
        if strong_update
          if __strdate_to_ymd(old_subupdate) == __strdate_to_ymd(get_section_file_timestamp(latest))
            next true
          end
        end
        latest_subupdate > old_subupdate
      else
        if strong_update
          if __strdate_to_ymd(old["subdate"]) == __strdate_to_ymd(get_section_file_timestamp(latest))
            next true
          end
        end
        latest["subdate"] > old["subdate"]
      end
    end
  end

  #
  # 対象話数のタイムスタンプを取得
  #
  def get_section_file_timestamp(subtitle_info)
    File.mtime(create_section_file_path(subtitle_info))
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
      @setting["subtitle"] = @setting["subtitle"].gsub("\t", "")
      subtitles << {
        "index" => @setting["index"],
        "href" => @setting["href"],
        "chapter" => @setting["chapter"],
        "subtitle" => @setting["subtitle"].gsub("\n", ""),
        "file_subtitle" => Helper.replace_filename_special_chars(@setting["subtitle"]),
        "subdate" => @setting["subdate"],
        "subupdate" => @setting["subupdate"]
      }
    end
    subtitles
  end

  #
  # 短編用の情報を生成
  #
  def create_short_story_subtitles(info)
    subtitle = {
      "index" => "1",
      "href" => @setting.replace_group_values("href", "index" => "1"),
      "chapter" => "",
      "subtitle" => @setting["title"],
      "file_subtitle" => Helper.replace_filename_special_chars(@setting["title"]),
      "subdate" => info["general_firstup"],
      "subupdate" => info["novelupdated_at"]
    }
    [subtitle]
  end

  #
  # 小説本文をまとめてダウンロードして保存
  #
  # subtitles にダウンロードしたいものをまとめた subtitle info を渡す
  #
  def sections_download_and_save(subtitles)
    @@__narou_wait_counter ||= 0
    @@__narou_last_download_time ||= Time.now - 20
    max = subtitles.count
    return if max == 0
    puts ("<bold><green>" + TermColor.escape("ID:#{@id}　#{get_title} のDL開始") + "</green></bold>").termcolor
    interval_sleep_time = LocalSetting.get["local_setting"]["download.interval"] || 0
    interval_sleep_time = 0 if interval_sleep_time < 0
    download_wait_steps = LocalSetting.get["local_setting"]["download.wait-steps"] || 0
    download_wait_steps = 10 if @setting["is_narou"] && (download_wait_steps > 10 || download_wait_steps == 0)
    save_least_one = false
    if Time.now - @@__narou_last_download_time > 5
      @@__narou_wait_counter = 0
    end
    subtitles.each_with_index do |subtitle_info, i|
      if download_wait_steps > 0 && @@__narou_wait_counter % download_wait_steps == 0 && @@__narou_wait_counter >= download_wait_steps
        # MEMO:
        # 小説家になろうは連続DL規制があるため、ウェイトを入れる必要がある。
        # 10話ごとに規制が入るため、10話ごとにウェイトを挟む。
        # 1話ごとに1秒待機を10回繰り返そうと、11回目に規制が入るため、ウェイトは必ず必要。
        sleep(STEPS_WAIT_TIME)
      else
        sleep(interval_sleep_time) if @@__narou_wait_counter > 0
      end
      @@__narou_wait_counter += 1
      @@__narou_last_download_time = Time.now
      index, subtitle, file_subtitle, chapter = %w(index subtitle file_subtitle chapter).map { |k|
                                                  subtitle_info[k]
                                                }
      unless chapter.empty?
        puts "#{chapter}"
      end
      if get_novel_type == NOVEL_TYPE_SERIES
        if index.to_s.length <= DISPLAY_LIMIT_DIGITS
          # indexの数字がでかいと見た目がみっともないので特定の桁以内だけ表示する
          print "第#{index}部分　"
        end
      else
        print "短編　"
      end
      print "#{subtitle} (#{i+1}/#{max})"
      section_element = a_section_download(subtitle_info)
      info = subtitle_info.dup
      info["element"] = section_element
      section_file_name = "#{index} #{file_subtitle}.yaml"
      section_file_path = File.join(SECTION_SAVE_DIR_NAME, section_file_name)
      if File.exists?(File.join(get_novel_data_dir, section_file_path))
        if @force && different_section?(section_file_path, info)
          print " (更新あり)"
        end
      else
        if !@from_download || (@from_download && @force)
          print " <bold><magenta>(新着)</magenta></bold>".termcolor
        end
        @new_arrivals = true
      end
      move_to_cache_dir(section_file_path)
      save_novel_data(section_file_path, info)
      save_least_one = true
      puts
    end
    remove_cache_dir unless save_least_one
  end

  #
  # すでに保存されている内容とDLした内容が違うかどうか
  #
  def different_section?(relative_path, subtitle_info)
    path = File.join(get_novel_data_dir, relative_path)
    if File.exists?(path)
      return YAML.load_file(path) != subtitle_info
    else
      return true
    end
  end

  #
  # 差分用のキャッシュとして保存
  #
  def move_to_cache_dir(relative_path)
    path = File.join(get_novel_data_dir, relative_path)
    if File.exists?(path) && @cache_dir
      FileUtils.mv(path, @cache_dir)
    end
  end

  #
  # 指定された話数の本文をダウンロード
  #
  def a_section_download(subtitle_info)
    href = subtitle_info["href"]
    if @setting["is_narou"]
      subtitle_url = @setting.replace_group_values("txtdownload_url", subtitle_info)
    elsif href[0] == "/"
      subtitle_url = @setting["top_url"] + href
    else
      subtitle_url = @setting["toc_url"] + href
    end
    raw = download_raw_data(subtitle_url)
    if @setting["is_narou"]
      save_raw_data(raw, subtitle_info)
      element = extract_elements_in_section(raw, subtitle_info["subtitle"])
      element["data_type"] = "text"
    else
      save_raw_data(raw, subtitle_info, ".html")
      @setting.multi_match(raw, "body_pattern", "introduction_pattern", "postscript_pattern")
      element = { "data_type" => "html" }
      %w(introduction body postscript).each { |type|
        element[type] = @setting[type] || ""
      }
    end
    element
  end

  #
  # 指定したURLからデータをダウンロード
  #
  def download_raw_data(url)
    raw = nil
    retry_count = RETRY_MAX_FOR_503
    begin
      open(url) do |fp|
        raw = Helper.pretreatment_source(fp.read, @setting["encoding"])
      end
    rescue OpenURI::HTTPError => e
      if e.message =~ /^503/
        if retry_count == 0
          error "上限までリトライしましたがファイルがダウンロード出来ませんでした"
          exit 1
        end
        retry_count -= 1
        puts
        warn "server message: #{e.message}"
        warn "リトライ待機中……"
        sleep(WAITING_TIME_FOR_503)
        retry
      else
        raise
      end
    end
    raw
  end

  def get_raw_dir
    @raw_dir ||= File.join(get_novel_data_dir, RAW_DATA_DIR_NAME)
  end

  def init_raw_dir
    path = get_raw_dir
    FileUtils.mkdir_p(path) unless File.exists?(path)
  end

  #
  # テキストデータの生データを保存
  #
  def save_raw_data(raw_data, subtitle_info, ext = ".txt")
    index = subtitle_info["index"]
    file_subtitle = subtitle_info["file_subtitle"]
    path = File.join(get_raw_dir, "#{index} #{file_subtitle}#{ext}")
    File.write(path, raw_data)
  end

  #
  # 本文を解析して前書き・本文・後書きの要素に分解する
  #
  # 本文に含まれるタイトルは消す
  #
  def extract_elements_in_section(section, subtitle)
    lines = section.lstrip.lines.map(&:rstrip)
    introduction = slice_introduction(lines)
    postscript = slice_postscript(lines)
    if lines[0] == subtitle.strip
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
  #
  def get_novel_data_dir
    return @novel_data_dir if @novel_data_dir
    raise "小説名がまだ設定されていません" unless get_file_title
    @novel_data_dir = File.join(Database.archive_root_path, @setting["name"], get_file_title)
    @novel_data_dir
  end

  #
  # 小説本文の保存パスを生成
  #
  def create_section_file_path(subtitle_info)
    filename = "#{subtitle_info["index"]} #{subtitle_info["file_subtitle"]}.yaml"
    File.join(get_novel_data_dir, SECTION_SAVE_DIR_NAME, filename)
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
    novel_dir_path = get_novel_data_dir
    file_title = File.basename(novel_dir_path)
    FileUtils.mkdir_p(novel_dir_path) unless File.exists?(novel_dir_path)
    default_settings = NovelSetting::DEFAULT_SETTINGS
    special_preset_dir = File.join(Narou.get_preset_dir, @setting["domain"], @setting["ncode"])
    exists_special_preset_dir = File.exists?(special_preset_dir)
    [NovelSetting::INI_NAME, "converter.rb", NovelSetting::REPLACE_NAME].each do |filename|
      if exists_special_preset_dir
        preset_file_path = File.join(special_preset_dir, filename)
        if File.exists?(preset_file_path)
          unless File.exists?(File.join(novel_dir_path, filename))
            FileUtils.cp(preset_file_path, novel_dir_path)
          end
          next
        end
      end
      Template.write(filename, novel_dir_path, binding)
    end
  end
end
