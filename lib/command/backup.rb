# -*- coding: utf-8 -*-
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
      pwd = Dir.pwd
      novel_dir = Downloader.get_novel_data_dir_by_target(data["id"])
      Dir.chdir(novel_dir)
      paths = Dir.glob("**/*").keep_if { |path|
        File.file?(path) && path.split("/", 2)[0] != BACKUP_DIR_NAME
      }
      FileUtils.mkdir(BACKUP_DIR_NAME) unless File.exist?(BACKUP_DIR_NAME)
      Zip.unicode_names = true unless Helper.os_windows?
      Zip::File.open(File.join(BACKUP_DIR_NAME, zipfilename), Zip::File::CREATE) do |zip|
        paths.each do |path|
          if Helper.os_windows?
            zipped_filename = path.encode(Encoding::Windows_31J,
                                          invalid: :replace, undef: :replace, replace: "_")
          else
            zipped_filename = path
          end
          zip.add(zipped_filename, path)
        end
      end
      Dir.chdir(pwd)
      zipfilename
    end

    def execute(argv)
      super
      if argv.empty?
        puts @opt.help
        return
      end
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
