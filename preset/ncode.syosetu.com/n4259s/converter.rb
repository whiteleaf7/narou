# -*- coding: utf-8 -*-

#
# 対象小説情報
# タイトル: 異世界迷宮で奴隷ハーレムを
# 作者: 蘇我捨恥
# URL: http://ncode.syosetu.com/n4259s/
#
converter "n4259s 異世界迷宮で奴隷ハーレムを" do
  def before(io, text_type)
    data = io.read
    data.gsub!("\n\n", "\n")
    StringIO.new(data)
  end

  def level_convert!(line)
    line.gsub!(/Ｌｖ/, "Lv［＃「Lv」は縦中横］")
    line.gsub!(/Lv([0-9０-９]+)/, "Lv［＃「Lv」は縦中横］\\1［＃「\\1」は縦中横］")
  end

  def is_parameter_block?(line)
    if line =~ /^[^「『\(（【〈《≪［ 　―]/
      return true
    else
      return false
    end
  end

  def in_parameter_block?(line)
    unless @in_parameter_block
      if is_parameter_block?(line)
        @in_parameter_block = true
        return true
      end
    end
    return false
  end

  def out_parameter_block?(line)
    if @in_parameter_block
      unless is_parameter_block?(line) || line =~ /^[\*＊]+/
        @in_parameter_block = false
        return true
      end
    end
    return false
  end

  def after(io, text_type)
    return io unless text_type == "body"
    write_fp = StringIO.new
    non_close_parameter = false
    @in_parameter_block = false
    io.each do |line|
      line.rstrip!
      unless comments_block?(line)
        level_convert!(line)
        if in_parameter_block?(line)
          non_close_parameter = true
          write_fp.puts("［＃ここからパラメーター］")
        end
        if out_parameter_block?(line)
          non_close_parameter = false
          write_fp.puts("［＃ここでパラメーター終わり］")
        end
      end
      write_fp.puts(line)
    end
    if non_close_parameter
      write_fp.puts("［＃ここでパラメーター終わり］")
    end
    data = write_fp.string
    data.lstrip!
    data.gsub!(/\n\n(［＃ここからパラメーター］)/m, "\n\\1")
    data.gsub!(/(［＃ここでパラメーター終わり］\n\n)/m, "［＃ここでパラメーター終わり］\n")
    write_fp
  end
end
