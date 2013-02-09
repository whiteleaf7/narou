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

  def save_settings
    @local_settings.each do |name, setting|
      open(File.join(Narou.get_local_setting_dir, name + ".yaml"), "w") do |fp|
        fp.write(YAML.dump(setting))
      end
    end
  end

  #
  # .narou 以下に保存されている *.yaml の拡張子を取った部分をキーとして
  # 設定をハッシュとして取得する
  #
  def load_settings
    settings = {}
    Dir.glob(File.join(Narou.get_local_setting_dir, "*.yaml")) do |path|
      name = File.basename(path, ".yaml")
      settings[name] = YAML.load_file(path)
    end
    settings
  end
end
