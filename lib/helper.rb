# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "open3"
require_relative "narou"

#
# 雑多なお助けメソッド群
#
module Helper
  AOZORAEPUB3_PATH = "./AozoraEpub3/AozoraEpub3.jar"

  def self.os_windows?
    @@os_is_windows ||= RUBY_PLATFORM =~ /mswin(?!ce)|mingw|cygwin|bccwin/i
  end

  def self.get_aozoraepub3_path
    File.expand_path(File.join(Narou.get_root_dir, AOZORAEPUB3_PATH))
  end

  def self.confirm(message)
    confirm_msg = "#{message} (y/n)?: "
    print confirm_msg
    while input = STDIN.gets
      case input[0].downcase
      when "y"
        return true
      when "n"
        return false
      else
        print confirm_msg
      end
    end
  end

  def self.open_directory_by_os_filer(path, confirm_message = nil)
    if os_windows?
      if confirm_message
        return unless confirm(confirm_message)
      end
      `explorer "file:///#{path.encode(Encoding::Windows_31J)}"`
    end
  end

  def self.open_url_by_browser(url)
    if os_windows?
      escaped_url = url.gsub("%", "%^").gsub("&", "^&")
      `start #{url}`
    end
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
