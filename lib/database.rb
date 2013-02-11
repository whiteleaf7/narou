# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "fileutils"
require "singleton"
require "yaml"
require_relative "narou"
require_relative "localsetting"

class Database
  include Singleton

  ARCHIVE_ROOT_DIR_PATH = "小説データ/"
  DATABASE_NAME = "database"

  if Narou.already_init?
    @@archive_root_path = File.expand_path(File.join(Narou.get_root_dir, ARCHIVE_ROOT_DIR_PATH))
  end

  def [](key)
    @database[key]
  end

  def []=(key, value)
    @database[key] = value
  end

  def each(&block)
    if block
      @database.each(&block)
    else
      @database.each
    end
  end

  def delete(key)
    @database.delete(key)
  end

  def initialize
    @database = LocalSetting.get[DATABASE_NAME]
  end

  #
  # データベース初期設定
  #
  def self.init
    unless File.exists?(ARCHIVE_ROOT_DIR_PATH)
      FileUtils.mkdir(ARCHIVE_ROOT_DIR_PATH)
      puts ARCHIVE_ROOT_DIR_PATH + " を作成しました"
    end
  end

  #
  # 小説格納用のルートディレクトリを取得
  #
  def self.archive_root_path
    @@archive_root_path
  end

  def save_database
    LocalSetting.get.save_settings(DATABASE_NAME)
  end

  def get_object
    @database
  end

  def novel_exists?(id)
    return nil if id.nil?
    @database.keys.include?(id.to_i)
  end

  def get_data(type, value)
    @database.each do |_, data|
      return data if data[type] == value
    end
    nil
  end

  def get_id(type, value)
    data = get_data(type, value)
    if data
      return data["id"]
    end
    nil
  end

  def get_new_id
    max_id = @database.keys.max
    id = max_id ? max_id + 1 : 0
    id
  end

  #
  # last_update で更新順にソート
  #
  def sort_by_last_update
    values = @database.values.sort_by { |v| v["last_update"] }.reverse
    values
  end
end
