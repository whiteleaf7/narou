# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../database"
require_relative "../downloader"
require_relative "../inventory"

module Command
  class Flag < CommandBase
    ATTRIBUTES = %w(end delete)

    def self.oneline_help
      "小説の各種フラグを設定します"
    end

    def initialize
      super("<attribute> <target> [<target2> ...]")
      @opt.separator <<-EOS.termcolor

  <bold><red>非推奨のコマンドです。tagコマンドを使用して下さい
  flagコマンドはv.1.7.0で廃止予定です
  
  flagデータをtagデータに移行するには、
  narou flag --convert-tag
  を実行して下さい</red></bold>

  ・指定した小説に各種フラグを設定します
  ・再実行で解除
  ・--on, --off オプションを付けることで強制設定可能
  ・現在指定可能なフラグ
      end : 小説が完結状態
      delete: 削除された状態

  Examples:
    narou flag end 100       # ID:100の小説を完結状態にする
    narou flag end --on 100  # 現在の状態に関わらず完結状態にする

  Options:
      EOS
      @opt.on("--on", "強制的にフラグを立てる") {
        @options["on"] = true
      }
      @opt.on("--off", "強制的にフラグをはずす") {
        @options["off"] = true
      }
      @opt.on("--convert-tag", "flagデータをtagデータに移行します") {
        modify = false
        database = Database.instance
        database.each do |id, data|
          if data["flags"]
            tags = data["flags"].keys
            tags << "404" if tags.delete("delete")
            Tag.execute!([id, "--add", tags.join(" "), "--color", "white"])
            puts "-" * 70
            data.delete("flags")
            modify = true
          end
        end
        if modify
          database.save_database
          puts "移行が完了しました"
        end
        exit 0
      }
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
        flag = !flags[attribute]
        flag = true if @options["on"]
        flag = false if @options["off"]
        flags[attribute] = flag
        if flag
          puts "#{data['title']} の #{attribute} フラグを立てました"
        else
          flags.delete(attribute)
          puts "#{data['title']} から #{attribute} フラグをはずしました"
        end
        database[data["id"]]["flags"] = flags
      end
      database.save_database
    end
  end
end
