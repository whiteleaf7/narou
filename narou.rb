#! ruby
# -*- coding: UTF-8 -*-
#
# Narou.rb ― 小説家になろうダウンロード＆整形スクリプト
#
# Copyright 2013 whiteleaf. All rights reserved.
#

$debug = File.exists?(File.join(File.expand_path(File.dirname($0)), "debug"))
Encoding.default_external = Encoding::UTF_8

require "optparse"
require_relative "lib/logger"
require_relative "lib/version"
require_relative "lib/commandline"

rescue_level = $debug ? Exception : StandardError

begin
  display_backtrace = $debug
  ARGV.options.on("--backtrace") { display_backtrace = true }
  ARGV.parse!
  CommandLine.run(ARGV)
rescue rescue_level => e
  warn $@.shift + ": #{e.message} (#{e.class})"
  if display_backtrace
    $@.each do |b|
      warn "  from #{b}"
    end
  else
    puts "  エラーが発生したため終了しました。"
    puts "  詳細なエラーは --backtrace オプションを付けて再度実行して下さい。"
  end
  exit 1
end
