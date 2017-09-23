# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "fileutils"
require "memoist"
require_relative "helper"
require_relative "inventory"
if Helper.engine_jruby?
  require_relative "extensions/jruby"
end

module Narou
  LOCAL_SETTING_DIR_NAME = ".narou"
  GLOBAL_SETTING_DIR_NAME = ".narousetting"
  AOZORAEPUB3_JAR_NAME = "AozoraEpub3.jar"
  AOZORAEPUB3_DIR = "AozoraEpub3"
  PRESET_DIR = "preset"
  MISC_DIR = "misc"
  GLOBAL_REPLACE_NAME = "replace.txt"
  EXIT_ERROR_CODE = 127
  EXIT_INTERRUPT = 126
  EXIT_REQUEST_REBOOT = 125
  MODIFIED_TAG = "modified"

  UPDATE_SORT_KEYS = {
    "id" => "ID", "last_update" => "更新日", "title" => "タイトル", "author" => "作者名",
    "new_arrivals_date" => "新着日", "general_lastup" => "最新話掲載日"
  }

 class << self
  extend Memoist

  @@is_web = false

  def last_commit_year
    2017
  end

  def get_root_dir
    root_dir = nil
    path = Dir.pwd
    drive_letter = ""
    if Helper.os_windows?
      path.encode!(Encoding::UTF_8)
      path.gsub!(/^[a-z]:/i, "")
      drive_letter = $&
    end
    while path != ""
      if File.directory?("#{drive_letter}#{path}/#{LOCAL_SETTING_DIR_NAME}")
        root_dir = drive_letter + path
        break
      end
      path.gsub!(%r!/[^/]*$!, "")
    end
    root_dir
  end
  memoize :get_root_dir

  def local_setting_dir
    local_setting_dir = nil
    root_dir = get_root_dir
    if root_dir
      local_setting_dir = File.join(root_dir, LOCAL_SETTING_DIR_NAME)
    end
    local_setting_dir
  end
  memoize :local_setting_dir

  def global_setting_dir
    root_dir = get_root_dir
    if root_dir
      dir = File.join(root_dir, GLOBAL_SETTING_DIR_NAME)
      return dir if File.directory?(dir)
    end
    dir = File.expand_path(GLOBAL_SETTING_DIR_NAME, "~")
    FileUtils.mkdir(dir) unless File.exist?(dir)
    dir
  end
  memoize :global_setting_dir

  def get_script_dir
    File.expand_path(File.join(File.dirname(__FILE__), ".."))
  end
  memoize :get_script_dir

  def already_init?
    !!get_root_dir
  end

  def init
    return nil if already_init?
    FileUtils.mkdir(LOCAL_SETTING_DIR_NAME)
    puts "#{LOCAL_SETTING_DIR_NAME}/ を作成しました"
    Database.init
  end

  #
  # target が alias だった場合はIDに変換する
  #
  # 全てのtarget照合系はこのメソッドを通過するので、ここで小文字にしてしまう
  #
  def alias_to_id(target)
    aliases = Inventory.load("alias")
    if aliases[target]
      return aliases[target]
    end
    target.kind_of?(Numeric) ? target : target.downcase
  end

  def novel_frozen?(target)
    id = Downloader.get_id_by_target(target) or return false
    Inventory.load("freeze").include?(id)
  end

  def get_preset_dir
    File.expand_path(File.join(get_script_dir, PRESET_DIR))
  end
  memoize :get_preset_dir

  def create_aozoraepub3_jar_path(*paths)
    File.expand_path(File.join(*paths, AOZORAEPUB3_JAR_NAME))
  end

  def aozoraepub3_directory?(path)
    File.exist?(create_aozoraepub3_jar_path(path))
  end

  def parse_replace_txt(text)
    pattern = []
    text.each_line do |line|
      line.sub!(/[\r\n]+\z/, "")
      next if line[0] == ";"    # コメント記号
      pair = line.split("\t", 2)
      if pair.length == 2 && pair[0]
        pattern << pair
      end
    end
    pattern
  end

  def write_replace_txt(path, pairs)
    buffer = pairs.each_with_object("\t").map(&:join).join("\n")
    File.write(path, buffer)
  end

  def load_global_replace_pattern
    path = File.join(get_root_dir, GLOBAL_REPLACE_NAME)
    if File.exist?(path)
      pairs = Helper::CacheLoader.memo(path) do |text|
        parse_replace_txt(text)
      end
    else
      pairs = []
    end
    @@global_replace_pattern_pairs = pairs
    pairs
  end

  def global_replace_pattern
    @@global_replace_pattern_pairs ||= load_global_replace_pattern
  end

  def save_global_replace_pattern
    path = File.join(get_root_dir, GLOBAL_REPLACE_NAME)
    write_replace_txt(path, @@global_replace_pattern_pairs)
  end

  #
  # AozoraEpub3 の実行ファイル(.jar)のフルパス取得
  # 検索順序
  # 1. グローバルセッティング (global_setting aozoraepub3dir)
  # 2. 小説保存ディレクトリ(Narou.get_root_dir) 直下の AozoraEpub3
  # 3. スクリプト保存ディレクトリ(Narou.get_script_dir) 直下の AozoraEpub3
  #
  def get_aozoraepub3_path
    global_setting_aozora_path = Inventory.load("global_setting", :global)["aozoraepub3dir"]
    if global_setting_aozora_path
      aozora_jar_path = create_aozoraepub3_jar_path(global_setting_aozora_path)
      if File.exist?(aozora_jar_path)
        return aozora_jar_path
      end
    end
    [Narou.get_root_dir, Narou.get_script_dir].each do |dir|
      aozora_jar_path = create_aozoraepub3_jar_path(dir, AOZORAEPUB3_DIR)
      if File.exist?(aozora_jar_path)
        return aozora_jar_path
      end
    end
    nil
  end
  memoize :get_aozoraepub3_path

  #
  # 書籍ファイル名を生成する
  # convert.filename-to-ncode を設定している場合に novel_data に ncode、domain を
  # 設定しない場合は id カラムが必須
  #
  def create_novel_filename(novel_data, ext = "")
    filename_to_ncode = Inventory.load("local_setting")["convert.filename-to-ncode"]
    if filename_to_ncode
      ncode, domain = novel_data["ncode"], novel_data["domain"]
      if !ncode || !domain
        id = novel_data["id"]
        unless id
          raise ArgumentError, %!novel_data["id"] を設定して下さい!
        end
        site_setting = Downloader.get_sitesetting_by_target(id)
        ncode = site_setting["ncode"]
        domain = site_setting["domain"]
      end
      serialized_domain = domain.to_s.gsub(".", "_")
      %!#{serialized_domain}_#{ncode}#{ext}!
    else
      author, title = %w(author title).map { |k|
        Helper.replace_filename_special_chars(novel_data[k], true)
      }
      "[#{author}] #{title}#{ext}"
    end
  end

  def get_mobi_paths(target)
    get_ebook_file_paths(target, ".mobi")
  end

  def get_ebook_file_paths(target, ext)
    data = Downloader.get_data_by_target(target)
    return nil unless data
    dir = Downloader.get_novel_data_dir_by_target(target)
    fname = create_novel_filename(data, ext)
    base = File.basename(fname, ext)

    paths = [ File.join(dir, fname) ]
    index = 2
    while File.exist?(path = File.join(dir, "#{base}_#{index}#{ext}"))
      paths.push(path)
      index += 1
    end
    paths
  end

  def get_misc_dir
    File.join(get_root_dir, MISC_DIR)
  end

  require_relative "device"

  def get_device(device_name = nil)
    device_name = Inventory.load("local_setting")["device"] unless device_name
    if device_name && Device.exists?(device_name)
      return Device.create(device_name)
    end
    nil
  end

  def web=(bool)
    @@is_web = bool
  end

  def web?
    @@is_web
  end

  def update_sort_key_summaries(left_space = 28)
    summaries = { "KEY" => "   対象" }.merge(UPDATE_SORT_KEYS)
    key_max_width = summaries.keys.max_by(&:length).length
    summaries.map do |(key, summary)|
      "#{" " * left_space}| #{key.center(key_max_width)} | #{summary}"
    end.join("\n")
  end

  def get_theme
    Inventory.load("local_setting")["theme"]
  end

  def get_theme_dir(name = nil)
    File.join([get_script_dir, "lib/web/public/theme", name].compact)
  end

  def get_theme_names
    Dir.glob(get_theme_dir("*")).map do |path|
      name = File.basename(path)
      name == "fonts" ? nil : name
    end.compact
  end
  memoize :get_theme_names

  def economy?(mode)
    eco_modes = Inventory.load("local_setting")["economy"].to_s.split(",").map(&:strip)
    eco_modes.include?(mode)
  end

  def novel_type_text(type)
    type == 2 ? "短編" : "連載"
  end

  #
  # Narou.rb gem の最新バージョン番号を取得する
  #
  # rubygems公式APIによる取得は、WindowsでのSSL証明書問題で取得出来ない
  # 環境があるため、gemコマンド経由で取得する
  #
  def latest_version
    response = `gem search ^narou$`.split("\n")
    if response.last =~ /\Anarou \(([0-9.]+).*?\)\z/
      $1
    end
  end

  def commit_version
    cv_path = File.expand_path("commitversion", get_script_dir)
    File.read(cv_path) if File.exist?(cv_path)
  end
  memoize :commit_version

  def kindlegen_path
    postfix = Helper.os_windows? ? ".exe" : ""
    File.join(File.dirname(Narou.get_aozoraepub3_path), "kindlegen#{postfix}")
  end
  memoize :kindlegen_path

 end
end
