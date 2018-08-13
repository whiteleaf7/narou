# -*- coding: utf-8 -*-

#
# 対象小説情報
# タイトル: ありふれた職業で世界最強
# 作者: 厨二好き/白米良
# URL: http://ncode.syosetu.com/n8611bv/
#
# 詳細については http://bit.ly/1vTEH04 を参照して下さい
#
converter "n8611bv ありふれた職業で世界最強" do
  def before(io, text_type)
    super
    io
  end

  def is_parameter?(line)
    line =~ /^　?＝{5,}$/
  end

  def after(io, text_type)
    super
    return io unless text_type == "body"
    write_fp = StringIO.new
    parameter_opened = false
    io.each do |line|
      if is_parameter?(line)
        if parameter_opened
          write_fp.puts "＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝"
          write_fp.puts "［＃ここで太字終わり］"
        else
          write_fp.puts "［＃ここから太字］"
          write_fp.puts "＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝"
        end
        parameter_opened ^= true
      else
        write_fp.puts(line)
      end
    end
    if parameter_opened
      write_fp.puts "＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝"
      write_fp.puts "［＃ここで太字終わり］"
    end

    write_fp.string.gsub!(/^～{5,}/, "　　　　＊　＊　＊")
    write_fp
  end
end
