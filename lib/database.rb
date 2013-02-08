# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "fileutils"
require "singleton"
require "yaml"
require_relative "narou"

class Database
  include Singleton

  ARCHIVE_ROOT_DIR_PATH = "小説データ/"
  DATABASE_FILE_PATH = ARCHIVE_ROOT_DIR_PATH + "database.yaml"

  @@archive_root_path = File.expand_path(File.join(Narou.get_root_dir, ARCHIVE_ROOT_DIR_PATH))
  @@database_path = File.expand_path(File.join(Narou.get_root_dir, DATABASE_FILE_PATH))

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

  def initialize
    @database = self.class.load_database
  end

  #
  # データベース初期設定
  #
  def self.init
    unless File.exists?(ARCHIVE_ROOT_DIR_PATH)
      FileUtils.mkdir(ARCHIVE_ROOT_DIR_PATH)
    end
  end

  #
  # 小説格納用のルートディレクトリを取得
  #
  def self.archive_root_path
    @@archive_root_path
  end

  def self.load_database
    database = YAML.load_file(@@database_path)
  rescue Errno::ENOENT
    database = {}
  ensure
    database
  end

  def save_database
    open(@@database_path, "w") do |fp|
      fp.write(YAML.dump(@database))
    end
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
end
