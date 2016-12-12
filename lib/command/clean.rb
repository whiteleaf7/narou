# -*- coding: utf-8 -*-

require "fileutils"
require_relative "../downloader"
require_relative "../database"
require_relative "../inventory"

module Command
  class Clean < CommandBase
    def self.oneline_help
      "参照されなくなったファイルを削除します"
    end

    def initialize
      super("[<target> ...] [options]")
      @opt.separator <<-EOS

  ・サブタイトルの変更等により参照されなくなったファイルを削除します。
  ・対象小説を指定しなかった場合は直前に更新した小説について検査します。

  Examples:
    narou clean          # 直前に更新した小説について調査
    narou clean 6
    narou clean 6 -f     # 実際に削除
    narou clean --all    # 全小説について調査
  Options:
      EOS

      @opt.on("-f", "--force", "指定した小説の不要なファイルを実際に削除する") {
        @options["force"] = true
      }
      @opt.on("-n", "--dry-run", "指定した小説の不要なファイルを表示する") {
        @options["force"] = false
      }
      @opt.on("--all", "全小説を検査する") {
        @options["all"] = true
      }
    end

    def execute(argv)
      super
      if @options["all"]
        check_all(@options["force"])
        return
      end
      if argv.empty?
        latest_id = Inventory.load("latest_convert")["id"]
        if latest_id
          dir = Downloader.get_novel_data_dir_by_target(latest_id)
          check(dir, @options["force"])
        end
        return
      end
      tagname_to_ids(argv)
      argv.each do |target|
        dir = Downloader.get_novel_data_dir_by_target(target)
        if dir
          check(dir, @options["force"])
        else
          error "#{target} は存在しません"
        end
      end
    end

    def check_all(is_remove = false)
      Database.instance.each_key do |id|
        next if Narou.novel_frozen?(id)
        dir = Downloader.get_novel_data_dir_by_target(id)
        next unless File.exist?(dir)
        check(dir, is_remove)
      end
    end

    def check(dir, is_remove = false)
      return unless File.directory?(dir)
      return unless File.exist?(File.join(dir, Downloader::TOC_FILE_NAME))
      toc = Downloader.get_toc_data(dir)
      items = toc["subtitles"].map { |item| "#{item['index']} #{item['file_subtitle']}" }
      Dir.glob(File.join(dir, Downloader::RAW_DATA_DIR_NAME, "*.txt")).each do |path|
        unless items.include?(File.basename(path, ".*"))
          puts path
          FileUtils.remove_entry_secure(path) if is_remove
        end
      end
      Dir.glob(File.join(dir, Downloader::SECTION_SAVE_DIR_NAME, "*.yaml")).each do |path|
        unless items.include?(File.basename(path, ".*"))
          puts path
          FileUtils.remove_entry_secure(path) if is_remove
        end
      end
    end
  end
end
