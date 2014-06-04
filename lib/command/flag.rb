# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../database"
require_relative "../downloader"
require_relative "../localsetting"

module Command
  class Flag < CommandBase
    ATTRIBUTES = %w(end)

    def oneline_help
      "小説の各種フラグを設定します"
    end

    def initialize
      super("<attribute> <target> [<target2> ...]")
      @opt.separator <<-EOS

  ・指定した小説に各種フラグを設定します
  ・再実行で解除
  ・現在指定可能なフラグ
      end : 小説が完結状態かどうか

  Example:
    narou flag end 100   # ID:100の小説を完結状態にする
      EOS
    end

    def execute(argv)
      super
      if argv.empty?
        puts @opt.help
        return
      end
      attribute = (argv.shift || "").downcase
      unless ATTRIBUTES.include?(attribute)
        error "有効なフラグを指定して下さい\n指定可能なフラグ：#{ATTRIBUTES.join(', ')}"
        exit 1
      end
      if argv.length < 1
        error "対象小説を指定して下さい"
        exit 1
      end
      database = Database.instance
      argv.each do |target|
        data = Downloader.get_data_by_target(target)
        unless data
          error "#{target} は存在しません"
          next
        end
        flags = data["flags"] || {}
        if flags.include?(attribute)
          flags.delete(attribute)
          puts "#{data['title']} から #{attribute} フラグを削除しました"
        else
          flags[attribute] = true
          puts "#{data['title']} の #{attribute} フラグを設定しました"
        end
        database[data["id"]]["flags"] = flags
      end
      database.save_database
    end
  end
end
