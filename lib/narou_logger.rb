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

module Narou end unless defined?(Narou)

module Narou::LoggerModule
  attr_accessor :capturing, :stream
  attr_reader :enable_logging, :format_file, :format_timestamp

  LOG_DIR = "log"
  LOG_FORMAT_FILE = "%Y%m%d.txt"
  LOG_FORMAT_TIMESTAMP = "[%H:%M:%S]"

  def initialize
    super
    @is_silent = false
    @capturing = false
    inv = Inventory.load("local_setting")
    inv_logging = inv.group("logging")
    @enable_logging = inv["logging"]
    @format_file = inv_logging.format_file || LOG_FORMAT_FILE
    @format_timestamp = inv_logging.format_timestamp || LOG_FORMAT_TIMESTAMP
    create_log_dir
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
    unless @is_silent
      if $disable_color
        target.write(str)
      else
        write_color(str, target)
      end
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

  def logging?
    enable_logging && ENV["NAROU_ENV"] != "test"
  end

  def warn(str)
    self.puts str
  end

  def error(str)
    self.puts "<bold><red>[ERROR]</red></bold> ".termcolor + str
  end

  def create_log_dir
    dir = Narou.log_dir
    dir.mkdir unless dir.exist?
  end

  def append_log(str)
    return unless logging?
    File.write(log_filepath, strip_color(embed_timestamp(str)), mode: "a")
  end

  def log_filepath
    Narou.log_dir.join(log_filename)
  end

  def log_filename
    # TODO: 並列変換時には変換ログに postfix をつける（混ざるので）
    "#{Time.now.strftime(format_file)}"
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
    str.gsub("\n", "\n#{Time.now.strftime(format_timestamp)} ")
  end
end

class Narou::Logger < StringIO
  include Narou::LoggerModule

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

class Narou::LoggerError < StringIO
  include Narou::LoggerModule

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

class Narou::NullIO < StringIO
  include Narou::LoggerModule

  def write(_str); end
end

def warn(str, trace = nil)
  $stdout.warn str
  $stdout.warn trace if trace
end

def error(str)
  $stdout.error str
end

$stdout = Narou::Logger.new
# $stderr = Narou::LoggerError.new
$stdout2 = $stdout
