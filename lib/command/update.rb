# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "fileutils"
require "memoist"
require_relative "../database"
require_relative "../downloader"
require_relative "../template"
require_relative "../novelconverter"

module Command
  class Update < CommandBase
    extend Memoist

    LOG_DIR_NAME = "log"
    LOG_NUM_LIMIT = 30   # ログの保存する上限数
    LOG_FILENAME_FORMAT = "update_log_%s.txt"

    HOTENTRY_DIR_NAME = "hotentry"
    HOTENTRY_TEMPLATE_NAME = "hotentry.txt"
    HOTENTRY_TITLE_PATTERN = "hotentry %y/%m/%d %H:%M"
    HOTENTRY_FILE_PATTERN = "hotentry_%y-%m-%d_%H%M.txt"

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
      @opt.on("--gl", "データベースに最新話掲載日を反映させる") {
        update_general_lastup
        exit 0
      }
      @opt.on("-f", "--force", "凍結済みも更新する") {
        @options["force"] = true
      }
      @opt.on("-s", "--sort-by KEY", "アップデートする順番を変更する\n#{Narou.update_sort_key_summaries}") { |key|
        @options["sort-by"] = key
      }
    end

    def get_data_value(target, key)
      data = Downloader.get_data_by_target(target) or return nil
      value = data[key]
      value ? value : Time.new(0)
    end
    memoize :get_data_value

    #
    # 項目名でアップデート対象をソートする
    #
    # key に偽を渡した場合はソートしない
    #
    def sort_by_key(key, list)
      return list unless key
      list.sort { |a, b|
        value_a, value_b = [a, b].map { |target|
          get_data_value(target, key)
        }
        if value_a.nil? && !value_b.nil?
          next 1
        elsif !value_a.nil? && value_b.nil?
          next -1
        elsif value_a.nil? && value_b.nil?
          next 0
        end
        # 日付系は降順にする
        if value_a.class == Time
          value_b <=> value_a
        else
          value_a <=> value_b
        end
      }
    end

    def valid_sort_key?(key)
      Narou::UPDATE_SORT_KEYS.keys.include?(key)
    end

    def execute(argv)
      super
      mistook_count = 0
      update_target_list = argv.dup
      @options["no-open"] = false
      if update_target_list.empty?
        Database.instance.each_key do |id|
          update_target_list << id
        end
        @options["no-open"] = true
      end
      tagname_to_ids(update_target_list)

      sort_key = @options["sort-by"]
      if sort_key
        sort_key.downcase!
        unless valid_sort_key?(sort_key)
          error "#{sort_key} は正しいキーではありません。次の中から選択して下さい\n " \
                "#{Narou.update_sort_key_summaries(17)}"
          exit Narou::EXIT_ERROR_CODE
        end
      end
      flush_cache    # memoist のキャッシュ削除

      inv = Inventory.load("local_setting")
      @options["hotentry"] = inv["hotentry"]
      @options["hotentry.auto-mail"] = inv["hotentry.auto-mail"]
      hotentry = {}

      failure_list_last_time = get_failure_list_last_time

      update_log = $stdout.capture(quiet: false) do
        sort_by_key(sort_key, update_target_list).each_with_index do |target, i|
          display_message = nil
          data = Downloader.get_data_by_target(target)
          if !data
            display_message = "<bold><red>[ERROR]</red></bold> #{target} は管理小説の中に存在しません".termcolor
          elsif Narou.novel_frozen?(target) && !@options["force"]
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
          downloader = Downloader.new(target)

          if @options["hotentry"]
            downloader.on(:newarrival) do |hash|
              entry = hotentry[hash[:id]] ||= []
              entry << hash[:subtitle_info]
            end
          end

          result = downloader.start_download
          case result.status
          when :ok
            unless @options["no-convert"] ||
                   (@options["convert-only-new-arrival"] && !result.new_arrivals)
              convert_argv = [target]
              convert_argv << "--no-open" if @options["no-open"]
              convert_status = Convert.execute!(convert_argv)
              if convert_status > 0
                # 変換が失敗したか、中断された
                data["_convert_failure"] = true
                # 中断された場合には残りのアップデートも中止する
                raise Interrupt if convert_status == Narou::EXIT_INTERRUPT
              else
                # 変換に成功した
                data.delete["_convert_failure"]
                failure_list_last_time.delete(data["id"])
              end
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

        process_hotentry(hotentry)
        convert_failure_last_time(failure_list_last_time)
      end

      exit mistook_count if mistook_count > 0
    rescue Interrupt
      puts "アップデートを中断しました"
      exit Narou::EXIT_INTERRUPT
    ensure
      save_log(update_log)
      Database.instance.save_database
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

    def update_general_lastup(through_frozen_novel: true)
      completed = false
      database = Database.instance
      puts "最新話掲載日を更新しています..."
      progressbar = ProgressBar.new(database.get_object.size - 1)
      database.each.with_index do |(id, data), i|
        progressbar.output(i)
        if through_frozen_novel
          next if Narou.novel_frozen?(id)
        end
        setting =  Downloader.get_sitesetting_by_target(id)
        begin
          info = NovelInfo.load(setting)
        rescue OpenURI::HTTPError, Errno::ECONNRESET => e
          setting.clear
          next
        end
        if info
          dates = {
            "general_firstup" => info["general_firstup"],
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
        database[id].merge!(dates)
        setting.clear
      end
      database.save_database
      completed = true
    ensure
      progressbar.clear if progressbar
      puts "更新が完了しました" if completed
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

    #
    # 新着話をまとめたデータの作成に関する処理
    #
    def process_hotentry(hotentry)
      return if hotentry.empty?
      cmd_convert = Command::Convert.new
      cmd_convert.load_local_settings
      cmd_convert.device = Narou.get_device

      ebook_path = convert_hotentry(hotentry, cmd_convert)
      copy_hotentry(ebook_path, cmd_convert)
      send_hotentry(ebook_path, cmd_convert)
      mail_hotentry
    end

    def convert_hotentry(hotentry, cmd_convert)
      output_filename = nil
      display_inspector = false
      ignore_force = false
      ignore_default = false

      converted_text_array = []
      use_dakuten_font = false

      Helper.print_horizontal_rule
      puts "hotentry の変換を開始"

      subtitles_size = hotentry.inject(0) { |sum, (_, subtitles)| subtitles.size + sum }
      progressbar = ProgressBar.new(subtitles_size)
      total_progress = 0

      begin
        hotentry.each do |id, subtitles|
          setting = NovelSetting.load(id, ignore_force, ignore_default)
          setting.enable_illust = false   # 挿絵はパス解決が煩雑なので強制無効
          novel_converter = NovelConverter.new(setting, output_filename,
                                               display_inspector, Update.hotentry_dirname)
          last_num = 0
          novel_converter.on(:"convert_main.loop") do |i|
            progressbar.output(total_progress + i)
            last_num = i
          end
          converted_text_array << {
            setting: setting,
            text: novel_converter.convert_main_for_novel(subtitles, true)
          }
          use_dakuten_font |= novel_converter.use_dakuten_font

          total_progress += last_num + 1
        end
      ensure
        progressbar.clear
      end
      puts "縦書用の変換が終了しました"

      device = Narou.get_device
      now = Time.now
      # テキストの生成
      hotentry_title = now.strftime(HOTENTRY_TITLE_PATTERN)
      hotentry_text = Template.get(HOTENTRY_TEMPLATE_NAME, binding, 1.0)
      # 生成したテキストファイルの保存
      txt_output_path = File.join(Update.hotentry_dirname, now.strftime(HOTENTRY_FILE_PATTERN))
      create_inclusive_directory(txt_output_path)
      File.write(txt_output_path, hotentry_text)
      # テキストを書籍データに変換
      relay_proc = -> {
        NovelConverter.convert_txt_to_ebook_file(txt_output_path, {
          use_dakuten_font: use_dakuten_font,
          device: device
        })
      }
      if device
        cmd_convert.extend(device.get_hook_module)
        cmd_convert.converted_txt_path = txt_output_path
        cmd_convert.hook_call(:change_settings)
      end
      if cmd_convert.respond_to?(:hook_convert_txt_to_ebook_file)
        ebook_path = cmd_convert.hook_convert_txt_to_ebook_file(&relay_proc)
      else
        ebook_path = relay_proc.call
      end
      ebook_path
    end

    def create_inclusive_directory(path)
      FileUtils.mkdir_p(File.dirname(path))
    end

    def copy_hotentry(ebook_path, cmd_convert)
      cmd_convert.copy_to_converted_file(ebook_path)
    end

    def send_hotentry(ebook_path, cmd_convert)
      cmd_convert.send_file_to_device(ebook_path)
    end

    def mail_hotentry
      return unless @options["hotentry.auto-mail"]
      Mail.execute!(["hotentry"])
    end

    def self.hotentry_dirname
      @@__hotentry_dirname ||= File.join(Narou.get_root_dir, HOTENTRY_DIR_NAME)
    end

    def self.get_newest_hotentry_file_path(device)
      pattern = File.join(Update.hotentry_dirname, "hotentry_*#{device.ebook_file_ext}")
      Dir.glob(pattern).sort.last
    end

    def get_failure_list_last_time
      list = []
      Database.instance.each do |id, data|
        list << id if data["_convert_failure"]
      end
      list
    end

    #
    # 前回のアップデート時に変換に失敗した小説を再度変換する
    #
    def convert_failure_last_time(id_list)
      return if @options["no-convert"] || id_list.empty?
      db = Database.instance
      Helper.print_horizontal_rule
      puts "<yellow>前回のアップデート時に変換出来なかった小説を変換します</yellow>".termcolor
      id_list.each do |id|
        convert_argv = [id]
        convert_argv << "--no-open" if @options["no-open"]
        convert_status = Convert.execute!(convert_argv)
        if convert_status > 0
          # 変換に失敗したか、中断した場合はその後の変換は全てスキップ
          break
        else
          # 変換に成功したら失敗フラグは削除
          db.get_data("id", id).delete("_convert_failure")
        end
        Helper.print_horizontal_rule
      end
    end
  end
end
