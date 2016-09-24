# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "open-uri"
require "zlib"
require "yaml"
require "json"
require_relative "../novelinfo"

module Narou
  #
  # 小説家になろうデベロッパーAPI操作クラス
  #
  class API
    # 一度に問い合わせする件数
    BATCH_LIMIT = 300

    # なろうAPIの結果の圧縮レベル(1〜5)
    GZIP_LEVEL = 5

    #
    # なろうデベロッパーAPIから情報を取得
    #
    # api_url: なろうAPIのエンドポイントを指定。通常小説用と18禁小説用と分かれているため
    # ncode: 取得したい小説のNコードを指定。文字列か配列を指定可能
    # of: 出力パラメータ（http://dev.syosetu.com/man/api/#of_parm 参照）
    #
    def initialize(api_url:, ncode:, of:)
      @api_url = api_url
      @ncodes = Array(ncode).map(&:downcase)
      @of = "n-#{of}"
    end

    def [](key)
      @api_result[key]
    end

    def request
      @stores = []
      @private_ncodes = []
      @ncodes.each_slice(BATCH_LIMIT) do |ncodes|
        request_api(ncodes)
      end
      @stores
    end

    def request_api(ncodes, limit = BATCH_LIMIT)
      url = "#{@api_url}?gzip=#{GZIP_LEVEL}&ncode=#{ncodes.join("-")}&of=#{@of}&lim=#{limit}&out=json"
      open(url) do |fp|
        data = Zlib::GzipReader.wrap(fp).read.force_encoding(Encoding::UTF_8)
        results = JSON.load(data)
        return if results[0]["allcount"] == 0
        store_results(results.drop(1))
      end
    end

    def store_results(results)
      @stores += results.map do |result|
        result["ncode"].downcase!
        result["novel_type"] = result["noveltype"]
        result["writer"] = result["writer"].to_s
        %w(general_firstup general_lastup novelupdated_at).each do |key|
          result[key] &&= Time.parse(result[key])
        end
        stat_end = result["end"]
        if stat_end
          result["end"] = stat_end == 0
        end
        result
      end
    end

    def private_novels
      @private_ncodes = @ncodes - @stores.map { |s| s["ncode"] }
    end
  end
end
