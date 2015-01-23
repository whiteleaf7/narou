# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../database"
require_relative "../downloader"

module Command
  class Update < CommandBase
    LOG_DIR_NAME = "log"
    LOG_NUM_LIMIT = 30   # ログの保存する上限数
    LOG_FILENAME_FORMAT = "update_log_%s.txt"

    def self.oneline_help
      "小説を更新します"
    end

    def initialize
      super("[<target> ...] [options]")
      @opt.separator <<-EOS

  ・管理対象の小説を更新します。
    更新したい小説のNコード、URL、タイトル、IDもしくは別名を指定して下さい。
    IDは #{@opt.program_name} list を参照して下さい。
  ・対象を指定しなかった場合、すべての小説の更新をチェックします。
  ・一度に複数の小説を指定する場合は空白で区切って下さい。
  ・全て更新する場合、convert.no-openが設定されていなくても保存フォルダは開きません。

  Examples:
    narou update               # 全て更新
    narou u                    # 短縮コマンド
    narou update 0 1 2 4
    narou update n9669bk 異世界迷宮で奴隷ハーレムを
    narou update http://ncode.syosetu.com/n9669bk/

  Options:
      EOS
      @opt.on("-n", "--no-convert", "変換をせずアップデートのみ実行する") {
        @options["no-convert"] = true
      }
      @opt.on("-a", "--convert-only-new-arrival", "新着のみ変換を実行する") {
        @options["convert-only-new-arrival"] = true
      }
      @opt.on("-l", "--log [N]", "最新からN番目のログを表示する(デフォ1)") { |n|
        n = n.to_i
        n -= 1 if n > 0
        @options["log"] = n
        view_log
        exit 0
      }
    end

    def execute(argv)
      super
      mistook_count = 0
      update_target_list = argv.dup
      no_open = false
      if update_target_list.empty?
        Database.instance.each_key do |id|
          update_target_list << id
        end
        no_open = true
      end
      tagname_to_ids(update_target_list)
      update_log = $stdout.capture(quiet: false) do
        update_target_list.each_with_index do |target, i|
          display_message = nil
          data = Downloader.get_data_by_target(target)
          if !data
            display_message = "<bold><red>[ERROR]</red></bold> #{target} は管理小説の中に存在しません".termcolor
          elsif Narou.novel_frozen?(target)
            if argv.length > 0
              display_message = "ID:#{data["id"]}　#{data["title"]} は凍結中です"
            else
              next
            end
          end
          Helper.print_horizontal_rule if i > 0
          if display_message
            puts display_message
            mistook_count += 1
            next
          end
          result = Downloader.start(target)
          case result.status
          when :ok
            unless @options["no-convert"] ||
                   (@options["convert-only-new-arrival"] && !result.new_arrivals)
              convert_argv = [target]
              convert_argv << "--no-open" if no_open
              Convert.execute!(convert_argv)
            end
          when :failed
            puts "ID:#{data["id"]}　#{data["title"]} の更新は失敗しました"
            mistook_count += 1
          when :canceled
            puts "ID:#{data["id"]}　#{data["title"]} の更新はキャンセルされました"
            mistook_count += 1
          when :none
            puts "#{data["title"]} に更新はありません"
          end
        end
      end
      save_log(update_log)
      exit mistook_count if mistook_count > 0
    rescue Interrupt
      puts "アップデートを中断しました"
      exit Narou::EXIT_ERROR_CODE
    end

    def get_log_paths
      Dir.glob(File.join(log_dirname, LOG_FILENAME_FORMAT % "*")).sort.reverse
    end

    def view_log
      list = get_log_paths
      n = @options["log"]
      if list[n]
        puts File.read(list[n], encoding: Encoding::UTF_8)
      else
        error "#{n+1}番目のログはありません"
      end
    end

    def save_log(log)
      return unless @options["logging"]
      create_log_dir
      now = Time.now
      logname = File.join(log_dirname, LOG_FILENAME_FORMAT % now.strftime("%Y%m%d_%H%M%S"))
      File.open(logname, "w:UTF-8") do |fp|
        fp.puts "--- ログ出力日時 #{now.strftime("%Y/%m/%d %H:%M:%S")} ---"
        fp.puts log
      end
      remove_old_log
    end

    def log_dirname
      @@__log_dirname ||= File.join(Narou.get_root_dir, LOG_DIR_NAME)
    end

    def create_log_dir
      logdir = log_dirname
      return if File.directory?(logdir)
      FileUtils.mkdir_p(logdir)
    end

    def remove_old_log
      list = get_log_paths
      (list[LOG_NUM_LIMIT..-1] || []).each do |path|
        File.delete(path)
      end
    end
  end
end
