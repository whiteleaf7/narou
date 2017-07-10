#! /usr/bin/env ruby
# -*- coding: utf-8 -*-
#
# Narou.rb ― 小説家になろうダウンロード＆整形スクリプト
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "lib/extension"

script_dir = File.expand_path(File.dirname(__FILE__))
$debug = File.exist?(File.join(script_dir, "debug"))

Encoding.default_external = Encoding::UTF_8

if ARGV.delete("--time")
  now = Time.now
  at_exit do
    puts "実行時間 #{Time.now - now}秒"
  end
end

require_relative "lib/inventory"

$development = Narou.commit_version.!
begin
  if $development
    require "pry"
    require "awesome_print"
  end
rescue LoadError
end

global = Inventory.load("global_setting", :global)
$display_backtrace = ARGV.delete("--backtrace")
$display_backtrace ||= $debug
$disable_color = ARGV.delete("--no-color")
$disable_color ||= global["no-color"]

require_relative "lib/logger"
require_relative "lib/version"
require_relative "lib/commandline"

rescue_level = $debug ? Exception : StandardError

begin
  CommandLine.run(ARGV.map { |v| v.dup })
rescue SystemExit => e
  exit e.status
rescue SyntaxError => e
  warn e
  exit Narou::EXIT_ERROR_CODE
rescue rescue_level => e
  warn "#{$@.shift}: #{e.message.encode(Encoding::UTF_8)} (#{e.class})"
  if $display_backtrace
    $@.each do |b|
      warn "  from #{b}"
    end
  else
    warn "  エラーが発生したため終了しました。"
    warn "  詳細なエラーは --backtrace オプションを付けて再度実行して下さい。"
  end
  exit Narou::EXIT_ERROR_CODE
end

