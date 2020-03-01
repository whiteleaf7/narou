# frozen_string_literal: true

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
          api = Narou::API.new(api_url: api_url, ncodes: ncodes, of: "nu-gl-l")
          api.request.each do |result|
            ncode = result["ncode"]
            data = Downloader.get_data_by_target(ncode)
            last_check_date = data["last_check_date"] || data["last_update"]
            if result["novelupdated_at"] > last_check_date
              data["novelupdated_at"] = result["novelupdated_at"]
              data["general_lastup"] = result["general_lastup"]
              data["length"] = result["length"]
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
            downloader = Downloader.new(id)
            next unless downloader.get_latest_table_of_contents(through_error: true)
            dates = {
              "novelupdated_at" => downloader.get_novelupdated_at,
              "general_lastup" => downloader.get_general_lastup,
              "length" => downloader.novel_length
            }
          rescue OpenURI::HTTPError, Errno::ECONNRESET, Errno::ETIMEDOUT, Net::OpenTimeout
            next
          end
          data = @database[id]
          data.merge!(dates)
          last_check_date = data["last_check_date"] || data["last_update"]
          novelupdated_at = data["novelupdated_at"]
          if novelupdated_at && novelupdated_at > last_check_date
            tags = @database[id]["tags"] ||= []
            tags << Narou::MODIFIED_TAG unless tags.include?(Narou::MODIFIED_TAG)
          end
          data["last_check_date"] = Time.now
          downloader.setting.clear
        end
      ensure
        progressbar&.clear
      end
    end
  end
end
