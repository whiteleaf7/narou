# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../helper"

module Helper
  module_function

  class << self
    alias :original_print_horizontal_rule :print_horizontal_rule
  end

  def print_horizontal_rule
    # タグがキャプチャーされると困るので、キャプチャ専用の出力とWEBへの出力は分ける
    if $stdout.capturing
      $stdout.silence do
        original_print_horizontal_rule
      end
    end
    $stdout.push_server.send_all(echo: "<hr>")
  end
end

