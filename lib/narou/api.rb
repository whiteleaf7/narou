# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "open-uri"
require "yaml"
require_relative "../novelinfo"

module Narou
  #
  # 小説家になろうデベロッパーAPI操作クラス
  #
  class API
    #
    # なろうデベロッパーAPIから情報を取得
    #
    # setting: なろうの SiteSetting
    # of: 出力パラメータ（http://dev.syosetu.com/man/api/#of_parm 参照）
    #
    def initialize(setting, of)
      @setting = setting
      @api_url = @setting["narou_api_url"]
      @ncode = @setting["ncode"]
      request_api(of)
    end

    def [](key)
      @api_result[key]
    end

    def request_api(of, gzip = 5)
      # Ruby 2.0 以上だと gzip 自動デコード
      gzip_opt = RUBY_VERSION >= "2.0.0" ? "gzip=#{gzip}&" : ""
      url = "#{@api_url}?#{gzip_opt}ncode=#{@ncode}&of=#{of}"
      open(url) do |fp|
        result = YAML.load(fp.read.force_encoding(Encoding::UTF_8))
        if result[0]["allcount"] == 1
          @api_result = result[1]
          if of.length > 0
            @api_result["novel_type"] = @api_result["noveltype"]
            # なろうAPIが返すデータが数値の場合があるため強制変換
            @api_result["writer"] = @api_result["writer"].to_s
            stat_end = @api_result["end"]
            if stat_end
              @api_result["end"] = stat_end == 0
            end
          end
        else
          # なろうAPIからデータを取得出来なかった
          # 開示設定が検索から除外に設定されるとAPIからはアクセスできなくなる
          result = NovelInfo.load(@setting)
          unless result
            error "小説家になろうからデータを取得出来ませんでした"
            exit Narou::EXIT_ERROR_CODE
          end
          @api_result = result
        end
      end
    end
  end
end
