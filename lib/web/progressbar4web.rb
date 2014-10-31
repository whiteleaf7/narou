# -*- coding: utf-8 -*-
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

  def initialize(*args)
    original_initialize(*args)
    @@push_server.send_all("progressbar.init" => true)
  end

  def output(num)
    percent = calc_ratio(num) * 100
    @@push_server.send_all("progressbar.step" => percent)
  end

  def clear
    @@push_server.send_all("progressbar.clear" => true)
  end
end

