# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "singleton"
require "stringio"
require_relative "color"

if $disable_color
  class String
    def termcolor
      self.gsub(/<\/?.+?>/, "").gsub("&lt;", "<").gsub("&gt;", ">")
    end
  end
end

module LoggerModule
  def initialize
    super
    @is_silent = false
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

class Logger < StringIO
  include Singleton
  include LoggerModule
  
  def self.get
    instance
  end

  def write(str)
    str = str.to_s
    if str.encoding == Encoding::ASCII_8BIT
      str.force_encoding(Encoding::UTF_8)
    end
    super(str)
    write_console(str, STDOUT)
  end
end

class LoggerError < StringIO
  include Singleton
  include LoggerModule
  
  def self.get
    instance
  end

  def write(str)
    str = str.to_s
    if str.encoding == Encoding::ASCII_8BIT
      str.force_encoding(Encoding::UTF_8)
    end
    super(str)
    write_console(str, STDERR)
  end
end

def error(str)
  warn "<bold><red>[ERROR]</red></bold> #{TermColor.escape(str)}".termcolor
end

$stdout = Logger.get
$stderr = LoggerError.get
