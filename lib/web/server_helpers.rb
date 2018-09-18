# frozen_string_literal: true

#
# Copyright 2013 whiteleaf. All rights reserved.
#

# rubocop:disable Style/ClassAndModuleChildren

module Narou::ServerHelpers
  RELOAD_TIMING_DEFAULT = "every"

  #
  # タグをHTMLで装飾する
  #
  def decorate_tags(tags)
    tags.sort.map do |tag|
      %!<span class="tag label label-#{Command::Tag.get_color(tag)}" data-tag="#{escape_html(tag)}">#{escape_html(tag)}</span>!
    end.join(" ")
  end

  #
  # タグをHTMLで装飾する(除外タグ指定用)
  #
  def decorate_exclusion_tags(tags)
    tags.sort.map do |tag|
      %!<span class="tag label label-#{Command::Tag.get_color(tag)}" data-exclusion-tag="#{escape_html(tag)}">^tag:#{escape_html(tag)}</span>!
    end.join(" ")
  end

  #
  # Rubyバージョンを構築
  #
  def build_ruby_version
    begin
      `"#{RbConfig.ruby}" -v`.strip
    rescue
      config = RbConfig::CONFIG
      "ruby #{RUBY_VERSION}p#{config["PATCHLEVEL"]} [#{RUBY_PLATFORM}]"
    end
  end

  #
  # 有効な novel ID だけの配列を生成する
  # ID が指定されなかったか、１件も存在しない場合は nil を返す
  #
  def select_valid_novel_ids(ids)
    return nil unless ids.kind_of?(Array)
    result = ids.select do |id|
      id =~ /^\d+$/
    end
    result.empty? ? nil : result
  end

  #
  # フォーム情報の真偽値データを実際のデータに変換
  #
  def convert_on_off_to_boolean(str)
    case str
    when "on"
      true
    when "off"
      false
    else
      nil
    end
  end

  #
  # nil true false を nil on off という文字列に変換
  #
  def convert_boolean_to_on_off(bool)
    case bool
    when TrueClass
      "on"
    when FalseClass
      "off"
    else
      "nil"
    end
  end

  #
  # HTMLエスケープヘルパー
  #
  def h(text)
    Rack::Utils.escape_html(text)
  end

  #
  # 与えられたデータが真偽値だった場合、設定画面用に「はい」「いいえ」に変換する
  # 真偽値ではなかった場合、そのまま返す
  #
  def value_to_msg(value)
    case value
    when TrueClass
      "はい"
    when FalseClass
      "いいえ"
    else
      value
    end
  end

  def notepad_text_path
    File.join(Narou.local_setting_dir, "notepad.txt")
  end

  def query_to_boolean(value, default: false)
    case value
    when "1", 1, "true", true
      true
    when "0", 0, "false", false
      false
    else
      default
    end
  end

  def table_reload_timing
    Inventory.load("local_setting")["webui.table.reload-timing"] || RELOAD_TIMING_DEFAULT
  end

  def partial(template, *args)
    template_file_name = "_#{template}".intern
    options = args.last.is_a?(Hash) ? args.pop : {}
    options[:layout] = false
    collection = options.delete(:collection)
    if collection
      collection.inject([]) do |buffer, member|
        buffer << haml(template_file_name, options.merge(locals: { template => member }))
      end.join("\n")
    else
      haml(template_file_name, options)
    end
  end

  def embed_concurrency_enabled
    <<~HTML
      <input type="hidden" id="concurrency-enabled" value="#{Narou.concurrency_enabled?}">
    HTML
  end

  def concurrency_push(&block)
    if Narou.concurrency_enabled?
      yield
    else
      Narou::WebWorker.push(&block)
    end
  end
end
