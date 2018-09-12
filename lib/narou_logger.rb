# frozen_string_literal: true

#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "stringio"
require "termcolorlight"
require "io/console/size"
require "unicode/display_width/string_ext"
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
      self.silent = false
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
      self.class.new.tap do |obj|
        obj.silent = silent?
      end
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
      @silent = enable.present?
    end

    def silent?
      @silent
    end

    def silence(&block)
      raise "need a block" unless block
      tmp = self.silent?
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
      return if silent?
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

  # 同時実行時のデフォルト側ロガー
  # 変換中のキューを表示出来るようにする（キュー表示部分はログに保存しない）
  class ConcurrencyDefaultLogger < Logger
    attr_accessor :end_with_new_line, :format_text, :format_style

    FORMAT_TEXT = "変換中:%<size>d"
    FORMAT_STYLE = "\e[%<left>dG<blue>%<text>s</blue>\e[1G"

    def initialize
      super
      self.end_with_new_line = true
      concurrency = Inventory.load.group("concurrency")
      self.format_text = concurrency.format_queue_text || FORMAT_TEXT
      self.format_style = concurrency.format_queue_style || FORMAT_STYLE
    end

    def write_console(str, target)
      str.each_line do |line|
        size = Worker.size
        if size > 0 && end_with_new_line
          text = format(format_text, size: size)
          text_width = text.display_width
          console_width = IO.console_size[1]
          left = console_width - text_width
          stream.print format(format_style, left: left, text: text, space: " ").termcolor
        end
        super(line, target)
      end
      self.end_with_new_line = str.end_with?("\n")
    end
  end

  # 同時実行時の変換側ロガー
  # デフォルトロガーが出力中の間は標準出力には表示しない
  class ConcurrencyConvertLogger < Logger
    attr_accessor :end_with_new_line

    def initialize
      super
      self.silent = true
      self.log_postfix = "_convert"
    end
  end
end

def warn(str, trace = nil)
  $stdout.warn str
  $stdout.warn trace if trace
end

def error(str)
  $stdout.error str
end

if Inventory.load["concurrency"]
  $stdout = Narou::ConcurrencyDefaultLogger.new
  $stdout2 = Narou::ConcurrencyConvertLogger.new
else
  $stdout = Narou::Logger.new
  $stdout2 = $stdout
end
