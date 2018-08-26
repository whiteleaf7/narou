# frozen_string_literal: true

#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "csv"
require_relative "../database"

module Command
  # ライブラリのCSVコマンドと混同を避けるために小文字混じり
  class Csv < CommandBase
    def self.oneline_help
      "小説リストをCSV形式で出力したりインポートしたりします"
    end

    def initialize
      super("[optioins]")
      @opt.separator <<-EOS

  ・現在管理している小説の情報をCSV形式で出力したり、逆にインポートが出来ます
  ・インポートするCSVファイルには最低限 url というヘッダーが必要です

  Examples:
    narou csv                 # CSV形式でそのまま表示
    narou csv -o novels.csv   # novels.csv というファイル名で保存
    narou csv -i novels.csv   # ファイルから小説をインポート

  Options:
      EOS
      @opt.on("-o", "--output FILE", "指定したファイル名で保存") { |filename|
        @options["filename"] = filename
        @mode = :output
      }
      @opt.on("-i", "--import FILE", "指定したファイルからインポート") { |filename|
        @options["filename"] = filename
        @mode = :import
      }
    end

    def execute(argv)
      @mode = :output
      super

      self.__send__ @mode
    end

    #
    # CSV形式で出力する
    # stream には出力先のIOオブジェクトを指定。nilだったら$stdoutに出力
    #
    def output(stream = nil)
      stream ||= @options["filename"] ? File.open(@options["filename"], "w:UTF-8") : $stdout
      stream.puts(generate)
      stream.close if @options["filename"]
    end

    #
    # 小説の情報をCSV形式の文字列で取得
    #
    def generate
      database_values = Database.instance.get_object.values
      CSV.generate do |csv|
        csv << %w(id title author sitename url novel_type tags frozen last_update general_lastup)
        database_values.each do |data|
          tags = data["tags"] || []
          csv << [
            data["id"],
            data["title"],
            data["author"],
            data["sitename"],
            data["toc_url"],
            data["novel_type"] == 2 ? "短編" : "連載",
            tags.join(" "),
            Narou.novel_frozen?(data["id"]),
            data["last_update"].to_i,
            data["general_lastup"].to_i
          ]
        end
      end
    end

    #
    # CSV形式のファイルからインポートする
    # header行にurlという項目が必要
    # data にはインポートしたいIOオブジェクトかCSV形式の文字列を指定。
    # nil なら --import オプションで指定されたファイルから入力
    #
    def import(data = nil)
      if data
        source = data
      elsif @options["filename"]
        source = File.read(@options["filename"])
      else
        raise ArgumentError, "need a CSV data"
      end
      csv = CSV.new(source, headers: true, converters: :numeric, header_converters: :symbol)
      table = csv.read
      table[:url].each do |url|
        next unless url
        Download.execute!(url)
        Helper.print_horizontal_rule
      end
    rescue CSV::MalformedCSVError => e
      puts "不正なCSVデータです(#{e.message})"
      exit Narou::EXIT_ERROR_CODE
    end
  end
end
