# frozen_string_literal: true

#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../progressbar"

#
# コンソール用のプログレスバーはWEB UIでは使えないため置き換える
#
class ProgressBar
  def self.push_server=(server)
    @@push_server = server
  end

  alias :original_initialize :initialize

  def initialize(*args, **opt)
    original_initialize(*args, **opt)
    @@push_server.send_all("progressbar.init" => { target_console: io.target_console })
  end

  def output(num)
    percent = calc_ratio(num) * 100
    @@push_server.send_all("progressbar.step" => {
      percent: percent,
      target_console: io.target_console
    })
  end

  def clear
    @@push_server.send_all("progressbar.clear" => { target_console: io.target_console })
  end
end

