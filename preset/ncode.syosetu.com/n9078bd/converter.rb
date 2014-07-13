# -*- coding: utf-8 -*-

#
# 対象小説情報
# タイトル: この世界がゲームだと俺だけが知っている
# 作者: ウスバー
# URL: http://ncode.syosetu.com/n9078bd/
#
converter "n9078bd この世界がゲームだと俺だけが知っている" do
  def before(io, text_type)
    super
  end

  def after(io, text_type)
    io.string.gsub!("＋　※［＃縦線］Ｌ","［＃ここから横書き］＋　※［＃縦線］Ｌ［＃ここで横書き終わり］")
    io.string.gsub!("＋　±","［＃ここから横書き］＋　±［＃ここで横書き終わり］")
    io.string.gsub!("＋　－","［＃ここから横書き］＋　－［＃ここで横書き終わり］")
    io.string.gsub!("　－","　［＃ここから横書き］－［＃ここで横書き終わり］")
    io.string.gsub!("『－』","『［＃ここから横書き］－［＃ここで横書き終わり］』")
    io.string.gsub!("Ξ","［＃ここから横書き］≡［＃ここで横書き終わり］")
    io.string.gsub!("＋Ｌ","［＃ここから横書き］＋Ｌ［＃ここで横書き終わり］")
    io.string.gsub!("※［＃縦線］Ｌ","［＃ここから横書き］※［＃縦線］Ｌ［＃ここで横書き終わり］")
    io.string.gsub!("　＝","　［＃ここから横書き］＝［＃ここで横書き終わり］")
    io
  end
end
