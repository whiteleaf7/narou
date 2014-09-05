# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../narou"
require_relative "../helper"

module Command
  class Remove < CommandBase
    def self.oneline_help
      "小説を削除します"
    end

    def initialize
      super("<target> [<target2> ...] [options]")
      @opt.separator <<-EOS

  ・削除したい小説のNコード、URL、タイトルもしくはIDを指定して下さい。
    IDは #{@opt.program_name} list を参照して下さい。
  ・一度に複数の小説を指定する場合は空白で区切って下さい。
  ・削除確認をスキップするには -y オプションを有効にして下さい。
  ・削除するのはデータベースのインデックスだけで、変換済みテキストファイルやMOBIファイル等はそのまま残ります。ファイルをすべて削除する場合は --with-file オプションを指定して下さい。

  Examples:
    narou remove n9669bk
    narou remove http://ncode.syosetu.com/n9669bk/
    narou remove n9669bk http://ncode.syosetu.com/n4259s/
    narou remove 0 1 -y
    narou remove n9669bk --with-file   # ファイルも完全に削除する
    narou remove --all-ss              # 連載小説をすべて削除する
    narou remove --all-ss --with-file  # 短編小説をファイルも含めてすべて削除
    narou r 0 -wy    # ID:0を確認メッセージなしにファイルも含めて完全に削除する

  Options:
      EOS
      @opt.on("-y", "--yes", "削除確認メッセージを表示しない") {
        @options["yes"] = true
      }
      @opt.on("-w", "--with-file", "小説の保存フォルダ・ファイルも全て削除する") {
        @options["with-file"] = true
      }
      @opt.on("--all-ss", "短編小説をすべて削除する") {
        @options["all-ss"] = true
      }
    end

    def get_all_short_story
      Database.instance.get_object.values.select { |v| v["novel_type"] == 2 }
    end

    def execute(argv)
      super
      novels = []
      if @options["all-ss"]
        novels = get_all_short_story
        if novels.count == 0
          puts "短編小説がひとつもありません"
          return
        end
        argv += novels.map { |n| n["id"].to_s }
      end
      if argv.empty?
        puts @opt.help
        return
      end
      tagname_to_ids(argv)
      argv.each_with_index do |target, i|
        Helper.print_horizontal_rule if i > 0
        data = Downloader.get_data_by_target(target)
        unless data
          error "#{target} は存在しません"
          next
        end
        title = data["title"]
        if Narou.novel_frozen?(target)
          puts "#{title} は凍結中です\n削除を中止しました"
          next
        end
        unless @options["yes"]
          next unless Helper.confirm("#{title} を#{(@options["with-file"] ? "“完全に”" : "")}削除しますか")
        end
        Downloader.remove_novel(target, @options["with-file"])
        puts "<bold><green>#{TermColorLight.escape(title)} を削除しました</green></bold>".termcolor
      end
    end
  end
end
