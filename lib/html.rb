# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

class HTML
  attr_accessor :string

  def initialize(string)
    @string = string
  end

  #
  # 青空文庫形式に変換
  #
  def to_aozora
    @string = br_to_aozora
    @string = ruby_to_aozora
    @string = b_to_aozora
    @string = i_to_aozora
    @string = s_to_aozora
    @string = delete_tag
    @string
  end

  #
  # タグを削除
  #
  def delete_tag(text = @string)
    text.gsub(/<.+?>/, "")
  end

  #
  # 改行タグを改行へ
  #
  def br_to_aozora(text = @string)
    text.gsub(/[\r\n]+/, "").gsub(/<br.*?>/i, "\n")
  end

  #
  # ルビタグを青空文庫形式に変換
  #
  def ruby_to_aozora(text = @string)
    text.gsub(/<ruby>(.+?)<\/ruby>/i) do
      splited_ruby = $1.split(/<rt>/i)
      next delete_tag(splited_ruby[0]) unless splited_ruby[1]
      ruby_base = delete_tag(splited_ruby[0].split(/<rp>/i)[0])
      ruby_text = delete_tag(splited_ruby[1].split(/<rp>/i)[0])
      "｜#{ruby_base}《#{ruby_text}》"
    end
  end

  #
  # <b>タグを青空文庫形式に変換
  #
  def b_to_aozora(text = @string)
    text.gsub(/<b>/i, "［＃太字］").gsub(/<\/b>/i, "［＃太字終わり］")
  end

  #
  # <i>タグを青空文庫形式に変換
  #
  def i_to_aozora(text = @string)
    text.gsub(/<i>/i, "［＃斜体］").gsub(/<\/i>/i, "［＃斜体終わり］")
  end

  #
  # <s>タグを青空文庫形式に変換
  #
  def s_to_aozora(text = @string)
    text.gsub(/<s>/i, "［＃取消線］").gsub(/<\/s>/i, "［＃取消線終わり］")
  end
end
