# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "fileutils"
require_relative "helper"
require_relative "localsetting"
require_relative "globalsetting"

module Narou
  extend self

  LOCAL_SETTING_DIR = ".narou"
  GLOBAL_SETTING_DIR = ".narousetting"
  AOZORAEPUB3_JAR_NAME = "AozoraEpub3.jar"
  AOZORAEPUB3_DIR = "./AozoraEpub3"
  PRESET_DIR = "./preset"

  @@root_dir = nil
  @@local_setting_dir = nil
  @@global_setting_dir = nil
  @@aozora_jar_path = nil
  @@preset_dir = nil

  def get_root_dir
    return @@root_dir if @@root_dir
    path = File.expand_path(File.dirname("."))
    drive_letter = ""
    if Helper.os_windows?
      path.gsub!(/^[a-z]:/i, "")
      drive_letter = $&
    end
    while path != ""
      if File.directory?("#{path}/#{LOCAL_SETTING_DIR}")
        @@root_dir = drive_letter + path
        break
      end
      path.gsub!(%r!/[^/]*$!, "")
    end
    @@root_dir
  end

  def get_local_setting_dir
    return @@local_setting_dir if @@local_setting_dir
    root_dir = get_root_dir
    if root_dir
      @@local_setting_dir = File.join(root_dir, LOCAL_SETTING_DIR)
    end
    @@local_setting_dir
  end

  def get_global_setting_dir
    return @@global_setting_dir if @@global_setting_dir
    @@global_setting_dir = File.expand_path(File.join("~", GLOBAL_SETTING_DIR))
    unless File.exists?(@@global_setting_dir)
      FileUtils.mkdir(@@global_setting_dir)
    end
    @@global_setting_dir
  end

  def get_script_dir
    @@script_dir ||= File.expand_path(File.join(File.dirname(__FILE__), ".."))
  end

  def already_init?
    !!get_root_dir
  end

  def init
    return nil if already_init?
    FileUtils.mkdir(LOCAL_SETTING_DIR)
    puts LOCAL_SETTING_DIR + "/ を作成しました"
    Database.init
  end

  def alias_to_id(target)
    aliases = LocalSetting.get["alias"]
    if aliases[target]
      return aliases[target]
    end
    target
  end

  def novel_frozen?(target)
    id = Downloader.get_id_by_target(target) or return false
    LocalSetting.get["freeze"].include?(id)
  end

  def get_preset_dir
    return @@preset_dir if @@preset_dir
    @@preset_dir = File.expand_path(File.join(get_script_dir, PRESET_DIR))
    @@preset_dir
  end

  def create_aozoraepub3_jar_path(*paths)
    File.expand_path(File.join(*paths, AOZORAEPUB3_JAR_NAME))
  end

  def aozoraepub3_directory?(path)
    File.exists?(create_aozoraepub3_jar_path(path))
  end

  #
  # AozoraEpub3 の実行ファイル(.jar)のフルパス取得
  # 検索順序
  # 1. グローバルセッティング (global_setting aozoraepub3dir)
  # 2. 小説保存ディレクトリ(Narou.get_root_dir) 直下の AozoraEpub3
  # 3. スクリプト保存ディレクトリ(Narou.get_script_dir) 直下の AozoraEpub3
  #
  def get_aozoraepub3_path
    return @@aozora_jar_path if @@aozora_jar_path
    global_setting_aozora_path = GlobalSetting.get["global_setting"]["aozoraepub3dir"]
    if global_setting_aozora_path
      aozora_jar_path = create_aozoraepub3_jar_path(global_setting_aozora_path)
      if File.exists?(aozora_jar_path)
        @@aozora_jar_path = aozora_jar_path
        return aozora_jar_path
      end
    end
    [Narou.get_root_dir, Narou.get_script_dir].each do |dir|
      aozora_jar_path = create_aozoraepub3_jar_path(dir, AOZORAEPUB3_DIR)
      if File.exists?(aozora_jar_path)
        @@aozora_jar_path = aozora_jar_path
        return aozora_jar_path
      end
    end
    nil
  end

  def create_novel_filename(novel_data, ext = "")
    author, title = %w(author title).map { |k|
      Helper.replace_filename_special_chars(novel_data[k], true)
    }
    "[#{author}] #{title}#{ext}"
  end

  def get_mobi_path(target)
    get_ebook_file_path(target, ".mobi")
  end

  def get_ebook_file_path(target, ext)
    data = Downloader.get_data_by_target(target)
    return nil unless data
    dir = Downloader.get_novel_data_dir_by_target(target)
    File.join(dir, create_novel_filename(data, ext))
  end

  require_relative "device"

  def get_device(device_name = nil)
    device_name = LocalSetting.get["local_setting"]["device"] unless device_name
    if device_name && Device.exists?(device_name)
      return Device.create(device_name)
    end
    nil
  end
end
