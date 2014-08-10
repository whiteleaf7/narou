# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "yaml"
require "singleton"
require_relative "narou"

#
# ユーザープロファイルに保存するのでいつでも反映される設定
#
class GlobalSetting
  include Singleton

  def self.get
    instance
  end

  def initialize
    @global_settings = load_settings
    @modified_list = {}
  end

  def [](name)
    setting = @global_settings[name]
    unless setting
      setting = {}
      @global_settings[name] = setting
    end
    # 変更されたか監視する機能をHashオブジェクトに追加
    setting.instance_variable_set(:@list_ref, @modified_list)
    setting.instance_variable_set(:@name_ref, name)
    def setting.[]=(k, v)
      @list_ref[@name_ref] = true
      super
    end
    setting
  end

  def []=(name, setting)
    @global_settings[name] = setting
  end

  def save_settings
    @modified_list.each_key do |sname|
      path = File.join(Narou.get_global_setting_dir, sname + ".yaml")
      File.write(path, YAML.dump(@global_settings[sname]))
    end
  end

  #
  # .narou 以下に保存されている *.yaml の拡張子を取った部分をキーとして
  # 設定をハッシュとして取得する
  #
  def load_settings
    settings = {}
    global_setting_dir = Narou.get_global_setting_dir
    if global_setting_dir
      Dir.glob(File.join(global_setting_dir, "*.yaml")) do |path|
        name = File.basename(path, ".yaml")
        settings[name] = YAML.load_file(path)
      end
    end
    settings
  end
end
