# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "termcolorlight"

module Narou
  module Input
    module_function

    #
    # 肯定か否定かの確認を入力
    #
    # default: エンターを押した場合に返ってくる値
    # nontty_default: pipe等から接続された場合に返ってくる値
    # @return: yes = true, no = false
    #
    def confirm(message, default = false, nontty_default = true)
      return nontty_default unless $stdin.tty?
      confirm_msg = "#{message} (y/n)?: "
      print confirm_msg
      while input = $stdin.getch
        puts input
        case input.downcase
        when "y"
          return true
        when "n"
          return false
        else
          return default if input.strip == ""
          print confirm_msg
        end
      end
    end

    #
    # 選択肢を表示して選択させる
    #
    # choices: { 選択肢: 説明 } のハッシュ形式で渡す。選択出来ない状況(pipe等)の場合に返す
    #          値は :default の要素を返す。:default がない場合は先頭の要素
    # @return: 選ばれた選択肢を返す
    #
    # @example:
    #   choices = { "ja" => "日本語", "en" => "English", default: "ja" }
    #   Narou::Input.choose("select a language?", choices)
    #
    def choose(message, choices)
      default = choices[:default] || choices.first[0]
      return default unless $stdin.tty?
      puts message
      choices.each do |name, help|
        next if name == :default
        puts "<bold>#{name}</bold>: #{help}".termcolor
      end
      loop do
        print "> "
        input = $stdin.gets.strip.downcase
        if key = choices.keys.delete(input)
          return key
        end
        puts "選択肢の中にありません。もう一度入力して下さい"
      end
    end
  end
end

