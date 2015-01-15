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

  def initialize(push_server = nil)
    super()
    @push_server = push_server
  end

  def tty?
    false
  end

  def copy_instance
    self.class.new(@push_server).tap do |obj|
      obj.silent = silent
    end
  end

  def push_streaming(str)
    unless @is_silent
      @push_server.send_all(echo: str) if @push_server
    end
  end

  def write(str)
    str = str.to_s
    if str.encoding == Encoding::ASCII_8BIT
      str.force_encoding(Encoding::UTF_8)
    end
    super(str)
    push_streaming(str)
  end
end

