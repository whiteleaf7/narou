# frozen_string_literal: true

#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../database"
require_relative "../downloader"

module Command
  class Backup < CommandBase
    BACKUP_DIR_NAME = "backup"

    def self.oneline_help
      "小説のバックアップを作成します"
    end

    def initialize
      super("<target> [<target2> ...]")
      @opt.separator <<-EOS

  ・指定した小説のバックアップを作成します。
  ・バックアップファイルはZIP圧縮され、小説保存フォルダ直下の#{BACKUP_DIR_NAME}フォルダに保存されます。
  ・バックアップ対象は、バックアップファイル以外の小説保存フォルダにあるファイル全てが対象です。

  Examples:
    narou backup 0
    narou backup n9669bk
    narou backup 0 1 musyoku
      EOS
    end

    def create_backup_filename(data)
      Helper.replace_filename_special_chars(data["title"]) + "_" + Time.now.strftime("%Y%m%d%H%M%S") + ".zip"
    end

    def create_backup(data)
      zipfilename = create_backup_filename(data)
      novel_dir = Downloader.get_novel_data_dir_by_target(data["id"])
      paths = novel_dir.glob("**/*").keep_if { |path|
        relative_path = path_to_relative(novel_dir, path)
        path.file? && relative_path.to_s.split("/", 2)[0] != BACKUP_DIR_NAME
      }
      backup_dir = novel_dir.join(BACKUP_DIR_NAME)
      backup_dir.mkdir unless backup_dir.exist?
      Zip.unicode_names = true unless Helper.os_windows?
      Zip::File.open(backup_dir.join(zipfilename), Zip::File::CREATE) do |zip|
        paths.each do |path|
          relative_path = path_to_relative(novel_dir, path).to_s
          zipped_filename =
            if Helper.os_windows?
              relative_path.encode(Encoding::Windows_31J, invalid: :replace, undef: :replace, replace: "_")
            else
              relative_path
            end
          zip.add(zipped_filename, path)
        end
      end
      zipfilename
    end

    def path_to_relative(base, path)
      path.sub("#{base}/", "")
    end

    def execute(argv)
      super
      display_help! if argv.empty?
      tagname_to_ids(argv)
      require "zip"
      argv.each_with_index do |target, i|
        Helper.print_horizontal_rule if i > 0
        data = Downloader.get_data_by_target(target)
        unless data
          puts "#{target} は存在しません"
          next
        end
        puts "ID:#{data["id"]}　#{data["title"]}"
        print "バックアップを作成しています"
        Thread.new {
          loop do
            print "."
            sleep(0.5)
          end
        }.tap { |th|
          zipfilename =  create_backup(data)
          th.kill
          puts
          puts "#{zipfilename} を作成しました"
        }
      end
    end
  end
end
