# frozen_string_literal: true

#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "yaml"
require "fileutils"
require "ostruct"
require_relative "narou"
require_relative "helper"
require_relative "sitesetting"
require_relative "template"
require_relative "database"
require_relative "inventory"
require_relative "eventable"
require_relative "html"
require_relative "input"

#
# 小説サイトからのダウンロード
#
class Downloader
  include Narou::Eventable
  extend Memoist

  SECTION_SAVE_DIR_NAME = "本文"    # 本文を保存するディレクトリ名
  CACHE_SAVE_DIR_NAME = "cache"   # 差分用キャッシュ保存用ディレクトリ名
  RAW_DATA_DIR_NAME = "raw"    # 本文の生データを保存するディレクトリ名
  TOC_FILE_NAME = "toc.yaml"
  STEPS_WAIT_TIME = 5   # 数話ごとにかかるwaitの秒数
  WAIT_TIME_TO_RETRY_NETWORK = 10 # タイムアウト等でリトライするまでの待機時間
  LIMIT_TO_RETRY_NETWORK = 5 # タイムアウト等でリトライする回数上限
  NOVEL_TYPE_SERIES = 1   # 連載
  NOVEL_TYPE_SS = 2       # 短編
  DISPLAY_LIMIT_DIGITS = 4   # indexの表示桁数限界
  DEFAULT_INTERVAL_WAIT = 0.7   # download.interval のデフォルト値(秒)

  attr_reader :id, :setting

  class InvalidTarget < StandardError; end
  class SuspendDownload < StandardError; end
  class IO::TimeoutError; end # for 3.1 or earlier

  def initialize(target, options = {})
    id = Downloader.get_id_by_target(target)
    options = {
      force: false, from_download: false,
      stream: $stdout
    }.merge(options)
    setting = Downloader.get_sitesetting_by_target(target)

    unless setting
      case type = Downloader.get_target_type(target)
      when :url, :ncode
        raise InvalidTarget, "対応外の#{type}です(#{target})"
      when :id
        raise InvalidTarget, "指定のID(#{target})は存在しません"
      when :other
        raise InvalidTarget, "指定の小説(#{target})は存在しません"
      end
    end

    initialize_variables(id, setting, options)
  end

  #
  # 小説サイト設定を取得する
  #
  def self.get_sitesetting_by_target(target)
    toc_url = get_toc_url(target)
    setting = nil
    if toc_url
      setting = SiteSetting.find(toc_url)
    end
    setting
  end

  #
  # 本文格納用ディレクトリを取得
  #
  def self.get_novel_section_save_dir(archive_path)
    Pathname(File.join(archive_path, SECTION_SAVE_DIR_NAME))
  end

  #
  # target の種別を判別する
  #
  # ncodeの場合、targetを破壊的に変更する
  #
  def self.get_target_type(target)
    case target
    when URI::DEFAULT_PARSER.make_regexp
      :url
    when /^n\d+[a-z]+$/i
      target.downcase!
      :ncode
    when /^\d+$/, Integer
      :id
    else
      :other
    end
  end

  #
  # 指定されたIDとかから小説の保存ディレクトリを取得
  #
  def self.get_novel_data_dir_by_target(target)
    data = get_data_by_target(target) or return nil
    id = data["id"]
    file_title = data["file_title"] || data["title"]   # 互換性維持のための処理
    use_subdirectory = data["use_subdirectory"] || false
    subdirectory = use_subdirectory ? create_subdirecotry_name(file_title) : ""
    path = Database.archive_root_path.join(data["sitename"], subdirectory, file_title)
    return path if path.exist?
    @@database.delete(id)
    @@database.save_database
    error "#{path} が見つかりません。\n" \
          "保存フォルダが消去されていたため、データベースのインデックスを削除しました。"
    nil
  end

  #
  # target のIDを取得
  #
  def self.get_id_by_target(target)
    data = get_data_by_target(target)
    data && data["id"]
  end

  #
  # target からデータベースのデータを取得
  #
  def self.get_data_by_target(target)
    target = Narou.alias_to_id(target)
    case get_target_type(target)
    when :url
      setting = SiteSetting.find(target)
      if setting
        toc_url = setting["toc_url"]
        return @@database.get_data_by_toc_url(toc_url, setting)
      end
    when :ncode
      @@database.each_value do |data|
        return data if data["toc_url"] =~ %r!#{target}/$!
      end
    when :id
      data = @@database[target.to_i]
      return data if data
    when :other
      data = @@database.get_data("title", target)
      return data if data
    end
    nil
  end

  #
  # toc 読込
  #
  def self.get_toc_data(archive_path)
    YAML.unsafe_load_file(File.join(archive_path, TOC_FILE_NAME))
  end

  def self.get_toc_by_target(target)
    dir = Downloader.get_novel_data_dir_by_target(target)
    get_toc_data(dir)
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
      setting = SiteSetting.find(target)
      return setting["toc_url"] if setting
    when :ncode
      @@database.each_value do |data|
        if data["toc_url"] =~ %r!#{target}/$!
          return data["toc_url"]
        end
      end
      return "#{SiteSetting.narou["top_url"]}/#{target}/"
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
    id = get_id_by_target(target) or return nil
    @@database.novel_exists?(id)
  end

  def self.remove_novel(target, with_file = false)
    data = get_data_by_target(target) or return nil
    data_dir = get_novel_data_dir_by_target(target)
    if with_file
      FileUtils.remove_entry_secure(data_dir, true)
      puts "#{data_dir} を完全に削除しました"
    else
      # TOCは消しておかないと再DL時に古いデータがあると誤認する
      data_dir.join(TOC_FILE_NAME).delete
    end
    @@database.delete(data["id"])
    @@database.save_database
    data["title"]
  end

  #
  # 差分用キャッシュの保存ディレクトリ取得
  #
  def self.get_cache_root_dir(target)
    dir = get_novel_data_dir_by_target(target)
    if dir
      return dir.join(SECTION_SAVE_DIR_NAME, CACHE_SAVE_DIR_NAME)
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

  #
  # サブディレクトリ名を生成
  #
  def self.create_subdirecotry_name(title)
    name = title.start_with?("n") ? title[1..2] : title[0..1]
    name.strip
  end

  if Narou.already_init?
    @@database = Database.instance
  end

  #
  # 変数初期化
  #
  def initialize_variables(id, setting, options)
    @id = id || database.create_new_id
    @title = nil
    @setting = setting
    @force = options[:force]
    @stream = options[:stream]
    @cache_dir = nil
    @new_arrivals = false
    @new_novel = record.!
    @from_download = options[:from_download]
    @section_download_cache = {}
    @download_wait_steps = Inventory.load("local_setting")["download.wait-steps"] || 0
    @download_use_subdirectory = use_subdirectory?
    if @setting["is_narou"] && (@download_wait_steps > 10 || @download_wait_steps == 0)
      @download_wait_steps = 10
    end
    @nosave_diff = Narou.economy?("nosave_diff")
    @nosave_raw = Narou.economy?("nosave_raw")
    @gurad_spoiler = Inventory.load("local_setting")["guard-spoiler"]
    initialize_wait_counter
  end

  def database
    @@database
  end

  def record
    database[@id]
  end

  #
  # ウェイト関係初期化
  #
  def initialize_wait_counter
    @@__run_once ||= false
    unless @@__run_once
      @@__run_once = true
      @@__wait_counter = 0
      @@__last_download_time = Time.now - 20
    end
    @@interval_sleep_time = Inventory.load("local_setting")["download.interval"] || DEFAULT_INTERVAL_WAIT
    @@interval_sleep_time = 0 if @@interval_sleep_time < 0
    @@max_steps_wait_time = [STEPS_WAIT_TIME, @@interval_sleep_time].max
  end

  #
  # サブディレクトリに保存してあるかどうか
  #
  def use_subdirectory?
    if @new_novel
      # 新規DLする小説
      Inventory.load("local_setting")["download.use-subdirectory"] || false
    else
      # すでにDL済みの小説
      record["use_subdirectory"] || false
    end
  end

  #
  # 18歳以上か確認する
  #
  def confirm_over18?
    global_setting = Inventory.load("global_setting", :global)
    if global_setting.include?("over18")
      return global_setting["over18"]
    end
    if Narou::Input.confirm("年齢認証：あなたは18歳以上ですか")
      global_setting["over18"] = true
      global_setting.save
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

  def load_toc_file
    load_novel_data(TOC_FILE_NAME)
  end

  #
  # ダウンロード処理本体
  #
  def run_download
    old_toc = @new_novel ? nil : load_toc_file
    latest_toc = get_latest_table_of_contents(old_toc)
    unless latest_toc
      @stream.error @setting["toc_url"] + " の目次データが取得出来ませんでした"
      return :failed
    end
    latest_toc_subtitles = latest_toc["subtitles"]
    if @setting["confirm_over18"]
      unless confirm_over18?
        @stream.puts "18歳以上のみ閲覧出来る小説です。ダウンロードを中止しました"
        return :canceled
      end
    end
    unless old_toc
      init_novel_dir
      old_toc = {}
      @new_arrivals = true
    end
    init_raw_dir
    if old_toc.empty? || @force
      update_subtitles = latest_toc_subtitles
    else
      update_subtitles = update_body_check(old_toc["subtitles"], latest_toc_subtitles)
    end

    if old_toc.empty? && update_subtitles.size.zero?
      @stream.error "#{@setting['title']} の目次がありません"
      return :failed
    end

    unless @force
      if process_digest(old_toc, latest_toc)
        return :canceled
      end
    end

    id_and_title = "ID:#{@id}　#{@title}"

    return_status =
      case
      when update_subtitles.size > 0
        @cache_dir = create_cache_dir if old_toc.length > 0
        sections_download_and_save(update_subtitles)
        if @cache_dir && @cache_dir.glob("*").count == 0
          remove_cache_dir
        end
        update_database
        :ok
      when old_toc["subtitles"].size > latest_toc_subtitles.size
        # 削除された節がある（かつ更新がない）場合
        @stream.puts "#{id_and_title} は一部の話が削除されています"
        :ok
      when old_toc["title"] != latest_toc["title"]
        # タイトルが更新されている場合
        @stream.puts "#{id_and_title} のタイトルが更新されています"
        update_database
        :ok
      when old_toc["story"] != latest_toc["story"]
        # あらすじが更新されている場合
        @stream.puts "#{id_and_title} のあらすじが更新されています"
        :ok
      when old_toc["author"] != latest_toc["author"]
        # 作者名が更新されている場合
        @stream.puts "#{id_and_title} の作者名が更新されています"
        update_database
      else
        :none
      end

    record["general_all_no"] = latest_toc_subtitles.size

    save_toc_once(latest_toc)
    tags = @new_novel ? [] : record["tags"] || []
    case novel_end?
    when true
      unless tags.include?("end")
        update_database if update_subtitles.count == 0
        Command::Tag.execute!(%W(#{id} --add end --color white --no-overwrite-color), io: Narou::NullIO.new)
        msg = old_toc.empty? ? "完結しているようです" : "完結したようです"
        @stream.puts "<cyan>#{id_and_title.escape} は#{msg}</cyan>".termcolor
        return_status = :ok
      end
    when false
      if tags.include?("end")
        update_database if update_subtitles.size == 0
        Command::Tag.execute!(@id, "--delete", "end", io: Narou::NullIO.new)
        @stream.puts "<cyan>#{id_and_title.escape} は連載を再開したようです</cyan>".termcolor
        return_status = :ok
      end
    end
    return_status
  rescue Interrupt, SuspendDownload
    if latest_toc.present?
      save_toc_once(latest_toc)
      update_database(suspend: true)
    end
    raise Interrupt
  ensure
    @setting.clear
  end

  CHOICES = {
    "1" => "このまま更新する",
    "2" => "更新をキャンセル",
    "3" => "更新をキャンセルして小説を凍結する",
    "4" => "バックアップを作成する",
    "5" => "最新のあらすじを表示する",
    "6" => "小説ページをブラウザで開く",
    "7" => "保存フォルダを開く",
    "8" => "変換する",
    default: "2"
  }.freeze

  def self.choices_to_string(width: 0)
    CHOICES.dup.tap { |h| h.delete(:default) }.map { |key, summary|
      "#{key.rjust(width)}: #{summary}"
    }.join("\n")
  end

  #
  # ダイジェスト化に関する処理
  #
  # @return true = 更新をキャンセル、false = 更新する
  #
  def process_digest(old_toc, latest_toc)
    return false unless old_toc["subtitles"]
    latest_subtitles_count = latest_toc["subtitles"].size
    old_subtitles_count = old_toc["subtitles"].size
    if latest_subtitles_count < old_subtitles_count
      title = latest_toc["title"]
      message = <<-EOS
更新後の話数が保存されている話数より減少していることを検知しました。
ダイジェスト化されている可能性があるので、更新に関しての処理を選択して下さい。

保存済み話数: #{old_subtitles_count}
更新後の話数: #{latest_subtitles_count}

      EOS

      auto_choices = Inventory.load("local_setting")["download.choices-of-digest-options"]
      auto_choices &&= auto_choices.split(",")

      loop do
        if auto_choices
          # 自動入力
          choice = auto_choices.shift || CHOICES[:default]
          puts title
          puts message
          puts self.class.choices_to_string
          puts "> #{choice}"
        else
          choice = Narou::Input.choose(title, message, CHOICES)
        end

        case choice
        when "1"
          return false
        when "2"
          return true
        when "3"
          Command::Freeze.execute!(latest_toc["toc_url"])
          return true
        when "4"
          Command::Backup.execute!(latest_toc["toc_url"])
        when "5"
          if Narou.web?
            message = "あらすじ\n#{latest_toc["story"]}\n"
          else
            puts "あらすじ"
            puts latest_toc["story"]
          end
        when "6"
          Helper.open_browser(latest_toc["toc_url"])
        when "7"
          Helper.open_directory(Downloader.get_novel_data_dir_by_target(latest_toc["toc_url"]))
        when "8"
          Command::Convert.execute!(latest_toc["toc_url"], sync: true)
        end
        unless Narou.web?
          message = ""   # 長いので二度は表示しない
        end
      end
    else
      return false
    end
  end

  #
  # 差分用キャッシュ保存ディレクトリ作成
  #
  def create_cache_dir
    return nil if @nosave_diff
    now = Time.now
    name = now.strftime("%Y.%m.%d@%H.%M.%S")
    cache_dir = get_novel_data_dir.join(SECTION_SAVE_DIR_NAME, CACHE_SAVE_DIR_NAME, name)
    FileUtils.mkdir_p(cache_dir)
    cache_dir
  end

  #
  # 差分用キャッシュ保存ディレクトリを削除
  #
  def remove_cache_dir
    FileUtils.remove_entry_secure(@cache_dir, true) if @cache_dir
  end

  def __search_latest_update_time(key, subtitles, subkey: nil)
    latest = Time.new(0)
    subtitles.each do |subtitle|
      value = subtitle[key]
      if value.to_s.empty? && subkey
        value = subtitle[subkey]
      end
      time = Helper.date_string_to_time(value)
      latest = time if time && latest < time
    end
    latest
  end

  #
  # 小説が更新された日をTime型で取得
  #
  def get_novelupdated_at
    info = @setting["info"] || {}
    if info["novelupdated_at"]
      info["novelupdated_at"]
    else
      __search_latest_update_time("subupdate", @setting["subtitles"], subkey: "subdate")
    end
  end

  #
  # 小説の最新掲載日をTime型で取得
  #
  # 小説家になろう、ハーメルンは小説情報ページの最終話掲載日などから取得した日付
  # その他サイトは一番新しい話の投稿日（更新日ではない）
  #
  def get_general_lastup
    info = @setting["info"] || {}
    if info["general_lastup"]
      info["general_lastup"]
    else
      __search_latest_update_time("subdate", @setting["subtitles"])
    end
  end

  #
  # 小説の文字数
  #
  # 小説情報から取得するため、実際に計算するわけではない。
  # 情報から取得出来ない（記載がない）場合は無視する
  #
  def novel_length
    info = @setting["info"] || {}
    info["length"]
  end

  #
  # データベース更新
  #
  def update_database(suspend: false)
    info = @setting["info"] || {}
    data = {
      "id" => @id,
      "author" => @setting["author"],
      "title" => get_title,
      "file_title" => get_file_title,
      "toc_url" => @setting["toc_url"],
      "sitename" => sitename,
      "novel_type" => get_novel_type,
      "end" => novel_end?,
      "last_update" => Time.now,
      "new_arrivals_date" => (@new_arrivals ? Time.now : record["new_arrivals_date"]),
      "use_subdirectory" => @download_use_subdirectory,
      "general_firstup" => info["general_firstup"],
      "novelupdated_at" => get_novelupdated_at,
      "general_lastup" => get_general_lastup,
      "length" => novel_length,
      "suspend" => suspend
    }
    if record
      database[@id].merge!(data)
    else
      database[@id] = data
    end
    database.save_database
  end

  def get_novel_status
    novel_status = NovelInfo.load(@setting, of: "nt-e-sitename")
    novel_status ||= {
      "novel_type" => NOVEL_TYPE_SERIES,
      "end" => nil, # nil で完結状態が定義されていなかったことを示す（扱いとしては未完結と同じ）
      "sitename" => @setting["sitename"]
    }
    novel_status
  end
  memoize :get_novel_status

  #
  # 小説の種別を取得（連載か短編）
  #
  def get_novel_type
    get_novel_status["novel_type"]
  end

  #
  # 小説が完結しているか調べる
  #
  def novel_end?
    get_novel_status["end"]
  end

  #
  # 掲載サイト名
  #
  # すでにレコードに登録されている場合はそちらを優先する
  #
  def sitename
    record&.dig("sitename") || get_novel_status["sitename"]
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
    # すでにデータベースに登録されているならそれを引き続き使うようにする
    file_title = record&.dig("file_title")
    return file_title if file_title
    ncode = @setting["ncode"]
    return ncode unless @setting["append_title_to_folder_name"]
    scrubbed_title = Helper.replace_filename_special_chars(get_title, true).strip
    Helper.truncate_folder_title("#{ncode} #{scrubbed_title}")
  end
  memoize :get_file_title

  #
  # 小説のタイトルを取得する
  #
  def get_title
    return @title if @title
    @title = @setting["title"] || record["title"]
    if @setting["title_strip_pattern"]
      @title = @title.gsub(/#{@setting["title_strip_pattern"]}/, "").gsub(/^[　\s]*(.+?)[　\s]*?$/, "\\1")
    end
    @title
  end

  class DownloaderNotFoundError < OpenURI::HTTPError
    def initialize
      super("404 not found", nil)
    end
  end

  class DownloaderForceRedirect < StandardError; end

  #
  # HTMLの中から小説が削除されたか非公開なことを示すメッセージを検出する
  #
  def self.detect_error_message(setting, source)
    message = setting["error_message"]
    return false unless message
    source.match(message)
  end

  def get_toc_source
    toc_url = @setting["toc_url"]
    return nil unless toc_url
    max_retry = 5
    toc_source = ""
    cookie = @setting["cookie"] || ""
    open_uri_options = make_open_uri_options("Cookie" => cookie, allow_redirections: :safe)
    begin
      URI.open(toc_url, open_uri_options) do |toc_fp|
        if toc_fp.base_uri.to_s != toc_url
          # リダイレクトされた場合。
          # ノクターン・ムーンライトのNコードを ncode.syosetu.com に渡すと、年齢認証のクッションページに飛ばされる
          # 転送先を取得し再度ページを取得し直す
          uri = URI.parse(toc_fp.base_uri.to_s)
          if uri.host == "nl.syosetu.com"
            decode = Hash[URI.decode_www_form(uri.query)]
            toc_url = decode["url"]   # 年齢認証確認ページからの転送先
            raise DownloaderForceRedirect
          end
          s = Downloader.get_sitesetting_by_target(toc_fp.base_uri.to_s)
          raise DownloaderNotFoundError unless s   # 非公開や削除等でトップページへリダイレクトされる場合がある
          @setting.clear   # 今まで使っていたのは一旦クリア
          @setting = s
          toc_url = @setting["toc_url"]
        end
        toc_source = Helper.restore_entity(Helper.pretreatment_source(toc_fp.read, @setting["encoding"]))
        raise DownloaderNotFoundError if Downloader.detect_error_message(@setting, toc_source)
      end
    rescue DownloaderForceRedirect
      max_retry -= 1
      if max_retry >= 0
        retry
      else
        raise
      end
    end
    toc_source
  end

  #
  # 目次データを取得する
  #
  def get_latest_table_of_contents(old_toc, through_error: false)
    toc_source = get_toc_source
    return nil unless toc_source
    @setting.multi_match(toc_source, "tcode")
    info = NovelInfo.load(@setting, toc_source: toc_source)
    if info
      raise DownloaderNotFoundError unless info["title"]
      @setting["title"] = info["title"]
      @setting["author"] = info["writer"]
      @setting["story"] = info["story"]
    else
      # 小説情報ページがないサイトの場合は目次ページから取得する
      @setting.multi_match(toc_source, "title", "author", "story")
      raise DownloaderNotFoundError unless @setting.matched?("title")
      story_html = HTML.new(@setting["story"])
      story_html.strip_decoration_tag = true
      @setting["story"] = story_html.to_aozora
    end
    @setting["info"] = info
    replace_external_properties_of_setting

    @setting["title"] = get_title
    if series_novel?
      # 連載小説
      subtitles = get_subtitles(toc_source, old_toc)
    else
      # 短編小説
      subtitles = create_short_story_subtitles(info)
    end
    @setting["subtitles"] = subtitles

    toc_objects = {
      "title" => get_title,
      "author" => @setting["author"],
      "toc_url" => @setting["toc_url"],
      "story" => @setting["story"],
      "subtitles" => subtitles
    }
    toc_objects
  rescue OpenURI::HTTPError, Errno::ECONNRESET, Errno::ETIMEDOUT, Net::OpenTimeout, IO::TimeoutError => e
    raise if through_error   # エラー処理はしなくていいからそのまま例外を受け取りたい時用
    if e.message.include?("404")
      @stream.error "小説が削除されているか非公開な可能性があります"
      sleep_for_download
      if database.novel_exists?(@id)
        Command::Tag.execute!(%W(#{@id} --add 404 --color white --no-overwrite-color), io: Narou::NullIO.new)
        Command::Freeze.execute!(@id, "--on")
      end
    else
      @stream.error "何らかの理由により目次が取得できませんでした(#{e.message})"
    end
    false
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
    strong_update = Inventory.load("local_setting")["update.strong"]
    latest_subtitles.select do |latest|
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
      # 前回ダウンロードしたはずの本文ファイルが存在するか
      section_file_name = "#{index} #{old["file_subtitle"]}.yaml"
      section_file_relative_path = File.join(SECTION_SAVE_DIR_NAME, section_file_name)
      unless get_novel_data_dir.join(section_file_relative_path).exist?
        # あるはずのファイルが存在しなかったので、再ダウンロードが必要
        next true
      end
      # 更新日チェック
      # subdate : 初稿投稿日
      # subupdate : 改稿日
      old_subdate = old["subdate"]
      latest_subdate = latest["subdate"]
      old_subupdate = old["subupdate"]
      latest_subupdate = latest["subupdate"]
      # oldにsubupdateがなくても、latestのほうにsubupdateがある場合もある
      old_subupdate = old_subdate if latest_subupdate && !old_subupdate
      different_check = nil
      latest["download_time"] = old["download_time"]
      if strong_update
        latest_section_timestamp_ymd = __strdate_to_ymd(get_section_file_timestamp(old, latest))
        different_check = lambda do
          latest_info_dummy = latest.dup
          latest_info_dummy["element"] = a_section_download(latest)
          deffer = different_section?(section_file_relative_path, latest_info_dummy)
          unless deffer
            # 差分がある場合はこのあと保存されて更新されるので、差分がない場合のみ
            # タイムスタンプを更新しておく
            FileUtils.touch(get_novel_data_dir.join(section_file_relative_path))
          end
          deffer
        end
      end
      if old_subupdate && latest_subupdate
        if old_subupdate == ""
          next latest_subupdate != ""
        end
        if strong_update
          if __strdate_to_ymd(old_subupdate) == latest_section_timestamp_ymd
            next different_check.call
          end
        end
        latest_subupdate > old_subupdate
      else
        # 古いバージョンだと old_subdate が nil なので判定出来ないため
        next true unless old_subdate

        if strong_update
          if __strdate_to_ymd(old_subdate) == latest_section_timestamp_ymd
            next different_check.call
          end
        end
        latest_subdate > old_subdate
      end
    end
  end

  #
  # 対象話数のタイムスタンプを取得
  #
  def get_section_file_timestamp(old_subtitles_info, latest_subtitles_info)
    download_time = old_subtitles_info["download_time"]
    unless download_time
      download_time = File.mtime(section_file_path(old_subtitles_info))
    end
    latest_subtitles_info["download_time"] = download_time
    download_time
  end

  def title_to_filename(title)
    Helper.truncate_path(
      Helper.replace_filename_special_chars(
        HTML.new(title).delete_ruby_tag
      )
    )
  end

  #
  # 各話の情報を取得
  #
  def get_subtitles(toc_source, old_toc)
    subtitles = []
    toc_post = toc_source.dup
    old_subtitles = old_toc ? old_toc["subtitles"] : nil
    loop do
      match_data = @setting.multi_match(toc_post, "subtitles")
      break unless match_data
      toc_post = match_data.post_match
      @setting["subtitle"] = @setting["subtitle"].gsub("\t", "")
      subdate = @setting["subdate"].tap { |sd|
        # subdate(初回掲載日)がない場合、最初に取得した時のsubupdateで代用する
        # subdateが取得出来ないのは暁とArcadia
        unless sd
          old_index = old_subtitles ? __search_index_in_subtitles(old_subtitles, @setting["index"]) : nil
          if !old_index || !old_subtitles[old_index]["subdate"]
            break @setting["subupdate"]
          end
          # || 以降は subupdate を取得していない古い(2.4.0以前)toc.yamlがあるためsubdateを使う
          break old_subtitles[old_index]["subupdate"] || old_subtitles[old_index]["subdate"]
        end
      }
      subtitles << {
        "index" => @setting["index"],
        "href" => @setting["href"],
        "chapter" => @setting["chapter"].to_s,
        "subchapter" => @setting["subchapter"].to_s,
        "subtitle" => slim_subtitle(@setting["subtitle"]),
        "file_subtitle" => title_to_filename(@setting["subtitle"]),
        "subdate" => subdate,
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
      "subtitle" => slim_subtitle(@setting["title"]),
      "file_subtitle" => title_to_filename(@setting["title"]),
      "subdate" => info["general_firstup"],
      "subupdate" => info["novelupdated_at"] || info["general_lastup"] || info["general_firstup"]
    }
    [subtitle]
  end

  def slim_subtitle(string)
    HTML.new(string).delete_ruby_tag.delete("\n")
  end

  #
  # 小説本文をまとめてダウンロードして保存
  #
  # subtitles にダウンロードしたいものをまとめた subtitle info を渡す
  #
  def sections_download_and_save(subtitles)
    max = subtitles.size
    return if max == 0
    @stream.puts "<bold><green>#{"ID:#{@id}　#{get_title}".escape} のDL開始</green></bold>".termcolor
    save_least_one = false
    subtitles.each_with_index do |subtitle_info, i|
      index, subtitle, file_subtitle, chapter, subchapter =
        %w(index subtitle file_subtitle chapter subchapter).map { |k|
          subtitle_info[k]
        }
      info = subtitle_info.dup
      info["element"] = a_section_download(subtitle_info)

      @stream.puts "#{chapter}" unless chapter.to_s.empty?
      @stream.puts "#{subchapter}" unless subchapter.to_s.empty?

      if get_novel_type == NOVEL_TYPE_SERIES
        if index.to_s.length <= DISPLAY_LIMIT_DIGITS
          # indexの数字がでかいと見た目がみっともないので特定の桁以内だけ表示する
          @stream.print "第#{index}部分　"
        end
      else
        @stream.print "短編　"
      end
      printable_subtitle = @gurad_spoiler ? Helper.to_unprintable_words(subtitle) : subtitle
      @stream.print "#{HTML.new(printable_subtitle).delete_ruby_tag} (#{i + 1}/#{max})"

      section_file_name = "#{index} #{file_subtitle}.yaml"
      section_file_relative_path = File.join(SECTION_SAVE_DIR_NAME, section_file_name)
      section_file_full_path = get_novel_data_dir.join(section_file_relative_path)
      if section_file_full_path.exist?
        if @force
          if different_section?(section_file_relative_path, info)
            @stream.print " (更新あり)"
            move_to_cache_dir(section_file_relative_path)
          end
        else
          move_to_cache_dir(section_file_relative_path)
        end
      else
        if !@from_download || (@from_download && @force)
          @stream.print " <bold><magenta>(新着)</magenta></bold>".termcolor
          trigger(:newarrival, {
            id: @id,
            subtitle_info: subtitle_info
          })
        end
        @new_arrivals = true
      end
      save_novel_data(section_file_relative_path, info)
      save_least_one = true
      @stream.puts
    end
    remove_cache_dir unless save_least_one
  end

  #
  # すでに保存されている内容とDLした内容が違うかどうか
  #
  def different_section?(old_relative_path, new_subtitle_info)
    path = get_novel_data_dir.join(old_relative_path)
    return true unless path.exist?
    YAML.unsafe_load_file(path)["element"] != new_subtitle_info["element"]
  end

  #
  # 差分用のキャッシュとして保存
  #
  def move_to_cache_dir(relative_path)
    return if @nosave_diff
    path = get_novel_data_dir.join(relative_path)
    if path.exist? && @cache_dir
      FileUtils.mv(path, @cache_dir)
    end
  end

  def sleep_for_download
    if Time.now - @@__last_download_time > @@max_steps_wait_time
      @@__wait_counter = 0
    end
    if @download_wait_steps > 0 && @@__wait_counter % @download_wait_steps == 0 \
      && @@__wait_counter >= @download_wait_steps
      # MEMO:
      # 小説家になろうは連続DL規制があるため、ウェイトを入れる必要がある。
      # 10話ごとに規制が入るため、10話ごとにウェイトを挟む。
      # 1話ごとに1秒待機を10回繰り返そうと、11回目に規制が入るため、ウェイトは必ず必要。
      sleep(@@max_steps_wait_time)
    else
      sleep(@@interval_sleep_time) if @@__wait_counter > 0
    end
    @@__wait_counter += 1
    @@__last_download_time = Time.now
  end

  #
  # 指定された話数の本文をダウンロード
  #
  def a_section_download(subtitle_info)
    index = subtitle_info["index"]
    return @section_download_cache[index] if @section_download_cache[index]
    sleep_for_download
    href = subtitle_info["href"]
    subtitle_url =
      if href&.start_with?("/")
        "#{@setting["top_url"]}#{href}"
      else
        "#{@setting["toc_url"]}#{href}"
      end
    raw = download_raw_data(subtitle_url)
    save_raw_data(raw, subtitle_info, ".html")
    %w(introduction postscript body).each { |type| @setting[type] = nil }
    @setting.multi_match(raw, "body_pattern", "introduction_pattern", "postscript_pattern")
    element = { "data_type" => @setting["data_type"] || "html" }
    %w(introduction postscript body).each { |type|
      element[type] = @setting[type].to_s
    }
    subtitle_info["download_time"] = Time.now
    @section_download_cache[index] = element
    element
  end

  def display_hint
    @stream.puts <<~HINT
      ヒント:
      503 がでた場合はしばらくアクセスが規制される場合があります。
      設定を変更してサーバーに対する負荷を軽減させましょう。(下記参照)
      小説家になろう系列の場合、10分程度時間を置く必要があります。
      (メンテナンス等でも503になる場合があります。公式サイトを確認してください)

      下記の設定のどれか、もしくは全てを変更することで調整できます。
      (download.interval が最重要設定。１話ごとの間隔が短すぎると規制されやすい)

      # 1話ごとに入るウェイトを変更する(単位：秒)
      narou s download.interval=1.0

      # 10話ごとに通常より長いウェイトを入れる
      narou s download.wait-steps=10

      # Update時の作品間の待機時間を変更する(単位：秒)
      narou s update.interval=3.0
    HINT
  end

  #
  # 指定したURLからデータをダウンロード
  #
  def download_raw_data(url)
    raw = nil
    retry_count = LIMIT_TO_RETRY_NETWORK
    cookie = @setting["cookie"] || ""
    begin
      open_uri_options = make_open_uri_options("Cookie" => cookie, allow_redirections: :safe)
      URI.open(url, "r:#{@setting["encoding"]}", open_uri_options) do |fp|
        raw = Helper.pretreatment_source(fp.read, @setting["encoding"])
      end
    rescue OpenURI::HTTPError, Errno::ECONNRESET, Errno::ETIMEDOUT, Net::OpenTimeout, IO::TimeoutError => e
      case e.message
      when /^503/
        # 503 はアクセス規制やメンテ等でリトライしてもほぼ意味がないことが多いため一度で諦める
        @stream.error "server message: #{e.message}"
        display_hint
        raise SuspendDownload
      when /^404/
        @stream.error "server message: #{e.message}"
        @stream.puts "#{url} がダウンロード出来ませんでした。時間をおいて再度試してみてください"
        raise SuspendDownload
      else
        if retry_count == 0
          @stream.error "上限までリトライしましたがファイルがダウンロード出来ませんでした"
          raise SuspendDownload
        end
        retry_count -= 1
        @stream.puts <<~MSG
          server message: #{e.message}
          リトライ待機中...
        MSG
        sleep(WAIT_TIME_TO_RETRY_NETWORK)
        retry
      end
    end
    raw
  end

  def raw_dir
    @raw_dir ||= get_novel_data_dir.join(RAW_DATA_DIR_NAME)
  end

  def init_raw_dir
    return if @nosave_raw
    path = raw_dir
    FileUtils.mkdir_p(path) unless path.exist?
  end

  #
  # テキストデータの生データを保存
  #
  def save_raw_data(raw_data, subtitle_info, ext = ".txt")
    return if @nosave_raw
    index = subtitle_info["index"]
    file_subtitle = subtitle_info["file_subtitle"]
    path = raw_dir.join("#{index} #{file_subtitle}#{ext}")
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
      "data_type" => "text",
      "introduction" => introduction,
      "postscript" => postscript,
      "body" => lines.join("\n")
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
    raise "小説名がまだ設定されていません" unless get_file_title
    subdirectory = @download_use_subdirectory ? Downloader.create_subdirecotry_name(get_file_title) : ""
    Database.archive_root_path.join(sitename, subdirectory, get_file_title)
  end
  memoize :get_novel_data_dir

  #
  # 小説本文の保存パスを生成
  #
  def section_file_path(subtitle_info)
    filename = "#{subtitle_info["index"]} #{subtitle_info["file_subtitle"]}.yaml"
    get_novel_data_dir.join(SECTION_SAVE_DIR_NAME, filename)
  end

  def save_toc_once(toc)
    return if @save_toc_once
    save_novel_data(TOC_FILE_NAME, toc)
    @save_toc_once = true
  end

  #
  # 小説データの格納ディレクトリに保存
  #
  def save_novel_data(filename, object)
    path = get_novel_data_dir.join(filename)
    dir_path = path.dirname
    unless dir_path.exist?
      FileUtils.mkdir_p(dir_path)
    end
    File.write(path, YAML.dump(object))
  end

  #
  # 小説データの格納ディレクトリから読み込む
  def load_novel_data(filename)
    YAML.unsafe_load_file(get_novel_data_dir.join(filename))
  rescue Errno::ENOENT
    nil
  end

  #
  # 小説データの格納ディレクトリを初期設定する
  #
  def init_novel_dir
    novel_dir_path = get_novel_data_dir
    file_title = novel_dir_path.basename.to_s
    FileUtils.mkdir_p(novel_dir_path) unless novel_dir_path.exist?
    original_settings = NovelSetting.get_original_settings
    default_settings = NovelSetting.load_default_settings
    novel_setting = NovelSetting.new(@id, true, true)
    special_preset_dir = Narou.preset_dir.join(@setting["domain"], @setting["ncode"])
    exists_special_preset_dir = special_preset_dir.exist?
    templates = [
      [NovelSetting::INI_NAME, NovelSetting::INI_ERB_BINARY_VERSION],
      ["converter.rb", 1.0],
      [NovelSetting::REPLACE_NAME, 1.0]
    ]
    templates.each do |(filename, binary_version)|
      if exists_special_preset_dir
        preset_file_path = special_preset_dir.join(filename)
        if preset_file_path.exist?
          unless novel_dir_path.join(filename).exist?
            FileUtils.cp(preset_file_path, novel_dir_path)
          end
          next
        end
      end
      Template.write(filename, novel_dir_path, binding, binary_version)
    end
  end

  def replace_external_properties_of_setting
    @setting["title"] = @setting["title"].delete("\r\n")
    @setting["author"] = @setting["author"].delete("\r\n")
  end
end
