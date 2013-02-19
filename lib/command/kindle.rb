# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../narou"
require_relative "../helper"
require_relative "../device"

module Command
  class Kindle < CommandBase
    def oneline_help
      "MOBIをKindleに送信します"
    end

    def initialize
      super("<target1> [<target2> ...]")
      @opt.separator <<-EOS

  ・指定した小説のMOBIをKindleに送信します。(PCに接続してあれば)
  ・narou setting convert.send_kindle=true とすることで、変換終了時に自動で送信出来るようになります。
  ！Windows専用コマンドです！

  Example:
    narou kindle 6
      EOS
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
      unless Device::Kindle.connecting?
        warn "Kindleに接続していません"
        exit 1
      end
      argv.each do |target|
        mobi_path = Narou.get_mobi_path(target)
        unless mobi_path
          warn "#{target} は存在しません"
          next
        end
        unless File.exists?(mobi_path)
          warn "まだMOBIファイル(#{File.basename(mobi_path)})が無いようです"
          next
        end
        print "Kindleへコピーしています"
        exit_copy = false
        copy_to_path = nil
        Thread.new do
          copy_to_path = Device::Kindle.copy_to_documents(mobi_path)
          exit_copy = true
        end
        until exit_copy
          print "."
          sleep(1)
        end
        puts
        if copy_to_path
          puts copy_to_path + " へコピーしました"
        else
          warn "Kindleが見つからなかったためコピー出来ませんでした"
          exit 1   # next しても次も失敗すると分かりきっているためここで終了する
        end
      end
    end
  end
end
