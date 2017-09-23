# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../narou"
require_relative "../mailer"

module Command
  class Mail < CommandBase
    def self.oneline_help
      "変換したEPUB/MOBIをメールで送信します"
    end

    def initialize
      super("[<target1> ...] [options]")
      @opt.separator <<-EOS

  ・主にSend to Kindleを使うためのコマンドです。
  ・<target>で指定した小説の電子書籍データメールで送信します。
  ・<target>を省略した場合、新着があった小説を全て送信します。
  ・メールの送信設定は、#{Mailer::SETTING_FILE}ファイルを編集します。
    (初めてコマンドを使うときに自動で作成されます)
  ・<target>にhotentryを指定した場合、最新のhotnetryを送信します

  Examples:
    narou mail 6         # 新着関係なくメール(送信済みフラグは立つ)

    narou update
    narou mail           # updateで新着があった小説を全てメール

    narou mail --force   # 凍結済以外の全ての小説を強制的にメール(使い方に注意)

  Options:
      EOS

      @opt.on("-f", "--force", "全ての小説を強制的に送信") {
        @options["force"] = true
      }
    end

    def execute(argv)
      super
      send_all = false
      device = Narou.get_device
      database = Database.instance
      begin
        mailer = Mailer.create
      rescue Mailer::SettingNotFound
        install_mailer_setting
        return
      rescue Mailer::SettingUncompleteError => e
        error e.message
        exit Narou::EXIT_ERROR_CODE
      end
      if argv.empty?
        send_all = true
        database.each_key do |id|
          next if Narou.novel_frozen?(id)
          argv << id
        end
      end
      tagname_to_ids(argv)
      argv.each do |target|
        if target == "hotentry"
          ebook_paths = [Update.get_newest_hotentry_file_path(device)]
          display_target = "hotentry"
        else
          ebook_paths = Narou.get_ebook_file_paths(target, device ? device.ebook_file_ext : ".epub")
          data = Downloader.get_data_by_target(target)
          if send_all && !@options["force"]
            new_arrivals_date = data["new_arrivals_date"] || Time.now
            if data["last_mail_date"] && new_arrivals_date < data["last_mail_date"]
              next   # すでに送信済みなので送信しない
            end
          end
        end
        unless ebook_paths[0]
          error "#{target} は存在しません" unless send_all
          next
        end
        unless File.exist?(ebook_paths[0])
          error "まだファイル(#{File.basename(ebook_paths[0])})が無いようです" unless send_all
          next
        end
        if target == "hotentry"
          id = "hotentry"
        else
          id = data["id"]
          title = data["title"]
          display_target = "ID:#{id}　#{TermColorLight.escape(title)}"
        end
        puts "<bold><green>#{display_target}</green></bold>".termcolor
        print "メールを送信しています"
        ebook_paths.each do |ebook_path|
          exit_mail = false
          mail_result = nil
          Thread.new do
            mail_result = mailer.send(id, File.basename(ebook_path), ebook_path)
            exit_mail = true
          end
          until exit_mail
            print "."
            sleep(0.5)
          end
          puts
          if mail_result
            puts File.basename(ebook_path) + " をメールで送信しました"
            database[id]["last_mail_date"] = Time.now if target != "hotentry"
          else
            error mailer.error_message
            exit Narou::EXIT_ERROR_CODE   # next しても次も失敗する可能性が高いのでここで終了
          end
        end
      end
    rescue Interrupt
      puts "メール送信を中断しました"
      exit Narou::EXIT_INTERRUPT
    ensure
      database.save_database if database
    end

    def install_mailer_setting
      setting_file_path = File.join(Narou.get_preset_dir, Mailer::SETTING_FILE)
      install_path = File.join(Narou.get_root_dir, Mailer::SETTING_FILE)
      FileUtils.cp(setting_file_path, install_path)
      alter_database_add_column_last_mail_date
      puts "created #{install_path}"
      puts "メールの設定用ファイルを作成しました。設定ファイルを書き換えることで mail コマンドが有効になります。"
      puts "注意：次回以降のupdateで新着があった場合に送信可能フラグが立ちます"
      unless Narou.web?
        Helper.open_directory(Narou.get_root_dir, "設定ファイルがあるフォルダを開きますか")
      end
    end

    def alter_database_add_column_last_mail_date
      database = Database.instance
      database.each do |_, data|
        data["last_mail_date"] ||= Time.now
      end
      database.save_database
    end
  end
end
