#! ruby
# -*- coding: UTF-8 -*-
#
# Narou.rb ― 小説家になろうダウンロード＆整形スクリプト
#
# Copyright 2013 whiteleaf. All rights reserved.
#

$debug = File.exists?(File.join(File.expand_path(__FILE__), "debug"))
Encoding.default_external = Encoding::UTF_8

require_relative "lib/logger"         # 標準出力と標準エラーのロギング開始
require_relative "lib/version"
require_relative "lib/commandline"

if $debug
  begin
    CommandLine.run(ARGV)
  rescue Exception => e
    puts $@.shift + ": #{e.message} (#{e.class})"
    $@.each do |b|
      warn "  from #{b}"
    end
    exit 1
  end
else
  CommandLine.run(ARGV)
end
