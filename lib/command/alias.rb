# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../localsetting"

module Command
  class Alias < CommandBase
    def initialize
      super("[<alias_name>=<target> ...] [options]")
      @opt.separator <<-EOS

  ・小説のIDに紐付けた好きな別名を作ることが出来ます。IDやNコード等を覚える必要がなくなります。
  ・<alias_name>にはアルファベット及び数字、アンダースコアが使用出来ます(/^\\w+$/)
  ・<target>は他のコマンドで指定出来るものがそのまま使えますが、すでにダウンロード済みである必要があります。
  ・引数なしで実行すると現在の別名の割り当て一覧を表示します

  Example:
    narou alias --list
    narou alias musyoku=n9669bk
    narou alias harem=1
    narou convert harem    # 他のコマンドで別名が使えるようになる
    narou alias harem=     # 右辺に何も書かないとその別名を解除できる

  Options:
      EOS
      @opt.on("-l", "--list", "現在の割り当て一覧を表示する") {
        output_aliases_list
        exit 0
      }
    end

    def output_aliases_list
      aliases = LocalSetting.get["alias"]
      database = Database.instance
      aliases.each do |name, id|
        title = database[id]["title"] rescue "(すでに削除されています)"
        puts "#{name} = #{title}"
      end
    end

    def execute(argv)
      super
      if argv.empty?
        puts @opt.help
        return
      end
      aliases = LocalSetting.get["alias"]
      argv.each_with_index do |arg, i|
        if i > 0
          puts "―" * 30
        end
        alias_name, target = arg.split("=", 2)
        unless alias_name =~ /^\w+$/
          puts "別名にはアルファベット・数字・アンダースコアしか使えません"
          next
        end
        if target == ""
          aliases.delete(alias_name)
          puts "#{alias_name} を解除しました"
          next
        end
        unless Downloader.novel_exists?(target)
          puts "#{target} は存在しません"
          next
        end
        data = Downloader.get_data_by_database(target)
        id = data["id"]
        title = data["title"]
        aliases[alias_name] = id
        puts "#{alias_name} を #{title} の別名に設定しました"
      end
      LocalSetting.get.save_settings
    end

    def oneline_help
      "小説のIDに紐付けた別名を作成します"
    end
  end
end
