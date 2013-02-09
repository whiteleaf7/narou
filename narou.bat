@echo off
REM -*- mode: ruby -*-
@if not "%~d0" == "~d0" goto WinNT
ruby -x narou.bat %1 %2 %3 %4 %5 %6 %7 %8 %9
@goto endofruby
:WinNT
ruby -x "%~f0" %*
@goto endofruby
#! ruby
# -*- coding: UTF-8 -*-
#
# Narou.rb ― 小説家になろうダウンロード＆整形スクリプト
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "lib/commandline"

$debug = false

Encoding.default_external = Encoding::UTF_8
Version = "0.1"

if $debug
  begin
    CommandLine.run(ARGV)
  rescue Exception => e
    backtrace = e.backtrace
    puts backtrace.shift + ": #{e.message} (#{e.class})"
    backtrace.each do |b|
      puts "  from #{b}"
    end
    exit 1
  end
else
  CommandLine.run(ARGV)
end

__END__
:endofruby
