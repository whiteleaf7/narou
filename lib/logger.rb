# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "stringio"
require "termcolorlight"
require_relative "color"

if $disable_color
  class String
    def termcolor
      TermColorLight.strip_tag(self)
    end
  end
end

module Narou end unless defined?(Narou)

module Narou::LoggerModule
  attr_accessor :capturing

  def initialize
    super
    @is_silent = false
    @capturing = false
  end

  def copy_instance
    self.class.new.tap { |obj|
      obj.silent = silent
    }
  end

  def silent=(enable)
    @is_silent = !!enable
  end

  def silent
    if block_given?
      if /^(.+?):(\d+)/ =~ caller.first
        file = $1
        line = $2.to_i
        error_msg = "Did you mean: silence\n"
        str = File.read(file).split("\n")[line-1]
        error_msg += "in #{file}:#{line}\n"
        error_msg += str + "\n"
        error_msg +=  " " * str.index("silent") + "~~~~~~"
        raise error_msg
      end
    end
    @is_silent
  end

  def silence(&block)
    raise "need a block" unless block
    tmp = self.silent
    self.silent = true
    block.call
    self.silent = tmp
  end

  #
  # 標準出力($stdout)のバッファリング＋取得
  #
  # キャプチャー用途なので標準エラーはキャプチャーしない
  # quiet :: 標準出力に出力をしないかどうか
  # ansicolor_strip :: エスケープシーケンスを除去するか
  #
  def capture(options = {}, &block)
    options = {
      quiet: true, ansicolor_strip: true
    }.merge(options)
    raise "#capture block given" unless block
    temp_stream = $stdout
    $stdout = (self == $stdout ? copy_instance : self)
    $stdout.capturing = true
    if options[:quiet]
      $stdout.silence { block.call }
    else
      block.call
    end
    $stdout.capturing = false
    buffer = $stdout.string
    $stdout = temp_stream
    options[:ansicolor_strip] ? strip_color(buffer) : buffer
  end

  def strip_color(str)
    if $disable_color
      str
    else
      str.gsub(/(?:\e\[\d*[a-zA-Z])+/, "")
    end
  end

  def save(path)
    File.write(path, strip_color(string))
  end

  def write_console(str, target)
    unless @is_silent
      if $disable_color
        target.write(str)
      else
        write_color(str, target)
      end
    end
  end
end

class Narou::Logger < StringIO
  include Narou::LoggerModule
  
  def write(str)
    str = str.to_s
    if str.encoding == Encoding::ASCII_8BIT
      str.force_encoding(Encoding::UTF_8)
    end
    super(str)
    write_console(str, STDOUT)
  end

  def tty?
    STDOUT.tty?
  end
end

class Narou::LoggerError < StringIO
  include Narou::LoggerModule

  def write(str)
    str = str.to_s
    if str.encoding == Encoding::ASCII_8BIT
      str.force_encoding(Encoding::UTF_8)
    end
    super(str)
    write_console(str, STDERR)
  end

  def tty?
    STDERR.tty?
  end
end

def warn(str)
  puts str
end

def error(str)
  puts "<bold><red>[ERROR]</red></bold> ".termcolor + str
end

$stdout = Narou::Logger.new
$stderr = Narou::LoggerError.new
