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
      super("[<target1> <target2> ...]")
      @opt.separator <<-EOS

  ・主にSend to Kindleを使うためのコマンドです。
  ・<target>で指定した小説の電子書籍データメールで送信します。
  ・<target>を省略した場合、新着があった小説を全て送信します。
  ・メールの送信設定は、#{Mailer::SETTING_FILE}ファイルを編集します。
    (初めてコマンドを使うときに自動で作成されます)

  Example:
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
      rescue Mailer::SettingNotFound => e
        install_mailer_setting
        return
      rescue Mailer::SettingUncompleteError => e
        error e.message
        exit 1
      end
      if argv.empty?
        send_all = true
        database.each_key do |id|
          next if Narou.novel_frozen?(id)
          argv << id
        end
      end
      argv.each do |target|
        ebook_path = Narou.get_ebook_file_path(target, device ? device.ebook_file_ext : ".epub")
        unless ebook_path
          error "#{target} は存在しません" unless send_all
          next
        end
        data = Downloader.get_data_by_target(target)
        if send_all && !@options["force"]
          new_arrivals_date = data["new_arrivals_date"] || Time.now
          if data["last_mail_date"] && new_arrivals_date < data["last_mail_date"]
            next   # すでに送信済みなので送信しない
          end
        end
        unless File.exists?(ebook_path)
          error "まだファイル(#{File.basename(ebook_path)})が無いようです" unless send_all
          next
        end
        id = data["id"]
        title = data["title"]
        puts "<green>ID:#{id}　#{TermColor.escape(title)}</green>".termcolor
        print "メールを送信しています"
        exit_mail = false
        mail_result = nil
        Thread.new do
          mail_result = mailer.send(File.basename(ebook_path), ebook_path)
          exit_mail = true
        end
        until exit_mail
          print "."
          sleep(0.5)
        end
        puts
        if mail_result
          puts File.basename(ebook_path) + " をメールで送信しました"
          database[id]["last_mail_date"] = Time.now
        else
          error "#{mailer.error_message}"
          exit 1   # next しても次も失敗する可能性が高いのでここで終了
        end
      end
    rescue Interrupt
      puts "メール送信を中断しました"
      exit 1
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
      if Helper.confirm("設定ファイルがあるフォルダを開きますか")
        Helper.open_directory(Narou.get_root_dir)
      end
    end

    def alter_database_add_column_last_mail_date
      database = Database.instance
      database.each do |id, data|
        data["last_mail_date"] ||= Time.now
      end
      database.save_database
    end
  end
end
