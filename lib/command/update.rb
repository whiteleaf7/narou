# -*- coding: utf-8 -*-
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
  ・全て更新する場合、convert.no-openが設定されていなくても保存フォルダは開きません。

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
      no_open = false
      if update_target_list.empty?
        Database.instance.each_key do |id|
          update_target_list << id
        end
        no_open = true
      end
      update_target_list.each_with_index do |target, i|
        display_message = nil
        data = Downloader.get_data_by_target(target)
        if !data
          display_message = "<red>[ERROR]</red> #{target} は管理小説の中に存在しません".termcolor
        elsif Narou.novel_frozen?(target)
          if argv.length > 0
            display_message = "ID:#{data["id"]}　#{data["title"]} は凍結中です"
          else
            next
          end
        end
        Helper.print_horizontal_rule if i > 0
        if display_message
          puts display_message
          next
        end
        update_status = Downloader.start(target)
        case update_status
        when :ok
          unless @options["no-convert"]
            convert_argv = [target]
            convert_argv << "--no-open" if no_open
            Convert.execute!(convert_argv)
          end
        when :failed
          puts "ID:#{data["id"]}　#{data["title"]} の更新は失敗しました"
          Freeze.execute!([target])
        when :canceled
          puts "ID:#{data["id"]}　#{data["title"]} の更新はキャンセルされました"
        when :none
          puts "#{data["title"]} に更新はありません"
        end
      end
    rescue Interrupt
      puts "アップデートを中断しました"
      exit 1
    end

    def oneline_help
      "小説を更新します"
    end
  end
end
