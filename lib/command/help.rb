# frozen_string_literal: true

#
# Copyright 2013 whiteleaf. All rights reserved.
#

module Command
  class Help < CommandBase
    HEADER = "Narou.rb ― 小説家になろうダウンローダ＆縦書き用整形スクリプト"

    def self.oneline_help
      "このヘルプを表示します"
    end

    def execute(_argv)
      disable_logging
      if Narou.already_init?
        display_help
      else
        display_help_first_time
      end
    end

    def display_help
      stream_io.puts(<<~HELP.termcolor)
        #{HEADER}

         <bold><green>Usage: narou &lt;command&gt; [arguments...] [options...]
                      [--no-color] [--multiple] [--time] [--backtrace]</green></bold>

         コマンドの簡単な説明:
      HELP
      cmd_list = Command.get_list
      cmd_list.each do |key, command|
        oneline = command.oneline_help.split("\n")
        stream_io.puts "   <bold><green>#{key.ljust(12)}</green></bold> #{oneline.shift}".termcolor
        oneline.each do |h|
          stream_io.puts " " * 16 + h
        end
      end
      stream_io.puts(<<-HELP.termcolor)

  各コマンドの詳細は narou &lt;command&gt; -h を参照してください。
  各コマンドは先頭の一文字か二文字でも指定できます。
  (e.g. `narou <bold><yellow>d</yellow></bold> n4259s', `narou <bold><yellow>fr</yellow></bold> musyoku')

  <underline><bold>Global Options:</bold></underline>
    --no-color   カラー表示を無効にする
    --multiple   引数の区切りにスペースの他に","も使えるようにする
    --time       実行時間表示
    --backtrace  エラー発生時詳細情報を表示
      HELP
    end

    def display_help_first_time
      stream_io.puts(<<~HELP.termcolor)
        #{HEADER}

         <bold><green>Usage: narou init</green></bold>

           まだこのフォルダは初期化されていません。
           <bold><yellow>narou init</yellow></bold> コマンドを実行して初期化を行いましょう。
      HELP
    end
  end
end
