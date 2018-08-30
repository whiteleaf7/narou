# frozen_string_literal: true

#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "log/tail"

module Command
  class Log < CommandBase
    NUM = 20

    def self.oneline_help
      "保存したログを表示します"
    end

    def initialize
      super("[options] [<path>]")
      @opt.separator <<~HELP

        ・#{Narou.log_dir} に保存されたログを表示します。
        ・logging 設定が有効な場合のみ、ログは保存されます。
        ・<path> を指定しない場合、最新のログが表示されます。
        ・デフォルトでは末尾#{NUM}行のログを表示します。

          Examples:
            narou s logging=true # ログの保存を有効にする

            narou log
            narou log -n 100     # 100行分のログを表示
            narou log -t         # tail -f オプションのようにログを流し続ける

            narou log log/narou.txt # 直接ファイルを指定可能

            # concurrency 設定（更新・変換同時実行）が有効時は変換ログが別ファイルに
            # 分かれるので、変換ログを表示したい場合は -c オプションを付ける
            # （指定しなかった場合は更新ログの方を表示）
            narou log -c         # 変換ログを表示

          Options:
      HELP
      @opt.on("-n", "--num NUM", Integer, "表示する行数を指定する") do |num|
        @options["num"] = num
      end
      @opt.on("-t", "--tail", "ログを流し続ける") do
        @options["tail"] = true
      end
      @opt.on("-c", "--source-convert", "変換ログを表示する。<path> を直接指定した場合は無視") do
        @options["source-convert"] = true
      end
    end

    def execute(argv)
      disable_logging
      super
      path = resolve_path(argv.first) || latest_log_path
      unless path
        error "表示できるログファイルが一つも見つかりませんでした"
        exit Narou::EXIT_ERROR_CODE
      end
      stream_io.puts "<cyan>#{path}</cyan>".termcolor
      tail = Tail.new(path, @options["num"] || NUM)
      tail.stream_io = stream_io
      if @options["tail"]
        tail.stream
      else
        tail.display
      end
    rescue Interrupt
      stream_io.puts
    end

    def latest_log_path
      Narou.log_dir.glob("*").sort_by(&:mtime).reverse.find do |path|
        path_matches_source?(path)
      end
    end

    def path_matches_source?(path)
      ext = path.extname
      base = path.basename(ext)
      ended_with_convert = base.to_s.end_with?("_convert")
      if @options["source-convert"]
        ended_with_convert
      else
        !ended_with_convert
      end
    end

    def resolve_path(path)
      return nil if path.blank?
      fullpath = Pathname(path).expand_path
      unless fullpath.exist?
        error "#{path} が存在しません"
        exit Narou::EXIT_ERROR_CODE
      end
      fullpath
    end
  end
end
