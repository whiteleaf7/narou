# -*- coding: utf-8 -*-

#
# 対象小説情報
# タイトル: まのわ ～魔物倒す・能力奪う・私強くなる～
# 作者: 紫炎
# URL: http://ncode.syosetu.com/n3730bn/
#
converter "n3730bn まのわ ～魔物倒す・能力奪う・私強くなる～" do
  def before(io, text_type)
    if text_type != "postscript"
      super
    end
    io
  end

  def after(io, text_type)
    buffer = StringIO.new
    io.each do |line|
      if line =~ /^◎/
        buffer.puts "［＃ゴシック体］#{line.rstrip}［＃ゴシック体終わり］"
        buffer.puts
      else
        buffer.puts line
      end
    end
    if text_type == "postscript"
      buffer.string.tr!("#{ConverterBase::KANJI_NUM}", "０-９")
      buffer.string.gsub!("２分アキ", "二分アキ")
    end
    buffer
  end
end
