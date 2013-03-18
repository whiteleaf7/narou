# -*- coding: utf-8 -*-

#
# 対象小説情報
# タイトル: オーバーロード：後編
# 作者: 丸山くがね
# URL: http://ncode.syosetu.com/n1839bd/
#
converter "オーバーロード：後編" do
  def before(io, text_type)
    super
  end

  def after(io, text_type)
    if io.string.scan(/[<＜〈(（]([ぁ-んァ-ヴーゞ・A-Za-zＡ-Ｚａ-ｚ]+?)[>＞〉)）]/).length > 0
      @inspector.warning("オバロっぽいルビを検出：#{$1}")
    end
    io.string.gsub!(/[≪『](.+?)／(.+?)[≫』]/) do
      spell_ruby, spell_name = $1, $2
      if spell_name =~ /^([ぁ-んァ-ヴーゞ・Ａ-Ｚａ-ｚA-Za-z]+)$/
        spell_name = spell_ruby
        spell_ruby = $&
      end
      option = ""
      if spell_ruby =~ /^――(.+)/
        spell_ruby = $1
        option = "――"
      end
      "#{option}≪｜#{spell_name}《#{spell_ruby}》≫"
    end
    io
  end
end
