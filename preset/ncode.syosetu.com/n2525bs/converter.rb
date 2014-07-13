# -*- coding: utf-8 -*-

#
# 対象小説情報
# タイトル: 魔剣ゾルディの女主人公とっかえひっかえ成長記録
# 作者: 木原ゆう
# URL: http://ncode.syosetu.com/n2525bs/
#
converter "n2525bs 魔剣ゾルディの女主人公とっかえひっかえ成長記録" do
  def before(io, text_type)
    super
    io.string.gsub!(/(\/{2,})/) do
      if $1.length == 3
        "❤"
      else
        "❤❤"
      end
    end
    io
  end

  def is_parameter_block?(line)
    !!(line =~ /＝{2,}/)
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
      if is_parameter_block?(line)
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
      if in_parameter_block?(line)
        non_close_parameter = true
        write_fp.puts("［＃ここからパラメーター］")
        next
      end
      if out_parameter_block?(line)
        non_close_parameter = false
        write_fp.puts("［＃ここでパラメーター終わり］")
        next
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
    data.gsub!("　❤", "❤")
    write_fp
  end
end
