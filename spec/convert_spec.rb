# -*- Encoding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#
# auto generated at 2014-08-27 01:09:07 +0900

require "termcolor"
require_relative "../lib/commandline"
require_relative "../lib/logger"

AUTHOR = "whiteleaf"
$debug = File.exists?(File.expand_path(File.join(File.dirname(__FILE__), "../debug")))

describe "convert" do
  before :all do
    test_text_dir = File.join(File.dirname(__FILE__), "data/convert_test")
    @pwd = Dir.pwd
    Dir.chdir(test_text_dir)
  end

  after :all do
    # 変換した際に出力される各ファイルを削除
    unless $debug
      Dir.glob("*/\\[#{AUTHOR}\\]*.txt\0*/{見出しリスト,調査ログ}.txt") do |path|
        File.delete(path)
      end
    end
    Dir.chdir(@pwd)
  end

  def load_file(path)
    # 行末の空白と改行の違いは無視する
    File.read(path).gsub("\r", "").rstrip
  end

  def check_answer(path)
    dir = File.dirname(path)
    filename = File.basename(path)
    $stdout.silence do
      CommandLine.run(["convert", path, "--no-epub", "--no-open", "--ignore-force"])
    end
    output_file = File.join(dir, "[#{AUTHOR}] #{filename}")
    correct_file = File.join(dir, "correct_#{filename}")
    expect(load_file(output_file)).to eq load_file(correct_file)
  end

  it "auto_indent/test_auto_indent.txt" do
    check_answer("auto_indent/test_auto_indent.txt")
  end

  it "auto_join_bracket/test_auto_join_bracket.txt" do
    check_answer("auto_join_bracket/test_auto_join_bracket.txt")
  end

  it "auto_join_line/test_auto_join_line.txt" do
    check_answer("auto_join_line/test_auto_join_line.txt")
  end

  it "convert_page_break/test_convert_page_break.txt" do
    check_answer("convert_page_break/test_convert_page_break.txt")
  end

  it "force_indent_special_chapter/test_force_indent_special_chapter.txt" do
    check_answer("force_indent_special_chapter/test_force_indent_special_chapter.txt")
  end

  it "horizontal_ellipsis/test_horizontal_ellipsis.txt" do
    check_answer("horizontal_ellipsis/test_horizontal_ellipsis.txt")
  end

  it "kanji_num/test_kanji_num.txt" do
    check_answer("kanji_num/test_kanji_num.txt")
  end

  it "nonokagi/test_nonokagi.txt" do
    check_answer("nonokagi/test_nonokagi.txt")
  end
end
