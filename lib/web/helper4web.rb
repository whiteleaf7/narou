# frozen_string_literal: true

#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../helper"

module Helper
  module_function

  HR_TAG = "<hr>"

  class << self
    alias :original_print_horizontal_rule :print_horizontal_rule
  end

  def print_horizontal_rule(io = $stdout)
    # タグがキャプチャーされると困るので、キャプチャ専用の出力とWEBへの出力は分ける
    if $stdout.capturing
      $stdout.silence do
        original_print_horizontal_rule($stdout)
      end
    else
      io.append_log("#{HR_TEXT}\n")
    end
    io.push_streaming(HR_TAG)
    io.original_write(HR_TAG)
  end
end
