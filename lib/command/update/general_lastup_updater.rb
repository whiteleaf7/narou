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
        @narou_novels = Hash.new { |h, k| h[k] = [] }
        @other_novels = []
        prepare
      end

      def save
        @database.save_database
      end

      def prepare
        @database.each.with_index do |(id, data), i|
          next if Narou.novel_frozen?(id)
          setting =  Downloader.get_sitesetting_by_target(id)
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
            if result["novelupdated_at"] > data["last_update"]
              data["novelupdated_at"] = result["novelupdated_at"]
              data["general_lastup"] = result["general_lastup"]
              tags = data["tags"] ||= []
              tags << "modified" unless tags.include?("modified")
            end
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
            setting =  Downloader.get_sitesetting_by_target(id)
            info = NovelInfo.load(setting)
          rescue OpenURI::HTTPError, Errno::ECONNRESET => e
            setting.clear
            next
          end
          if info
            dates = {
              "novelupdated_at" => info["novelupdated_at"],
              "general_lastup" => info["general_lastup"]
            }
          else
            # 小説情報ページがない場合は目次から取得する
            begin
              dates = get_latest_dates(id)
            rescue OpenURI::HTTPError, Errno::ECONNRESET => e
              setting.clear
              next
            end
          end
          data = @database[id]
          data.merge!(dates)
          if data["novelupdated_at"] > data["last_update"]
            tags = @database[id]["tags"] ||= []
            tags << "modified" unless tags.include?("modified")
          end
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
        latest_toc = downloader.get_latest_table_of_contents(old_toc, through_error: true)
        {
          "novelupdated_at" => downloader.get_novelupdated_at,
          "general_lastup" => downloader.get_general_lastup
        }
      end
    end
  end
end
