# frozen_string_literal: true

#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "stringio"
require "termcolorlight"
require_relative "color"
require_relative "inventory"

if $disable_color
  class String
    def termcolor
      TermColorLight.strip_tag(self)
    end
  end
end

module Narou
  module LoggerModule
    attr_accessor :capturing, :stream, :log_postfix
    attr_reader :logging_enabled, :format_filename, :format_timestamp, :format_timestamp_disabled

    def self.included(klass)
      klass.class_eval do
        alias_method :original_write, :write
      end
    end

    LOG_FORMAT_FILENAME = "%Y%m%d.txt"
    LOG_FORMAT_TIMESTAMP = "[%H:%M:%S]"

    def initialize
      super
      @is_silent = false
      @capturing = false
      init_logs
    end

    def init_logs
      inv = Inventory.load("local_setting")
      inv_logging = inv.group("logging")
      @logging_enabled = inv["logging"]
      @format_filename = inv_logging.format_filename || LOG_FORMAT_FILENAME
      @format_timestamp = inv_logging.format_timestamp || LOG_FORMAT_TIMESTAMP
      @format_timestamp_disabled = format_timestamp.blank? || format_timestamp.strip == "$none"
      create_log_dir
    end

    def copy_instance
      self.class.new.tap { |obj|
        obj.silent = silent
      }
    end

    def dup_with_disabled_logging
      obj = dup
      obj.disable_logging
      if obj.respond_to?(:original_stream)
        obj.original_stream = obj.original_stream.dup
        obj.original_stream&.disable_logging
      end
      obj
    end

    def silent=(enable)
      @is_silent = !!enable
    end

    def silent
      if block_given?
        if /^(.+?):(\d+)/ =~ caller(1..1).first
          file = $1
          line = $2.to_i
          error_msg = +"Did you mean: silence\n"
          str = File.read(file).split("\n")[line - 1]
          error_msg += "in #{file}:#{line}\n"
          error_msg += str + "\n"
          error_msg += " " * str.index("silent") + "~~~~~~"
          raise error_msg
        end
      end
      @is_silent
    end

    def silence(&block)
      raise "need a block" unless block
      tmp = self.silent
      self.silent = true
      yield
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
        $stdout.silence { yield }
      else
        yield
      end
      $stdout.capturing = false
      buffer = $stdout.string
      $stdout = temp_stream
      result = options[:ansicolor_strip] ? strip_color(buffer) : buffer
      if $stdout.capturing && !options[:quiet]
        # 多段キャプチャ中かつ quiet: false の場合は外側にも伝播する
        $stdout.string << result
      end
      result
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
      return if @is_silent
      if $disable_color
        target.write(str)
      else
        write_color(str, target)
      end
    end

    def write_base(str, stream, force_disable_logging = false)
      str = str.to_s
      if str.encoding == Encoding::ASCII_8BIT
        str.force_encoding(Encoding::UTF_8)
      end
      write_console(str, stream)
      append_log(str) unless force_disable_logging
    end

    def warn(str)
      self.puts str
    end

    def error(str)
      self.puts "<bold><red>[ERROR]</red></bold> ".termcolor + str
    end

    def logging?
      logging_enabled && ENV["NAROU_ENV"] != "test"
    end

    def create_log_dir
      return unless logging?
      dir = Narou.log_dir
      dir.mkdir unless dir.exist?
    end

    def disable_logging
      @logging_enabled = false
    end

    def append_log(str)
      return unless logging?
      File.write(log_filepath, strip_color(embed_timestamp(str)), mode: "a")
    end

    def log_filepath
      Narou.log_dir.join(log_filename)
    end

    def log_filename
      name = Time.now.strftime(format_filename)
      return name unless log_postfix
      ext = File.extname(name)
      basename = File.basename(name, ext)
      "#{basename}#{log_postfix}#{ext}"
    end

    def embed_timestamp(str)
      unless @before_head_ln
        str = "\n#{str}"
        @before_head_ln = true
      end
      if str.end_with?("\n")
        str = str.sub(/\n\z/, "")
        @before_head_ln = false
      end
      return str if format_timestamp_disabled
      str.gsub("\n", "\n#{Time.now.strftime(format_timestamp)} ")
    end
  end

  class Logger < StringIO
    include LoggerModule

    def initialize
      super
      self.stream = STDOUT
    end

    def write(str)
      write_base(str, stream)
      super(str)
    end

    def tty?
      STDOUT.tty?
    end
  end

  class LoggerError < StringIO
    include LoggerModule

    def initialize
      super
      self.stream = STDERR
    end

    def write(str)
      write_base(str, stream, false)
      super(str)
    end

    def tty?
      STDERR.tty?
    end
  end

  class NullIO < StringIO
    include LoggerModule

    def write(_str); end
  end
end

def warn(str, trace = nil)
  $stdout.warn str
  $stdout.warn trace if trace
end

def error(str)
  $stdout.error str
end

$stdout = Narou::Logger.new
if Inventory.load["concurrency"]
  $stdout2 = Narou::Logger.new
  $stdout2.log_postfix = "_convert"
else
  $stdout2 = $stdout
end
