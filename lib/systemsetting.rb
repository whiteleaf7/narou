# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "yaml"
require "singleton"
require_relative "narou"

class SystemSettingBase
  include Singleton

  def self.get
    instance
  end

  def initialize
    @settings = load_settings
    @modified_list = {}
  end

  def [](name)
    setting = @settings[name]
    unless setting
      setting = {}
      @settings[name] = setting
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
    @settings[name] = setting
  end

  def get_setting_dir
    raise "need override this function"
  end

  def save_settings
    @modified_list.each_key do |sname|
      path = File.join(get_setting_dir, sname + ".yaml")
      File.write(path, YAML.dump(@settings[sname]))
    end
  end

  #
  # .narou 以下に保存されている *.yaml の拡張子を取った部分をキーとして
  # 設定をハッシュとして取得する
  #
  def load_settings
    settings = {}
    setting_dir = get_setting_dir
    if setting_dir
      Dir.glob(File.join(setting_dir, "*.yaml")) do |path|
        name = File.basename(path, ".yaml")
        settings[name] = YAML.load_file(path)
      end
    end
    settings
  end
end

class LocalSetting < SystemSettingBase
  def get_setting_dir
    Narou.get_local_setting_dir
  end
end

class GlobalSetting < SystemSettingBase
  def get_setting_dir
    Narou.get_global_setting_dir
  end
end

