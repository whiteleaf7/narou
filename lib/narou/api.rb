# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "open-uri"
require "yaml"

module Narou
  #
  # 小説家になろうデベロッパーAPI操作クラス
  #
  class API
    def initialize(setting, of = "")
      @setting = setting
      @api_url = @setting["narou_api_url"]
      @ncode = @setting["ncode"]
      request_api(of)
    end

    def [](key)
      @api_result[key]
    end

    def request_api(of)
      url = "#{@api_url}?ncode=#{@ncode}&of=#{of}"
      open(url) do |fp|
        result = YAML.load(fp.read)
        if result[0]["allcount"] == 1
          @api_result = result[1]
          if of.length > 0
            @api_result["novel_type"] = @api_result["noveltype"]
          end
        else
          warn "なろうAPIから情報が取得出来ませんでした"
          exit 1
        end
      end
    end
  end
end
