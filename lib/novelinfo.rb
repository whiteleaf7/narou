# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "open-uri"
require "time"
require_relative "sitesetting"
require_relative "html"

class NovelInfo
  @@novel_info_parameters = {}

  def self.load(setting)
    info = new(setting)
    info.parse_novel_info
  end

  def initialize(setting)
    @setting = setting
    @ncode = @setting["ncode"]
    @@novel_info_parameters[@setting["name"]] ||= {}
  end

  def parse_novel_info
    info_url = @setting["novel_info_url"] or return nil
    result = @@novel_info_parameters[@setting["name"]][@ncode] ||= {}
    return result unless result.empty?
    of = "nt-s-gf-nu-gl-w"
    request_output_parameters = of.split("-")
    info_source = ""
    open(info_url) do |fp|
      info_source = Helper.pretreatment_source(fp.read, @setting["encoding"])
    end
    @setting.multi_match(info_source, *request_output_parameters)
    result["novel_type"] = @setting["novel_type_string"][@setting["novel_type"]] || 1
    result["story"] = @setting["story"]
    result["writer"] = @setting["writer"]
    %w(general_firstup novelupdated_at general_lastup).each do |elm|
      result[elm] = date_string_to_time(@setting[elm])
    end
    result
  end

  def date_string_to_time(date)
    date ? Time.parse(date.sub(/[\(（].+?[\)）]/, "").tr("年月日時分秒", "///:::")) : nil
  end
end
