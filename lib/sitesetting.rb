# frozen_string_literal: true

#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "yaml"
require_relative "narou/api"

class SiteSetting
  NOVEL_SITE_SETTING_DIR = "webnovel/"

  attr_reader :yaml, :path

  class << self
    #
    # 小説サイトの定義ファイルを全部読み込む
    #
    # スクリプト同梱の設定ファイルを読み込んだあと、ユーザの小説の管理ディレクトリ内にある
    # webnovel ディレクトリからも定義ファイルを読み込む
    #
    def load_settings
      result = {}
      load_paths = [
        Narou.script_dir.join(NOVEL_SITE_SETTING_DIR, "*.yaml"),
        Narou.root_dir.join(NOVEL_SITE_SETTING_DIR, "*.yaml")
      ].uniq.join("\0")
      Dir.glob(load_paths) do |path|
        setting = SiteSetting.load_file(path)
        name = setting["name"]
        @narou ||= setting if name == "小説家になろう"
        origin = result[name]
        origin&.merge(setting)
        result[name] ||= setting
      end
      if result.empty?
        error "小説サイトの定義ファイルがひとつもありません"
        exit Narou::EXIT_ERROR_CODE
      end
      unless @narou
        error "小説家になろうの定義ファイルが見つかりませんでした"
        exit Narou::EXIT_ERROR_CODE
      end
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
      settings.each_value do |s|
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

  def initialize(path)
    @match_values = {}
    @yaml = YAML.load_file(path)
    @path = path
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

  def initialize_copy(_obj)
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
    buf = option_values[key] || @match_values[key] || yaml[key]
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
    values = yaml.merge(@match_values).merge(option_values)
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

  EXCLUDE_KEYS = %w(name version)

  def merge(setting)
    validate_version(setting) or return
    (setting.yaml.keys - EXCLUDE_KEYS).each do |key|
      yaml[key] = setting.yaml[key]
    end
  end

  def validate_version(setting)
    version = setting.yaml["version"]
    return true unless version # version が指定されていない場合は常に上書きを許可する
    return true if version >= yaml["version"]

    error "#{setting.path} の内容が古いため読み込みをスキップしました"
    false
  end
end
