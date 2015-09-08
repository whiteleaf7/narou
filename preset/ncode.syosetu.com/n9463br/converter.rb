# -*- coding: utf-8 -*-

#
# 対象小説情報
# タイトル: 僕と彼女と実弾兵器（アンティーク）
# 作者: Gibson
# URL: http://ncode.syosetu.com/n9463br/
#
# 詳細については http://bit.ly/1vTEH04 を参照して下さい
#
converter "n9463br 僕と彼女と実弾兵器（アンティーク）" do
  # 各種変換処理がされる「前」の生データに対しての変換処理を記述
  def before(io, text_type)
    #super
    io.string.gsub!("\n\n", "\n")
    io
  end

  # 各種変換処理がされた「後」のデータに対しての変換処理を記述
  def after(io, text_type)
    super
    if text_type == "body"
      io.string.gsub!(/^(　――.+?――)$/, "［＃太字］\\1［＃太字終わり］")
      io.string.gsub!(/「〝(.+?)〟」/, "『\\1』")
      io.string.gsub!(/「〝([^〟]+?)」$/, "『\\1』")
    end
    io
  end
end
