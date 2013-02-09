# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

module Command
  class Help < CommandBase
    def execute(argv)
      puts "Narou.rb ― 小説家になろうダウンローダ＆縦書用整形スクリプト"
      puts
      if Narou.already_init?
        puts " Usage: #{@opt.program_name} <command> [arguments...] [options...]"
      else
        puts " Usage: #{@opt.program_name} <command>"
      end
      puts
      puts " コマンドの簡単な説明:"
      if Narou.already_init?
        cmd_list = Command.get_list.select { |k, _| k != "init" }
      else
        cmd_list = Command.get_list.select { |k, _| k == "init" }
      end
      cmd_list.each do |key, command|
        oneline = command.oneline_help.split("\n")
        puts "   #{key.ljust(12)} #{oneline.shift}"
        oneline.each do |h|
          puts " " * 16 + h
        end
      end
      puts
      puts "  各コマンドの詳細は narou <command> -h/--help を参照してください。"
      puts "  各コマンドは頭文字の一文字のみでも指定できます。"
      puts "  (e.g. '#{@opt.program_name} d n4259s')"
    end

    def oneline_help
      "このヘルプを表示します"
    end
  end
end
