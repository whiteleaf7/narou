# -*- Encoding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../lib/novelinfo"

describe NovelInfo do
  before do
    setting = {
      "name" => "dummy", "ncode" => "10000"
    }
    @novelinfo = NovelInfo.new(setting)
  end
end
