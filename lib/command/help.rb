# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

module Command
  class Help < CommandBase
    HEADER = "Narou.rb ― 小説家になろうダウンローダ＆縦書き用整形スクリプト"

    def oneline_help
      "このヘルプを表示します"
    end

    def execute(argv)
      if Narou.already_init?
        display_help
      else
        display_help_first_time
      end
    end

    def display_help
      puts HEADER
      puts
      puts " <bold><green>Usage: narou &lt;command&gt; [arguments...] [options...] [--no-color]</green></bold>".termcolor
      puts
      puts " コマンドの簡単な説明:"
      cmd_list = Command.get_list
      cmd_list.each do |key, command|
        oneline = command.oneline_help.split("\n")
        puts "   <bold><green>#{key.ljust(12)}</green></bold> #{oneline.shift}".termcolor
        oneline.each do |h|
          puts " " * 16 + h
        end
      end
      puts
      puts "  各コマンドの詳細は narou <command> -h/--help を参照してください。"
      puts "  各コマンドは先頭の一文字か二文字でも指定できます。"
      puts "  (e.g. `narou <bold><yellow>d</yellow></bold> n4259s', `narou <bold><yellow>fr</yellow></bold> musyoku')".termcolor
      puts "  表示の色は--no-colorとオプションを付けるか`narou s no-color=true'で消せます。".termcolor
    end

    def display_help_first_time
      puts HEADER
      puts
      puts " <bold><green>Usage: narou init</green></bold>".termcolor
      puts
      puts "   まだこのフォルダは初期化されていません。"
      puts "   <bold><yellow>narou init</yellow></bold> コマンドを実行して初期化を行いましょう。".termcolor
    end
  end
end
