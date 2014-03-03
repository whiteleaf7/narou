#! /usr/bin/env ruby
# -*- coding: utf-8 -*-
#
# Narou.rb ― 小説家になろうダウンロード＆整形スクリプト
#
# Copyright 2013 whiteleaf. All rights reserved.
#

$debug = File.exists?(File.join(File.expand_path(File.dirname($0)), "debug"))
watch = File.exists?(File.join(File.expand_path(File.dirname($0)), "watch"))
Encoding.default_external = Encoding::UTF_8

require_relative "lib/globalsetting"

display_time = ARGV.delete("--time")
display_backtrace = ARGV.delete("--backtrace")
display_backtrace ||= $debug
$disable_color = ARGV.delete("--no-color")
$disable_color ||= GlobalSetting.get["global_setting"]["no-color"]

require_relative "lib/logger"
require_relative "lib/version"
require_relative "lib/commandline"

rescue_level = $debug ? Exception : StandardError

if watch
  require_relative "lib/watcher"
  Watcher.__regist__ Helper, LocalSetting, Device, WinAPI, Narou, GlobalSetting, Command,
                     Database, SiteSetting, Template, Downloader, Ini, NovelSetting, Inspector,
                     Illustration, ProgressBar, ConverterBase, NovelConverter, CommandLine
end

if display_time
  now = Time.now
  at_exit do
    puts "実行時間 #{Time.now - now}秒"
  end
end

begin
  CommandLine.run(ARGV.map { |v| v.dup })
rescue rescue_level => e
  warn $@.shift + ": #{e.message} (#{e.class})"
  if display_backtrace
    $@.each do |b|
      warn "  from #{b}"
    end
  else
    warn "  エラーが発生したため終了しました。"
    warn "  詳細なエラーは --backtrace オプションを付けて再度実行して下さい。"
  end
  exit 1
end

