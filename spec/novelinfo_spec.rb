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

  it "#date_string_to_time" do
    @novelinfo.date_string_to_time("2014年03月02日(日) 07:39").should == Time.parse("2014/3/2 07:39")
    @novelinfo.date_string_to_time("2012年 11月22日 17時00分").should == Time.parse("2012/11/22 17:00")
  end
end
