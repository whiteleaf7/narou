# -*- coding: utf-8 -*-

#
# 対象小説情報
# タイトル: 最果てのパラディン
# 作者: 柳野かなた
# URL: http://ncode.syosetu.com/n5115cq/
#
# 詳細については http://bit.ly/1vTEH04 を参照して下さい
#
converter "n5115cq 最果てのパラディン" do
  # 各種変換処理がされる「前」の生データに対しての変換処理を記述
  def before(io, text_type)
    super
    if text_type == "body"
      io.string.gsub!("|《命ず》、《ネー・》", "|《命ず》《ネー・》、")
      io.string.gsub!(/[|｜]《([^《》]+)》《((?:\p{Hiragana}|\p{Katakana}|[・ー])+)》/) do |match|
        @inspector.info("ルビを調整\n" + match)
        "｜≪#{$1}≫《#{$2}》"
      end
    end
    io
  end

  # 各種変換処理がされた「後」のデータに対しての変換処理を記述
  def after(io, text_type)
    super
    io
  end
end
