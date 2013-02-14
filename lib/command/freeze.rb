# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../database"
require_relative "../downloader"
require_relative "../localsetting"

module Command
  class Freeze < CommandBase
    def oneline_help
      "小説の凍結設定を行います"
    end

    def initialize
      super("<target> [<target2> ...]")
      @opt.separator <<-EOS

  ・指定した小説を凍結し、変更不可属性を付与します。
  ・凍結することでダウンロード、アップデート及び削除が出来なくなります。
  ・凍結済みの小説を指定した場合、凍結が解除されます。

  Example:
    narou freeze --list
    narou freeze n9669bk
    narou freeze 0 1 musyoku

  Options:
      EOS
      @opt.on("-l", "--list", "凍結中小説の一覧を表示") {
        output_freeze_list
        exit 0
      }
    end

    def output_freeze_list
      database = Database.instance
      puts "凍結中小説一覧"
      puts " ID |     タイトル"
      LocalSetting.get["freeze"].each do |id, _|
        data = database.get_data("id", id)
        if data
          puts "#{id.to_s.rjust(3)} | #{data["title"]}"
        end
      end
    end

    def execute(argv)
      super
      if argv.empty?
        puts @opt.help
        return
      end
      frozen_list = LocalSetting.get["freeze"]
      argv.each do |target|
        data = Downloader.get_data_by_target(target)
        unless data
          puts "#{target} は存在しません"
          next
        end
        id, title = data["id"], data["title"]
        if frozen_list.include?(id)
          frozen_list.delete(id)
          puts "#{title} の凍結を解除しました"
          next
        else
          frozen_list[id] = true
          puts "#{title} を凍結しました"
        end
      end
      LocalSetting.get.save_settings
    end
  end
end
