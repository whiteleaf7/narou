# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "open-uri"
require "time"
require_relative "html"

class NovelInfo
  REFRESH_INTERVAL = 10 # キャッシュを捨てて再取得するまでの時間(s)
  DEFAULT_OF = "t-nt-ga-s-gf-nu-gl-w"
  @@novel_info_parameters = {}

  def self.load(setting, toc_source: nil, of: DEFAULT_OF)
    info = new(setting, toc_source, of)
    info.parse_novel_info
  end

  def initialize(setting, toc_source = nil, of = DEFAULT_OF)
    @setting = setting
    @ncode = @setting["ncode"]
    @toc_source = toc_source
    @of = of
    @@novel_info_parameters[@setting["name"]] ||= {}
  end

  def parse_novel_info
    info_url = @setting["novel_info_url"] or return nil
    result = @@novel_info_parameters[@setting["name"]][@ncode] ||= {}
    need_reload = false
    unless result.empty?
      # WEB UI でプロセスが常駐している間に小説情報（タイトルやあらすじ等）が
      # 変更される場合があるので、一定時間過ぎたら再取得をする必要がある
      if Time.now < result["last_load_time"] + REFRESH_INTERVAL
        return result   # まだ一定時間過ぎていないのでキャッシュを返す
      end
      need_reload = true
    end
    request_output_parameters = @of.split("-")
    info_source = ""

    if @setting["novel_info_url"] == @setting["toc_url"] && @toc_source && !need_reload
      # 目次ページのHTML（オプション）。目次と小説情報が同じページにある場合、
      # 同じページを二度取得するのは非効率なので、使い回す
      info_source = @toc_source
    else
      cookie = @setting["cookie"] || ""
      open_uri_options = make_open_uri_options("Cookie" => cookie, allow_redirections: :safe)
      open(info_url, open_uri_options) do |fp|
        info_source = Helper.restore_entity(Helper.pretreatment_source(fp.read, @setting["encoding"]))
        raise Downloader::DownloaderNotFoundError if Downloader.detect_error_message(@setting, info_source)
      end
    end

    @setting.multi_match(info_source, *request_output_parameters)
    result["last_load_time"] = Time.now
    result["title"] = @setting["title"]
    novel_status = @setting["novel_type_string"][@setting["novel_type"]] || 1
    result["end"] = novel_status == 3
    result["novel_type"] = case novel_status
                           when 1, 3   # 連載
                             1
                           when 2      # 短編
                             ga = @setting["general_all_no"]
                             # ハーメルンで短編なのに連載形式のがあるため
                             ga && ga > "1" ? 1 : 2
                           end
    story_html = HTML.new(@setting["story"])
    story_html.strip_decoration_tag = true
    result["story"] = story_html.to_aozora
    result["writer"] = @setting["writer"]
    %w(general_firstup novelupdated_at general_lastup).each do |elm|
      result[elm] = Helper.date_string_to_time(@setting[elm])
    end
    result["novelupdated_at"] ||= result["general_firstup"]
    result["general_lastup"] ||= result["novelupdated_at"]

    result
  end
end
