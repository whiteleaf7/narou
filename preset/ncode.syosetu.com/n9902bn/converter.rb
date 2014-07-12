# -*- coding: utf-8 -*-

#
# 対象小説情報
# タイトル: デスマーチからはじまる異世界狂想曲
# 作者: 愛七ひろ
# URL: http://ncode.syosetu.com/n9902bn/
#
converter "n9902bn デスマーチからはじまる異世界狂想曲" do
  def before(io, text_type)
    super
  end

  def announce_line?(line)
    line =~ /^〉/
  end

  def after(io, text_type)
    buffer = StringIO.new
    just_before_line_is_announce = false
    io.each do |line|
      if announce_line?(line)
        unless just_before_line_is_announce
          if line.strip != ""
            buffer.puts
          end
        end
        just_before_line_is_announce = true
        buffer.puts "［＃ゴシック体］［＃太字］#{line.rstrip}［＃太字終わり］［＃ゴシック体終わり］"
      else
        if just_before_line_is_announce
          buffer.puts
        end
        just_before_line_is_announce = false
        buffer.puts line
      end
    end
    buffer
  end
end
