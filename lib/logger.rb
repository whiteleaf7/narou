# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "singleton"
require "stringio"
require_relative "color"

module LoggerModule
  def initialize
    super
    @is_silent = false
  end

  def silent=(enable)
    @is_silent = !!enable
  end

  def silent
    @is_silent
  end

  def strip_color(str)
    str.gsub(/(?:\e\[\d*[a-zA-Z])+/, "")
  end

  def save(path)
    File.write(path, string)
  end

  def write_console(str, target)
    if str.encoding == Encoding::ASCII_8BIT
      str.force_encoding("utf-8")
    end
    unless @is_silent
      str = strip_color(str) if $disable_color
      write_color(str, target)
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
    super(strip_color(str))
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
    super(strip_color(str))
    write_console(str, STDERR)
  end
end

def error(str)
  warn "<red>[ERROR]</red> #{str}".termcolor
end

$stdout = Logger.get
$stderr = LoggerError.get
