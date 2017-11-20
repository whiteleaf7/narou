# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "fileutils"
require "singleton"
require "yaml"
require_relative "narou"
require_relative "inventory"

class Database
  include Singleton
  include Enumerable

  ARCHIVE_ROOT_DIR_PATH = "小説データ/"
  DATABASE_NAME = "database"

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

  def each_key(&block)
    if block
      @database.each_key(&block)
    else
      @database.each_key
    end
  end

  def delete(key)
    @database.delete(key)
  end

  def initialize
    refresh
  end

  def refresh
    @database = Inventory.load(DATABASE_NAME)
  end

  #
  # データベース初期設定
  #
  def self.init
    unless File.exist?(ARCHIVE_ROOT_DIR_PATH)
      FileUtils.mkdir(ARCHIVE_ROOT_DIR_PATH)
      puts ARCHIVE_ROOT_DIR_PATH + " を作成しました"
    end
  end

  #
  # 小説格納用のルートディレクトリを取得
  #
  def self.archive_root_path
    @archive_root_path ||= File.expand_path(File.join(Narou.get_root_dir, ARCHIVE_ROOT_DIR_PATH))
  end

  def save_database
    @database.save
  end

  def get_object
    @database
  end

  def ids
    @database.keys
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

  # SiteSetting を使って toc url を正規化してマッチングする。
  # get_data("toc_url", url) だと、アドレスが仕様変更した場合に、
  # 古いままのデータとマッチングしなくなるため
  def get_data_by_toc_url(toc_url, site_setting)
    @database.each do |_, data|
      site_setting.multi_match_once(data["toc_url"], "url") or next
      return data if site_setting["toc_url"] == toc_url
    end
    nil
  end

  def create_new_id
    max_id = @database.keys.max
    id = max_id ? max_id + 1 : 0
    id
  end

  def sort_by(key, reverse: true)
    values = @database.values.sort_by { |v| v[key] }
    if reverse
      values.reverse
    else
      values
    end
  end

  def tag_indexies
    result = Hash.new { [] }
    @database.each do |id, data|
      tags = data["tags"] || []
      tags.each do |tag|
        result[tag.to_s] |= [id]
      end
    end
    result
  end
end
