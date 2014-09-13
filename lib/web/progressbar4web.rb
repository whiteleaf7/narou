# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../progressbar"

#
# コンソール用のプログレスバーはWEB UIでは使えないため置き換える
#
class ProgressBar
  def output(num)
    print "."
  end

  def clear
  end
end

