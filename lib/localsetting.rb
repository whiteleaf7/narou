# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "yaml"
require "singleton"
require_relative "narou"

#
# 管理小説のみに適用される設定
#
class LocalSetting
  include Singleton

  def self.get
    instance
  end

  def initialize
    @local_settings = load_settings
  end

  def [](name)
    setting = @local_settings[name]
    unless setting
      setting = {}
      @local_settings[name] = setting
    end
    setting
  end

  def []=(name, setting)
    @local_settings[name] = setting
  end

  def save_settings(name = nil)
    if name
      save_list = { name => @local_settings[name] }
    else
      save_list = @local_settings
    end
    save_list.each do |name, setting|
      path = File.join(Narou.get_local_setting_dir, name + ".yaml")
      File.write(path, YAML.dump(setting))
    end
  end

  #
  # .narou 以下に保存されている *.yaml の拡張子を取った部分をキーとして
  # 設定をハッシュとして取得する
  #
  def load_settings
    settings = {}
    local_setting_dir = Narou.get_local_setting_dir
    if local_setting_dir
      Dir.glob(File.join(local_setting_dir, "*.yaml")) do |path|
        name = File.basename(path, ".yaml")
        settings[name] = YAML.load_file(path)
      end
    end
    settings
  end
end
