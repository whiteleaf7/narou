# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

class String
  if $disable_color
    def termcolor
      TermColorLight.strip_tag(self, false)
    end
  else
    require "termcolorlight/html"

    def termcolor
      TermColorLight.to_html(self)
    end
  end
end

#
# 標準出力をフックする
#
# $stdout を介した出力は echo イベントとして全てのクライアントへ送信される
#
class Narou::StreamingLogger < StringIO
  include Narou::LoggerModule

  attr_reader :push_server, :target_console, :original_stream

  def initialize(push_server, original_stream = $stdout, target_console: "stdout")
    super()
    @push_server = push_server
    @target_console = target_console
    @original_stream = original_stream
  end

  def tty?
    false
  end

  def copy_instance
    self.class.new(@push_server).tap do |obj|
      obj.silent = silent
    end
  end

  def strip_color(str)
    if $disable_color
      str
    else
      str.gsub(%r!</?span.*?>!, "")
    end
  end

  def push_streaming(str, no_history: false)
    return if @is_silent
    @push_server.send_all(echo: build_echo(str, no_history)) if @push_server
  end

  def build_echo(str, no_history)
    {
      target_console: target_console,
      body: str,
      no_history: no_history
    }
  end

  def write(str)
    str = str.to_s
    if str.encoding == Encoding::ASCII_8BIT
      str.force_encoding(Encoding::UTF_8)
    end
    super(str)
    push_streaming(str)
    append_log(str)
  end
end
