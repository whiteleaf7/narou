# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "singleton"
require "stringio"

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

  def save(path)
    File.write(path, string)
  end
end

class Logger < StringIO
  include Singleton
  include LoggerModule
  
  def self.get
    instance
  end

  def write(str)
    super
    unless @is_silent
      STDOUT.write(str)
    end
  end
end

class LoggerError < StringIO
  include Singleton
  include LoggerModule
  
  def self.get
    instance
  end

  def write(str)
    super
    unless @is_silent
      STDERR.write(str)
    end
  end
end

$stdout = Logger.get
$stderr = LoggerError.get
