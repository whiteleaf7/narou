# frozen_string_literal: true

#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "fileutils"
require "memoist"
require_relative "../database"
require_relative "../downloader"
require_relative "../template"
require_relative "../novelconverter"
require_relative "../eventable"
require_relative "update/interval"
require_relative "update/general_lastup_updater"
require_relative "update/hotentry_manager"

module Command
  class Update < CommandBase
    extend Memoist
    include Narou::Eventable

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

    # foo タグが付いた小説と bar タグが付いた小説を更新(タグのOR指定)
    narou u foo bar

    # foo タグ及び bar タグが両方付いた小説のみ更新(タグのAND指定)
    narou tag foo bar | narou u
    narou l -t "foo bar" | narou u   # こっちでも同じ(覚えやすい方を使う)

  Options:
      EOS
      @opt.on("-n", "--no-convert", "変換をせずアップデートのみ実行する") {
        @options["no-convert"] = true
      }
      @opt.on("-a", "--convert-only-new-arrival", "新着がある場合のみ変換を実行する") {
        @options["convert-only-new-arrival"] = true
      }
      @opt.on("--gl [OPT]", <<-EOS) { |option|
データベースに最新話掲載日を反映させる
                            |    OPT   |          概要
                            | 指定なし | 全ての小説を対象にする
                            |   narou  | なろうAPIを使える小説のみ対象
                            |   other  | なろうAPIが使えない小説のみ対象
        EOS
        if option && !["narou", "other"].include?(option)
          error "--gl で指定可能なオプションではありません。詳細は narou u -h を参照"
          exit Narou::EXIT_ERROR_CODE
        end
        update_general_lastup(option)
        exit 0
      }
      @opt.on("-f", "--force", "凍結済みも更新する") {
        @options["force"] = true
      }
      @opt.on("-s", "--sort-by KEY", "アップデートする順番を変更する\n#{Narou.update_sort_key_summaries}") { |key|
        @options["sort-by"] = key
      }
      @opt.on("-i", "--ignore-all", "<target>を省略した場合の全件更新処理を無効化する") {
        @options["ignore-all"] = true
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

    def sort_key
      key = @options["sort-by"]
      return nil unless key
      key.downcase!
      return key if valid_sort_key?(key)
      error "#{key} は正しいキーではありません。次の中から選択して下さい\n " \
            "#{Narou.update_sort_key_summaries(17)}"
      exit Narou::EXIT_ERROR_CODE
    end

    # rubocop:disable Metrics/BlockLength
    def execute(argv)
      super
      mistook_count = 0
      update_target_list = argv.dup
      @options["no-open"] = false
      if update_target_list.empty?
        exit 0 if @options["ignore-all"]
        update_target_list += Database.instance.get_object.keys
        @options["no-open"] = true
      end
      tagname_to_ids(update_target_list)

      flush_cache    # memoist のキャッシュ削除

      hotentry_manager = HotentryManager.new
      interval = Interval.new(@options["interval"])

      begin
        sort_by_key(sort_key, update_target_list).each_with_index do |target, i|
          display_message = nil
          data = Downloader.get_data_by_target(target)
          if !data
            display_message = "<bold><red>[ERROR]</red></bold> #{target} は管理小説の中に存在しません".termcolor
          elsif Narou.novel_frozen?(target) && !@options["force"]
            next if argv.empty?
            display_message = "ID:#{data["id"]}　#{data["title"]} は凍結中です"
          end
          Helper.print_horizontal_rule if i > 0
          if display_message
            puts display_message
            mistook_count += 1
            next
          end
          interval.wait
          downloader = Downloader.new(target)
          hotentry_manager.connect(downloader)

          delete_modified_tag = -> do
            tags = data["tags"] || []
            data["tags"] = tags - [Narou::MODIFIED_TAG] if tags.include?(Narou::MODIFIED_TAG)
            data["last_check_date"] = Time.now
          end

          result = downloader.start_download
          case result.status
          when :ok
            delete_modified_tag.call
            trigger(:success, data)
            puts "#{data["title"]} の更新が完了しました" if Narou.concurrency_enabled?
            if @options["no-convert"] ||
                 (@options["convert-only-new-arrival"] && !result.new_arrivals)
              interval.force_wait
              next
            end
          when :failed
            puts "ID:#{data["id"]}　#{data["title"]} の更新は失敗しました"
            mistook_count += 1
            next
          when :canceled
            puts "ID:#{data["id"]}　#{data["title"]} の更新はキャンセルされました"
            mistook_count += 1
            next
          when :none
            delete_modified_tag.call
            puts "#{data["title"]} に更新はありません"
            next unless data["_convert_failure"]
          end

          if data["_convert_failure"]
            puts "<yellow>前回変換できなかったので再変換します</yellow>".termcolor
          end
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
            data.delete("_convert_failure")
          end
        end
      ensure
        Database.instance.save_database
        process_hotentry(hotentry_manager.hotentries)
      end

      exit mistook_count if mistook_count > 0
    rescue Interrupt
      puts "アップデートを中断しました"
      Narou::Worker.cancel if Narou.concurrency_enabled?
      exit Narou::EXIT_INTERRUPT
    end

    def update_general_lastup(option = nil)
      puts "最新話掲載日を確認しています..."

      updater = GeneralLastupUpdater.new(@options)
      updater.update_narou_novels if !option || option == "narou"
      if !option || option == "other"
        sleep Narou::API::REQUEST_INTERVAL unless option
        updater.update_other_novels
      end
      updater.save

      puts "確認が完了しました"
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
          novel_converter = NovelConverter.new(
            setting, output_filename,
            display_inspector, Update.hotentry_dirname,
            stream_io: stream_io
          )
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
        NovelConverter.convert_txt_to_ebook_file(
          txt_output_path,
          use_dakuten_font: use_dakuten_font,
          device: device,
          stream_io: stream_io
        )
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
      cmd_convert.copy_to_converted_file(ebook_path, io: stream_io)
    end

    def send_hotentry(ebook_path, cmd_convert)
      cmd_convert.send_file_to_device(ebook_path, io: stream_io)
    end

    def mail_hotentry
      hotentry_manager = HotentryManager.new
      return unless hotentry_manager.auto_mail?
      Mail.execute!("hotentry")
    end

    def self.hotentry_dirname
      @@__hotentry_dirname ||= File.join(Narou.root_dir, HOTENTRY_DIR_NAME)
    end

    def self.get_newest_hotentry_file_path(device)
      pattern = File.join(Update.hotentry_dirname, "hotentry_*#{device.ebook_file_ext}")
      Dir.glob(pattern).sort.last
    end
  end
end
