# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../database"
require_relative "../downloader"

module Command
  class Update < CommandBase
    def initialize
      super("[<target> <target2> ...] [option]")
      @opt.separator <<-EOS

  ・管理対象の小説を更新します。
    更新したい小説のNコード、URL、タイトル、IDもしくは別名を指定して下さい。
    IDは #{@opt.program_name} list を参照して下さい。
  ・対象を指定しなかった場合、すべての小説の更新をチェックします。
  ・一度に複数の小説を指定する場合は空白で区切って下さい。

  Example:
    narou update               # 全て更新
    narou update 0 1 2 4
    narou update n9669bk 異世界迷宮で奴隷ハーレムを
    narou update http://ncode.syosetu.com/n9669bk/

  Options:
      EOS
      @opt.on("-n", "--no-convert", "変換をせずアップデートのみ実行する") {
        @options["no-convert"] = true
      }
    end

    def execute(argv)
      super
      update_target_list = argv.dup
      if update_target_list.empty?
        Database.instance.each do |id, _|
          update_target_list << id
        end
      end
      update_target_list.each_with_index do |target, i|
        Helper.print_horizontal_rule if i > 0
        data = Downloader.get_data_by_target(target)
        unless data
          warn "#{target} は存在しません"
          next
        end
        title = data["title"]
        if Narou.novel_frozen?(target)
          puts "#{title} は凍結中です\nアップデートを中止しました"
          next
        end
        is_updated = Downloader.start(target)
        if is_updated
          unless @options["no-convert"]
            Convert.execute_and_rescue_exit([target])
          end
        else
          puts "#{title} に更新はありません"
        end
      end
    end

    def oneline_help
      "小説を更新します"
    end
  end
end
