# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "open-uri"
require "yaml"
require "time"
require_relative "../sitesetting"

module Narou
  #
  # 小説家になろうデベロッパーAPI操作クラス
  #
  class API
    INFO_SETTING_FILE = "narou_novel_info.yaml"
    NOVEL_TYPE = { "連載中" => 1, "完結済" =>  1, "短編" =>  2 }

    @@novel_info_parameters = {}

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
        result = YAML.load(fp.read)
        if result[0]["allcount"] == 1
          @api_result = result[1]
          if of.length > 0
            @api_result["novel_type"] = @api_result["noveltype"]
          end
        else
          # なろうAPIからデータを取得出来なかった
          # 開示設定が検索から除外に設定されるとAPIからはアクセスできなくなる
          result = parse_novel_info
          unless result
            error "小説家になろうからデータを取得出来ませんでした"
            exit
          end
          @api_result = result
        end
      end
    end

    #
    # 小説情報ページをパースして必要な情報を取り出す
    #
    def parse_novel_info
      return @@novel_info_parameters[@ncode] if @@novel_info_parameters[@ncode]
      result = {}
      of = "nt-s-gf-nu-gl"
      request_output_parameters = of.split("-")
      info_source = ""
      open(@setting["narou_info_url"]) do |fp|
        info_source = Helper.pretreatment_source(fp.read)
      end
      info_setting = SiteSetting.load_file(File.join(Narou.get_preset_dir, INFO_SETTING_FILE))
      info_setting.multi_match(info_source, *request_output_parameters)
      result["novel_type"] = NOVEL_TYPE[info_setting["novel_type"]].to_s
      result["story"] = info_setting["story"].gsub("<br />", "")
      %w(general_firstup novelupdated_at general_lastup).each do |elm|
        result[elm] = date_string_to_time(info_setting[elm])
      end
      @@novel_info_parameters[@ncode] = result
      result
    end

    def date_string_to_time(date)
      date ? Time.parse(date.tr("年月日時分秒", "///:::")) : nil
    end
  end
end
