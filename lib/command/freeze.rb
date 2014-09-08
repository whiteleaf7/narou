# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../database"
require_relative "../downloader"
require_relative "../inventory"

module Command
  class Freeze < CommandBase
    def self.oneline_help
      "小説の凍結設定を行います"
    end

    def initialize
      super("<target> [<target2> ...] [options]")
      @opt.separator <<-EOS

  ・指定した小説を凍結し、変更不可属性を付与します。
  ・凍結することでダウンロード、アップデート及び削除が出来なくなります。
  ・凍結済みの小説を指定した場合、凍結が解除されます。

  Examples:
    narou freeze --list
    narou freeze n9669bk
    narou freeze 0 1 musyoku

  Options:
      EOS
      @opt.on("-l", "--list", "凍結中小説の一覧を表示") {
        output_freeze_list
        exit 0
      }
      @opt.on("--on", "現在の状態にかかわらず凍結する") {
        @options["on"] = true
      }
      @opt.on("--off", "現在の状態にかかわらず解除する") {
        @options["off"] = true
      }
    end

    def output_freeze_list
      List.execute!(%w(--filter frozen))
    end

    def execute(argv)
      super
      if argv.empty?
        puts @opt.help
        return
      end
      tagname_to_ids(argv)
      frozen_list = Inventory.load("freeze", :local)
      argv.each do |target|
        data = Downloader.get_data_by_target(target)
        unless data
          puts "#{target} は存在しません"
          next
        end
        id, title = data["id"], data["title"]
        flag = !frozen_list.include?(id)
        flag = true if @options["on"]
        flag = false if @options["off"]
        if flag
          frozen_list[id] = true
          puts "#{title} を凍結しました"
        else
          frozen_list.delete(id)
          puts "#{title} の凍結を解除しました"
          next
        end
      end
      frozen_list.save
    end
  end
end
