# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../narou"
require_relative "../helper"
require_relative "../device"

module Command
  class Send < CommandBase
    def oneline_help
      "変換したEPUB/MOBIを電子書籍端末に送信します"
    end

    def initialize
      super("<device> <target1> [<target2> ...]")
      @opt.separator <<-EOS

  ・指定した小説の電子書籍データ(#{Device::DEVICES.map{|_,d| d::EBOOK_FILE_EXT}.join(", ")})を<device>で指定した端末に送信します。
    <device>には現在 #{Device::DEVICES.keys.join(", ")} が指定出来ます。
  ・narou setting device=<device>としておけば、<device>の入力を省略できます。
    また、convertコマンドで変換時に(端末がPCに接続されていれば)自動でデータを送信するようになります。
  ！Windows専用コマンドです！

  Example:
    narou send kindle 6
    narou send kobo 6
    narou setting device=kindle
    narou send 6        # <device>の省略
      EOS
    end

    def get_device(argv)
      if Device.exists?(argv.first)
        return Narou.get_device(argv.shift)
      end
      Narou.get_device
    end

    def execute(argv)
      super
      if argv.empty?
        puts @opt.help
        return
      end
      unless Helper.os_windows?
        warn "このコマンドはWindows専用です"
        exit 1
      end
      device = get_device(argv)
      unless device
        warn "デバイス名を指定して下さい"
        exit 1
      end
      unless device.connecting?
        warn "#{device.name}が接続されていません"
        exit 1
      end
      argv.each do |target|
        ebook_path = Narou.get_ebook_file_path(target, device.ebook_file_ext)
        unless ebook_path
          warn "#{target} は存在しません"
          next
        end
        unless File.exists?(ebook_path)
          warn "まだファイル(#{File.basename(ebook_path)})が無いようです"
          next
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
          warn "#{device.name}が見つからなかったためコピー出来ませんでした"
          exit 1   # next しても次も失敗すると分かりきっているためここで終了する
        end
      end
    end
  end
end
