# -*- coding: utf-8 -*-

#
# 対象小説情報
# タイトル: まのわ ～魔物倒す・能力奪う・私強くなる～
# 作者: 紫炎
# URL: http://ncode.syosetu.com/n3730bn/
#
converter "n3730bn まのわ ～魔物倒す・能力奪う・私強くなる～" do
  def before(io, text_type)
    if text_type == "postscript"
      @__manowa_setting_num2kanji |= @setting.enable_convert_num_to_kanji
      @setting.enable_convert_num_to_kanji = false
    else
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
      @setting.enable_convert_num_to_kanji = @__manowa_setting_num2kanji
    end
    buffer
  end
end
