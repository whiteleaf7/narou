# -*- coding: utf-8 -*-

#
# 対象小説情報
# タイトル: ログ・ホライズン
# 作者: 橙乃ままれ
# URL: http://ncode.syosetu.com/n8725k/
#
converter "n8725k ログ・ホライズン" do
  def before(io, element_type)
    super
    io.string.gsub!(/ルビ[:：]/, "")
    io
  end

  def after(io, element_type)
    data = io.string
    if element_type == "body"
      if data =~ /[｜|]([^《]+)《(、+)》/
        if $1.length == $2.length
          data.gsub!(/[｜|]([^《]+)《(、+)》/) do
            "［＃傍点］" + $1 + "［＃傍点終わり］"
          end
        end
      end
      data.gsub!("ロエ二", "ロエ２")
    end
    io
  end
end
