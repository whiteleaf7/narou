# -*- coding: utf-8 -*-

#
# 対象小説情報
# タイトル: うちの娘の為ならば、俺はもしかしたら魔王も倒せるかもしれない 。
# 作者: CHIROLU
# URL: http://ncode.syosetu.com/n5530cf/
#
# 詳細については http://bit.ly/1vTEH04 を参照して下さい
#
converter "n5530cf うちの娘の為ならば、俺はもしかしたら魔王も倒せるかもしれない 。" do
  # 各種変換処理がされる「前」の生データに対しての変換処理を記述
  def before(io, text_type)

    io.string.gsub!(/[－ー][－―]/, "――")
    io.string.gsub!(/\( ([前後]) \)/, "（\\1）") if text_type == "subtitle"
    if text_type =~ /body|postscript/
      io.string.gsub!(/([っッ♪…]) +([^」』\)])/, "\\1　\\2")
      io.string.gsub!(/ +/, "")
    end

    case (@current_index+1)
    when 78
      io.string.gsub!("どうして無事だっ　たのですか", "どうして無事だったのですか")
    end

    super
    io
  end

  # 各種変換処理がされた「後」のデータに対しての変換処理を記述
  def after(io, text_type)
    super
    io
  end
end
