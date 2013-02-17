# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "fileutils"
require_relative "../downloader"
require_relative "../inspector"
require_relative "../novelsetting"
require_relative "../localsetting"

module Command
  class Error < CommandBase
    def oneline_help
      "小説状態の調査状況ログを表示します"
    end

    def initialize
      super("[<target> ...]")
      @opt.separator <<-EOS

  ・引数を指定しなかった場合は直前に変換した小説の状態調査状況ログを表示します。
  ・小説を指定した場合はその小説のログを表示します。
  ・narou setting convert.inspect=true とすれば変換時に常に表示されるようになります。

  Example:
    narou error     # 直前の変換時のログを表示
    narou error 6   # ログを表示したい小説を指定する
      EOS
    end

    def execute(argv)
      super
      if argv.empty?
        latest_id = LocalSetting.get["latest_convert"]["id"]
        if latest_id
          data = Downloader.get_data_by_target(latest_id)
          display_log(data["title"])
        end
        return
      end
      argv.each_with_index do |target, i|
        Helper.print_horizontal_rule if i > 0
        data = Downloader.get_data_by_target(target)
        unless data
          warn "#{target} は存在しません"
          next
        end
        display_log(data["title"])
      end
    end

    def display_log(title)
      puts "(#{title} の小説状態調査状況ログ)"
      novel_setting = NovelSetting.create(title)
      puts Inspector.read_messages(novel_setting)
    end
  end
end
