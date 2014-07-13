# -*- coding: utf-8 -*-

#
# 対象小説情報
# タイトル: Ｒｅ：ゼロから始める異世界生活
# 作者: 鼠色猫
# URL: http://ncode.syosetu.com/n2267be/
#
converter "n2267be Ｒｅ：ゼロから始める異世界生活" do
  def before(io, text_type)
    super
    io.string.gsub!(/^[ 　\t]*[※ 　\t]+$/, "※　※　※")
    io
  end

  def after(io, text_type)
    super
  end
end
