# -*- coding: utf-8 -*-

#
# 対象小説情報
# タイトル: 無職転生　- 異世界行ったら本気だす -
# 作者: 理不尽な孫の手
# URL: http://ncode.syosetu.com/n9669bk/
#
converter "n9669bk 無職転生　- 異世界行ったら本気だす -" do
  def before(io, type)
    super
  end

  def is_parameter_block?(line)
    line =~ /^－{24,}$/ || line =~ /^＝{10,}$/
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

  def conver_dash!(line)
    line.gsub!(/－{2,}/) do |match|
      match.tr("－", "―")
    end
    line.gsub!(/^(―――)$/) do
      result = "　　　　　　　#{$1}"
      unless blank_line?(@before_line)
        result = "\n" + result
      end
      @request_insert_blank_next_line = true
      result
    end
    line.gsub!(/^(――)/, "　\\1")
  end

  def convert_shiten!(line)
    line.gsub!(/^　*―――?([^―]+?)―――?$/,
               "\n　［＃１段階小さな文字］［＃ゴシック体］［＃斜体］――\\1――" + \
               "［＃斜体終わり］［＃ゴシック体終わり］［＃小さな文字終わり］\n\n")
  end

  def after(io, type)
    write_fp = StringIO.new
    @before_line = ""
    @request_insert_blank_next_line = false
    @in_parameter_block = false
    io.each do |line|
      if @request_insert_blank_next_line
        write_fp.puts unless blank_line?(line)
        @request_insert_blank_next_line = false
      end
      zenkaku_rstrip(line)
      if in_parameter_block?(line)
        write_fp.puts("［＃ここからパラメーター］")
        next
      elsif out_parameter_block?(line)
        write_fp.puts("［＃ここでパラメーター終わり］")
        next
      end
      conver_dash!(line)
      convert_shiten!(line)
      write_fp.puts(line)
      @before_line = line.dup
    end
    data = write_fp.string
    data.gsub!(/\n\n(［＃ここからパラメーター］)/m, "\n\\1")
    data.gsub!(/(［＃ここでパラメーター終わり］\n\n)/m, "［＃ここでパラメーター終わり］\n")
    data.gsub!("それぞれ、人の世界、人神。", "それぞれ、\n　人の世界、人神。")
    data.rstrip!
    write_fp
  end
end
