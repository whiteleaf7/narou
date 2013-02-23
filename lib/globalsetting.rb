# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "yaml"
require "singleton"

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
  end

  def [](name)
    setting = @global_settings[name]
    unless setting
      setting = {}
      @global_settings[name] = setting
    end
    setting
  end

  def []=(name, setting)
    @global_settings[name] = setting
  end

  def save_settings(name = nil)
    if name
      save_list = { name => @global_settings[name] }
    else
      save_list = @global_settings
    end
    save_list.each do |sname, setting|
      path = File.join(Narou.get_global_setting_dir, sname + ".yaml")
      File.write(path, YAML.dump(setting))
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
