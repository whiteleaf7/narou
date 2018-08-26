# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../narou"
require_relative "../helper"
require_relative "../device"

module Command
  class Send < CommandBase
    def self.oneline_help
      "変換したEPUB/MOBIを電子書籍端末に送信します"
    end

    def initialize
      super("[<device>] [<target> ...] [options]")
      @opt.separator <<-EOS

  ・<target>で指定した小説の電子書籍データを<device>で指定した端末に送信します
  ・<device>には現在 #{Device::DEVICES.keys.join(", ")} が指定出来ます
  ・narou setting device=<device>としておけば、<device>の入力を省略できます
    また、convertコマンドで変換時に(端末がPCに接続されていれば)自動でデータを送信するようになります
  ・送信時はファイルのタイムスタンプを端末のものと比べて新しければ送信します
  ・<target>を省略した場合、管理している小説全てが送信対象になります
  ・<target>にhotentryを指定した場合、最新のhotnetryを送信します

  Examples:
    narou send kindle 6
    narou send kobo 6

    # <device>の省略
    narou setting device=kindle
    narou send 6

    narou send      # 端末のファイルより新しいファイルがあれば送信
    narou send --without-freeze   # 凍結済は対象外に
    narou s send.without-freeze=true   # 常に凍結済みを対象外に設定

  Options:
      EOS

      @opt.on("-w", "--without-freeze", "送信時に凍結された小説は対象外にする") {
        @options["without-freeze"] = true
      }
      @opt.on("-f", "--force", "タイムスタンプを比較せずに必ず送信する") {
        @options["force"] = true
      }
      @opt.on("-b", "--backup-bookmark", "端末の栞データを手動でバックアップする(KindlePW系用)") {
        @options["command-backup-bookmark"] = true
      }
      @opt.on("-r", "--restore-bookmark", "栞データのバックアップを端末にコピーする(KindlePW系用)") {
        @options["command-restore-bookmark"] = true
      }
    end

    def get_device(argv)
      if argv.first && Device.exists?(argv.first)
        return Narou.get_device(argv.shift)
      end
      Narou.get_device
    end

    def execute(argv)
      super
      device = get_device(argv)
      unless device
        stream_io.error <<~ERR
          デバイス名が指定されていないか、間違っています。
          narou setting device=デバイス名 で指定出来ます。
          指定出来るデバイス名：#{Device::DEVICES.keys.join(", ")}
        ERR
        exit Narou::EXIT_ERROR_CODE
      end
      unless device.physical_support?
        stream_io.error "#{device.display_name} への直接送信は対応していません"
        exit Narou::EXIT_ERROR_CODE
      end
      unless device.connecting?
        stream_io.error "#{device.display_name} が接続されていません"
        exit Narou::EXIT_ERROR_CODE
      end

      @options["hotentry"] = Inventory.load("local_setting")["hotentry"]
      send_all = false
      titles = {}
      if argv.empty?
        send_all = true
        Database.instance.each do |id, data|
          argv << id
          titles[id] = data["title"]
        end
        if @options["hotentry"]
          argv << "hotentry"
          titles["hotentry"] = "hotentry"
        end
      end

      case
      when @options["command-backup-bookmark"]
        process_backup_bookmark(device)
        exit
      when @options["command-restore-bookmark"]
        process_restore_bookmark(device)
        exit
      end

      tagname_to_ids(argv)
      argv.each do |target|
        # WEB UI 使用時は、send.without-freeze を設定して使うことを想定していて、
        # コマンドのようにオプションを付けたり外したりするのが容易ではないため、
        # 個別送信時はオプションに関わらず凍結済みでも送信出来るようにする
        if @options["without-freeze"] && Narou.novel_frozen?(target) &&
           (!Narou.web? || (Narou.web? && send_all))
          next
        end
        if target == "hotentry"
          ebook_paths = [Update.get_newest_hotentry_file_path(device)]
        else
          ebook_paths = Narou.get_ebook_file_paths(target, device.ebook_file_ext)
        end
        unless ebook_paths[0]
          stream_io.error "#{target} は存在しません"
          next
        end
        unless File.exist?(ebook_paths[0])
          stream_io.error "まだファイル(#{File.basename(ebook_paths[0])})が無いようです" unless send_all
          next
        end

        # TODO: should check all items in ebook_paths
        if !@options["force"] && !device.ebook_file_old?(ebook_paths[0])
          next
        end
        display_target =
          if target == "hotentry"
            target
          else
            "ID:#{target}　#{TermColorLight.escape(titles[target])}"
          end
        stream_io.puts "<bold><green>#{display_target}</green></bold>".termcolor

        stream_io.print "#{device.name}へ送信しています"
        ebook_paths.each do |ebook_path|
          exit_copy = false
          copy_to_path = nil
          Thread.abort_on_exception = true
          Thread.new do
            copy_to_path = device.copy_to_documents(ebook_path)
            exit_copy = true
          end
          until exit_copy
            stream_io.print "."
            sleep(0.5)
          end
          stream_io.puts
          if copy_to_path
            stream_io.puts copy_to_path + " へコピーしました"
          else
            stream_io.error "#{device.name}が見つからなかったためコピー出来ませんでした"
            exit Narou::EXIT_ERROR_CODE # next しても次も失敗すると分かりきっているためここで終了する
          end
        end
      end
      if send_all && @options["backup-bookmark"]
        process_backup_bookmark(device)
      end
    rescue Device::SendFailure, Interrupt
      stream_io.puts "送信を中断しました"
      exit Narou::EXIT_INTERRUPT
    end

    def process_backup_bookmark(device)
      device.extend(device.get_hook_module)
      unless device.respond_to?(:backup_bookmark)
        stream_io.error "ご利用の端末での栞データのバックアップは対応していません"
        return
      end
      if device.backup_bookmark > 0
        stream_io.puts "端末の栞データをバックアップしました"
      end
    end

    def process_restore_bookmark(device)
      device.extend(device.get_hook_module)
      unless device.respond_to?(:restore_bookmark)
        stream_io.error "ご利用の端末での栞データのバックアップは対応していません"
        return
      end
      if device.restore_bookmark > 0
        stream_io.puts "栞データを端末にコピーしました"
      else
        stream_io.puts "栞データが無いようです"
      end
    end
  end
end
