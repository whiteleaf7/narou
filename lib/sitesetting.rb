# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "yaml"
require_relative "narou/api"

class SiteSetting
  NOVEL_SITE_SETTING_DIR = "webnovel/"

  class << self
    #
    # 小説サイトの定義ファイルを全部読み込む
    #
    # スクリプト同梱の設定ファイルを読み込んだあと、ユーザの小説の管理ディレクトリ内にある
    # webnovel ディレクトリからも定義ファイルを読み込む
    #
    def load_settings
      result = []
      load_paths = [
        File.join(Narou.get_script_dir, NOVEL_SITE_SETTING_DIR, "*.yaml"),
        File.join(Narou.get_root_dir, NOVEL_SITE_SETTING_DIR, "*.yaml")
      ].uniq.join("\0")
      Dir.glob(load_paths) do |path|
        setting = SiteSetting.load_file(path)
        if setting["name"] == "小説家になろう"
          @narou = setting
        end
        result << setting
      end
      if result.empty?
        error "小説サイトの定義ファイルがひとつもありません"
        exit Narou::EXIT_ERROR_CODE
      end
      unless @narou
        error "小説家になろうの定義ファイルが見つかりませんでした"
        exit Narou::EXIT_ERROR_CODE
      end
      # TODO: 配列の並び順で先頭をなろうにしておく。find するときになろうがすぐ引っかかるので効率的
      # 設定ファイルに priority を追加して、それでソートする
      result
    end

    def settings
      @settings ||= load_settings
    end

    def narou
      settings unless @narou
      @narou.clone
    end

    def find(toc_url)
      result = nil
      settings.each do |s|
        setting = s.clone
        if setting.multi_match(toc_url, "url")
          result = setting
          break
        end
      end
      result
    end

    def load_file(path)
      new(path)
    end
  end

  def [](key)
    replace_group_values(key)
  end

  def []=(key, value)
    @match_values[key] = value
  end

  def clear
    @match_values.clear
  end

  def initialize(path)
    @match_values = {}
    @yaml_setting = YAML.load_file(path).freeze
  end

  def initialize_copy(obj)
    @match_values = {}
  end

  def matched?(key)
    @match_values[key]
  end

  def multi_match(source, *keys)
    match_data = nil
    keys.each do |key|
      setting_value = self[key] or next
      [*setting_value].each do |value|
        match_data = source.match(/#{value}/m)
        if match_data
          @match_values[key] = value       # yamlのキーでもmatch_valuesに設定しておくが、
          update_match_values(match_data)  # ←ここで同名のグループ名が定義されていたら上書きされるので注意
                                           # 例えば、title: <title>(?<title>.+?)</title> と定義されていた場合、
                                           # @match_values["title"] には (?<title>.+?) 部分の要素が反映される
          break
        end
      end
    end
    match_data
  end

  def multi_match_once(source, *keys)
    clear
    multi_match(source, *keys)
  end

  def update_match_values(match_data)
    match_data.names.each do |name|
      @match_values[name] = match_data[name] || ""
    end
  end

  def is_container?(value)
    value.is_a?(Hash) || value.is_a?(Narou::API)
  end

  def replace_group_values(key, option_values = {})
    buf = option_values[key] || @match_values[key] || @yaml_setting[key]
    return buf if is_container?(buf)
    if buf.is_a?(Array)
      buf.map do |dest|
        do_replace(dest, option_values)
      end
    else
      do_replace(buf, option_values)
    end
  end

  def do_replace(dest, option_values)
    return dest unless dest.respond_to?(:gsub)
    values = @yaml_setting.merge(@match_values).merge(option_values)
    dest.gsub(/\\\\k<(.+?)>/) do |match|
      value = values[$1]
      if value
        value.gsub(/\\\\k<(.+?)>/) do
          replace_group_values($1, option_values)
        end
      else
        match
      end
    end
  end
end
