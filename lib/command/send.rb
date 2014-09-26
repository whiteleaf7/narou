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
      super("<device> [<target1> ...] [options]")
      @opt.separator <<-EOS

  ・<target>で指定した小説の電子書籍データ(#{Device::DEVICES.map{|_,d| d::EBOOK_FILE_EXT}.join(", ")})を<device>で指定した端末に送信します。
    <device>には現在 #{Device::DEVICES.keys.join(", ")} が指定出来ます。
  ・narou setting device=<device>としておけば、<device>の入力を省略できます。
    また、convertコマンドで変換時に(端末がPCに接続されていれば)自動でデータを送信するようになります。
  ・<target>を省略した場合、管理している小説全てのファイルのタイムスタンプを端末のものと比べて新しければ送信します。

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

      @opt.on("--without-freeze", "一括送信時に凍結された小説は対象外にする") {
        @options["without-freeze"] = true
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
        error "デバイス名が指定されていないか、間違っています。\n" +
              "narou setting device=デバイス名 で指定出来ます。\n" +
              "指定出来るデバイス名：" + Device::DEVICES.keys.join(", ")
        exit Narou::EXIT_ERROR_CODE
      end
      unless device.physical_support?
        error "#{device.display_name} への直接送信は対応していません"
        exit Narou::EXIT_ERROR_CODE
      end
      unless device.connecting?
        error "#{device.display_name} が接続されていません"
        exit Narou::EXIT_ERROR_CODE
      end
      send_all = false
      titles = {}
      if argv.empty?
        send_all = true
        Database.instance.each do |id, data|
          next if @options["without-freeze"] && Narou.novel_frozen?(id)
          argv << id
          titles[id] = data["title"]
        end
      end
      tagname_to_ids(argv)
      argv.each do |target|
        ebook_path = Narou.get_ebook_file_path(target, device.ebook_file_ext)
        unless ebook_path
          error "#{target} は存在しません"
          next
        end
        unless File.exist?(ebook_path)
          error "まだファイル(#{File.basename(ebook_path)})が無いようです" unless send_all
          next
        end
        if send_all
          if device.ebook_file_old?(ebook_path)
            puts "<bold><green>ID:#{target}　#{TermColorLight.escape(titles[target])}</green></bold>".termcolor
          else
            next
          end
        end
        print "#{device.name}へ送信しています"
        exit_copy = false
        copy_to_path = nil
        Thread.new do
          copy_to_path = device.copy_to_documents(ebook_path)
          exit_copy = true
        end
        until exit_copy
          print "."
          sleep(0.5)
        end
        puts
        if copy_to_path
          puts copy_to_path + " へコピーしました"
        else
          error "#{device.name}が見つからなかったためコピー出来ませんでした"
          exit Narou::EXIT_ERROR_CODE   # next しても次も失敗すると分かりきっているためここで終了する
        end
      end
    rescue Interrupt
      puts "送信を中断しました"
      exit Narou::EXIT_ERROR_CODE
    end
  end
end
