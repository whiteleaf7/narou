# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

class Ini
  DELIMITER = "="
  GLOBAL_SECTION = "global"
  COMMENT_SYMBOL = ";"

  attr_accessor :filename

  class NoFilenameError < StandardError
    def initialize
      super("filename required")
    end
  end

  def self.load(text)
    ini = new(text)
    ini.object
  end

  def self.load_file(file)
    text = ""
    case
    when file.kind_of?(String)
      text = open(file, "r:BOM|UTF-8") { |fp| fp.read }
      ini = new(text)
      ini.filename = file
      return ini.object
    when file.respond_to?(:read)
      text = file.read
      return load(text)
    else
      raise NoFilenameError
    end
  end

  def initialize(text = "")
    clear
    parse(text)
    @filename = nil
  end

  def object
    @data
  end

  def clear
    @data = { GLOBAL_SECTION => {} }
  end

  def parse(text)
    section = GLOBAL_SECTION
    text.each_line do |line|
      next if line.strip == ""
      next if line[0] == COMMENT_SYMBOL
      key, value = line.split(DELIMITER, 2).map(&:strip)
      if key && value
        @data[section][key] = cast(value)
        next
      end
      if /^\[(.+?)\]/ =~ line
        section = $1.strip
        @data[section] ||= {}
        next
      end
    end
  end

  def cast(str)
    value = nil
    case str
    when /^[+-]?\d+$/
      value = str.to_i
    when /^[+-]?\d*\.\d+$/
      value = str.to_f
    when /^true$/i
      value = true
    when /^false$/i
      value = false
    when /^(?:nil|null)$/i
      value = nil
    else
      if str.length > 0
        if str =~ /^(["'])(.+)\1$/
          value = $2
        else
          value = str
        end
      else
        value = nil
      end
    end
    value
  end

  def save(filename = nil)
    filename ||= @filename
    unless filename
      raise NoFilenameError
    end
    open(@filename, "w") do |fp|
      @data.each do |section, values|
        if section != GLOBAL_SECTION
          fp.puts("[#{section}]")
        end
        values.each do |key, value|
          fp.puts(key + DELIMITER + value)
        end
      end
    end
  end
end
