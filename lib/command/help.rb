# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

module Command
  class Help < CommandBase
    HEADER = "Narou.rb ― 小説家になろうダウンローダ＆縦書用整形スクリプト"

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
      puts " <green>Usage: narou &lt;command&gt; [arguments...] [options...] [--no-color]</green>".termcolor
      puts
      puts " コマンドの簡単な説明:"
      cmd_list = Command.get_list
      cmd_list.each do |key, command|
        oneline = command.oneline_help.split("\n")
        puts "   <green>#{key.ljust(12)}</green> #{oneline.shift}".termcolor
        oneline.each do |h|
          puts " " * 16 + h
        end
      end
      puts
      puts "  各コマンドの詳細は narou <command> -h/--help を参照してください。"
      puts "  各コマンドは先頭の一文字か二文字でも指定できます。"
      puts "  (e.g. `<yellow>narou d n4259s</yellow>', `<yellow>narou fr musyoku</yellow>')".termcolor
      puts
      puts "  表示の色は--no-colorとオプションを付けるか`<yellow>narou s no-color=true</yellow>'で消せます。".termcolor
    end

    def display_help_first_time
      puts HEADER
      puts
      puts " <green>Usage: narou init</green>".termcolor
      puts
      puts "   まだこのフォルダは初期化されていません。"
      puts "   <yellow>narou init</yellow> コマンドを実行して初期化を行いましょう。".termcolor
    end
  end
end
