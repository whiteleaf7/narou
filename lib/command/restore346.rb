# frozen_string_literal: true

#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../database"
require_relative "../downloader"

module Command
  class Restore346 < CommandBase
    def self.oneline_help
      "ver 3.4.6 で壊れた toc.yaml の復元"
    end

    def initialize
      super("<target> [<target2> ...]")
      @opt.separator <<-HELP

  ・ver 3.4.6 で更新して壊れた toc.yaml の更新日時部分を復元します
  ・このコマンドを実行しなくても更新は出来ますが、改稿がある話のDLが走ってしまいます

  Examples:
    narou restore346

      HELP

      @opt.on("-f") do
        @options["f"] = true
      end
    end

    def execute(argv)
      super
      database_values = Database.instance.get_object.values
      database_values.each do |data|
        puts "<gray>#{data["title"].escape}</gray>".termcolor
        downloader = Downloader.new(data["id"])
        toc = downloader.load_toc_file
        modified = @options["f"] ? restore_subupdate(toc) : restore(toc)
        downloader.save_toc_once(toc) if modified
      rescue StandardError
        next
      end
    end

    def restore(toc)
      subtitles = toc["subtitles"]
      modified = false
      subtitles.each do |subtitle|
        next unless subtitle["subdate"] =~ /\A(?<subdate>.+?)<span title="(?<subupdate>.+?) 改稿">/

        subdate = Regexp.last_match[:subdate]
        subupdate = Regexp.last_match[:subupdate]

        download_time = subtitle["download_time"]
        if Time.parse(subupdate) > download_time
          subupdate = ""
        end

        subtitle["subdate"] = subdate
        subtitle["subupdate"] = subupdate
        modified = true
      end

      if modified
        puts "<green>#{toc["title"].escape} の目次データを復元しました</green>".termcolor
      end

      modified
    end

    def restore_subupdate(toc)
      subtitles = toc["subtitles"]
      modified = false
      subtitles.each do |subtitle|
        subupdate = subtitle["subupdate"]

        next if subupdate.blank?

        download_time = subtitle["download_time"]
        next if Time.parse(subupdate) <= download_time

        subtitle["subupdate"] = ""
        modified = true
      end

      if modified
        puts "<green>#{toc["title"].escape} の目次データを復元しました</green>".termcolor
      end

      modified
    end
  end
end
