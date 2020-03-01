# frozen_string_literal: true

#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "helper"

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
    if file.is_a?(String)
      text = File.read(file, mode: "r:BOM|UTF-8")
      ini = new(text)
      ini.filename = file
      ini.object
    elsif file.respond_to?(:read)
      text = file.read
      load(text)
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
      next unless /^\[(.+?)\]/ =~ line
      section = $1.strip
      @data[section] ||= {}
      next
    end
  end

  def cast(str)
    value = nil
    value = case str
            when /^[+-]?\d+$/
              str.to_i
            when /^[+-]?\d*\.\d+$/
              str.to_f
            when /^true$/i
              true
            when /^false$/i
              false
            when /^(?:nil|null)$/i
              nil
            else
              if str.length > 0
                if str =~ /^(["'])(.+)\1$/
                  $2
                else
                  str
                        end
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
          value = "\"#{value}\"" if value.is_a?(String)
          fp.puts("#{key} #{DELIMITER} #{value}")
        end
      end
    end
  end
end
