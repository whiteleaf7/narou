# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "fileutils"
require_relative "helper"
require_relative "localsetting"

module Narou
  LOCAL_SETTING_DIR = ".narou"

  @@root_dir = nil

  def self.get_root_dir
    return @@root_dir if @@root_dir
    path = File.expand_path(File.dirname("."))
    drive_letter = ""
    if Helper.os_windows?
      path.gsub!(/^[a-z]:/i, "")
      drive_letter = $&
    end
    while path != ""
      unless Dir.glob("#{path}/#{LOCAL_SETTING_DIR}").empty?
        @@root_dir = drive_letter + path
        break
      end
      path.gsub!(%r!/[^/]*$!, "")
    end
    @@root_dir
  end

  def self.get_local_setting_dir
    File.join(get_root_dir, LOCAL_SETTING_DIR)
  end

  def self.get_script_dir
    File.expand_path(File.dirname($0))
  end

  def self.already_init?
    !!get_root_dir
  end

  def self.init
    return nil if already_init?
    FileUtils.mkdir(LOCAL_SETTING_DIR)
    puts LOCAL_SETTING_DIR + "/ を作成しました"
    Database.init
    puts "初期化が完了しました"
  end

  def self.alias_to_id(target)
    aliases = LocalSetting.get["alias"]
    if aliases[target]
      return aliases[target]
    end
    target
  end
end
