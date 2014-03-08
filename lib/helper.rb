# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "open3"

#
# 雑多なお助けメソッド群
#
# MacOSX 関連は確認してないので動作するか不明
#
module Helper
  extend self

  def os_windows?
    @@os_is_windows ||= RUBY_PLATFORM =~ /mswin(?!ce)|mingw|bccwin/i
  end

  def os_cygwin?
    @@os_is_cygwin ||= RUBY_PLATFORM =~ /cygwin/i
  end

  def os_mac?
    @@os_is_mac ||= RUBY_PLATFORM =~ /darwin/
  end

  def determine_os
    case
    when os_windows?
      :windows
    when os_cygwin?
      :cygwin
    when os_mac?
      :mac
    else
      :other
    end
  end

  def confirm(message)
    confirm_msg = "#{message} (y/n)?: "
    STDOUT.print confirm_msg   # Logger でロギングされないように直接標準出力に表示
    while input = $stdin.gets
      case input[0].downcase
      when "y"
        return true
      when "n"
        return false
      else
        STDOUT.print confirm_msg
      end
    end
  end

  def open_browser_linux(address, error_message)
    %w(xdg-open firefox w3m).each do |browser|
      system(%!#{browser} "#{address}"!)
      return if $?.exitstatus != 127
    end
    error error_message
  end

  def open_directory(path, confirm_message = nil)
    if confirm_message
      return unless confirm(confirm_message)
    end
    case determine_os
    when :windows
      `explorer "file:///#{path.encode(Encoding::Windows_31J)}"`
    when :cygwin
      `cygstart "#{path}"`
    when :mac
      `open "#{path}"`
    else
      open_browser_linux(path, "フォルダが開けませんでした")
    end
  end

  def open_browser(url)
    case determine_os
    when :windows
      escaped_url = url.gsub("%", "%^").gsub("&", "^&")
      # MEMO: start の引数を "" で囲むと動かない
      `start #{escaped_url}`
    when :cygwin
      `cygstart #{url}`
    when :mac
      `open "#{url}"`
    else
      open_browser_linux(url, "ブラウザが見つかりませんでした")
    end
  end

  def print_horizontal_rule
    puts "―" * 35
  end

  def replace_filename_special_chars(str, invalid_replace = false)
    result = str.tr("/:*?\"<>|.", "／：＊？”〈〉｜．").gsub("\\", "￥").gsub("\t", "")
    if invalid_replace
      org_encoding = result.encoding
      result = result.encode(Encoding::Windows_31J, invalid: :replace, undef: :replace, replace: "_")
                     .encode(org_encoding)
    end
    result
  end

  #
  # ダウンロードしてきたデータを使いやすいように処理
  #
  def pretreatment_source(src, encoding = Encoding::UTF_8)
    restor_entity(src.force_encoding(encoding)).gsub("\r", "")
  end

  ENTITIES = { quot: '"', amp: "&", nbsp: " ", lt: "<", gt: ">", copy: "(c)" }
  #
  # エンティティ復号
  #
  def restor_entity(str)
    result = str.encode("UTF-16BE", "UTF-8", :invalid => :replace, :undef => :replace, :replace => "?").encode("UTF-8")
    ENTITIES.each do |key, value|
      result.gsub!("&#{key};", value)
    end
    result
  end

  #
  # CYGWINのパスからwindowsのパスへと変換(cygpathを呼び出すだけ)
  #
  def convert_to_windows_path(path)
    `cygpath -aw \"#{path}\"`.strip
  end

  #
  # 外部コマンド実行中の待機ループの処理を書けるクラス
  #
  # response = Helper::AsyncCommand.exec("処理に時間がかかる外部コマンド") do
  #   print "*"
  # end
  # if response[2].success?
  #   puts "成功しました"
  # end
  #
  class AsyncCommand
    def self.exec(command, sleep_time = 0.5, &block)
      async_command = new(command)
      while async_command.running?
        block.call
        sleep(sleep_time)
      end
      async_command.response
    end

    def initialize(command)
      @command_response = nil
      @command_running = true
      Thread.new do
        @command_response = Open3.capture3(command)
        @command_running = false
      end
    end

    def running?
      @command_running
    end

    def response
      @command_response
    end
  end
end
