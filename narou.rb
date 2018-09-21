#! /usr/bin/env ruby
# frozen_string_literal: true

#
# Narou.rb ― 小説家になろうダウンロード＆整形スクリプト
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "config/bootsnap_setup"

require_relative "lib/extension"
require_relative "lib/extensions/monkey_patches"
require_relative "lib/backtracer"

script_dir = File.expand_path(File.dirname(__FILE__))
$debug = File.exist?(File.join(script_dir, "debug"))

Encoding.default_external = Encoding::UTF_8
Narou::Backtracer.argv = ARGV

if ARGV.delete("--time")
  now = Time.now
  at_exit do
    puts "実行時間 #{Time.now - now}秒"
  end
end

require_relative "lib/inventory"

$development = Narou.commit_version.!
if $development
  begin
    require "pry"
    require "awesome_print"
  rescue LoadError
  end
end

global = Inventory.load("global_setting", :global)
$display_backtrace = ARGV.delete("--backtrace")
$display_backtrace ||= $debug
$disable_color = ARGV.delete("--no-color")
$disable_color ||= global["no-color"]
$color_parser ||= global["color-parser"] || "system"

require_relative "lib/narou_logger"
require_relative "lib/version"
require_relative "lib/commandline"

exit Narou::Backtracer.capture {
  CommandLine.run!(ARGV.map(&:dup))
}
