# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

#
# 標準出力をフックする
#
# $stdout を介した出力は echo イベントとして全てのクライアントへ送信される
#
class Narou::StreamingLogger < StringIO
  include Narou::LoggerModule

  def initialize(push_server)
    super()
    @push_server = push_server
  end

  def tty?
    false
  end

  def push_streaming(str)
    unless @is_silent
      STDOUT.write(str)
      @push_server.send_all(echo: str)
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

class String
  if $disable_color
    def termcolor
      TermColorLight.strip_tag(self)
    end
  else
    def termcolor
      #TermColorLight.to_html(self)
      TermColorLight.strip_tag(self)
    end
  end
end

