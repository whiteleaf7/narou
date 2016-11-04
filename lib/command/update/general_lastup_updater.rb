# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../../narou/api"

module Command
  class Update < CommandBase
    class GeneralLastupUpdater
      def initialize(options)
        @options = options
        @database = Database.instance
        @narou_novels = Hash.new { |hash, key| hash[key] = [] }
        @other_novels = []
        prepare
      end

      def save
        @database.save_database
      end

      def prepare
        @database.each_key do |id|
          next if Narou.novel_frozen?(id)
          setting = Downloader.get_sitesetting_by_target(id)
          if setting["narou_api_url"]
            @narou_novels[setting["narou_api_url"]] << setting["ncode"]
          else
            @other_novels << id
          end
          setting.clear
        end
      end

      def update_narou_novels
        @narou_novels.each do |api_url, ncodes|
          api = Narou::API.new(api_url: api_url, ncodes: ncodes, of: "nu-gl")
          api.request.each do |result|
            ncode = result["ncode"]
            data = Downloader.get_data_by_target(ncode)
            last_check_date = data["last_check_date"] || data["last_update"]
            if result["novelupdated_at"] > last_check_date
              data["novelupdated_at"] = result["novelupdated_at"]
              data["general_lastup"] = result["general_lastup"]
              tags = data["tags"] ||= []
              tags << Narou::MODIFIED_TAG unless tags.include?(Narou::MODIFIED_TAG)
            end
            data["last_check_date"] = Time.now
          end
          @other_novels += api.private_novels
        end
      end

      def update_other_novels
        progressbar = ProgressBar.new(@other_novels.size - 1)
        interval = Interval.new(@options["interval"])

        @other_novels.each_with_index do |id, index|
          progressbar.output(index)
          interval.wait
          begin
            setting = Downloader.get_sitesetting_by_target(id)
            info = NovelInfo.load(setting)
            dates = if info
                      {
                        "novelupdated_at" => info["novelupdated_at"],
                        "general_lastup" => info["general_lastup"]
                      }
                    else
                      # 小説情報ページがない場合は目次から取得する
                      get_latest_dates(id)
                    end
          rescue OpenURI::HTTPError, Errno::ECONNRESET
            setting.clear
            next
          end
          data = @database[id]
          data.merge!(dates)
          last_check_date = data["last_check_date"] || data["last_update"]
          if data["novelupdated_at"] > last_check_date
            tags = @database[id]["tags"] ||= []
            tags << Narou::MODIFIED_TAG unless tags.include?(Narou::MODIFIED_TAG)
          end
          data["last_check_date"] = Time.now
          setting.clear
        end
      ensure
        progressbar.clear if progressbar
      end

      # オンラインの目次からgeneral_lastupを取得する
      # ただし、toc.yaml に最新話が存在し、かつsubdateが設定されていたらそれを使う
      def get_latest_dates(target)
        downloader = Downloader.new(target)
        old_toc = downloader.load_toc_file
        downloader.get_latest_table_of_contents(old_toc, through_error: true)
        {
          "novelupdated_at" => downloader.get_novelupdated_at,
          "general_lastup" => downloader.get_general_lastup
        }
      end
    end
  end
end
