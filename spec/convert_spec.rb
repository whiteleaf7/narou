# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#
# auto generated at 2018-05-16 15:45:40 +0900

Encoding.default_external = Encoding::UTF_8

require_relative "../lib/commandline"
require_relative "../lib/narou_logger"

AUTHOR = "whiteleaf"
$debug = File.exist?(File.expand_path(File.join(File.dirname(__FILE__), "../debug")))

describe "convert" do
  before :all do
    test_text_dir = File.join(File.dirname(__FILE__), "data/convert_test")
    @pwd = Dir.pwd
    Dir.chdir(test_text_dir)

    Inventory.load("local_setting")["convert.filename-to-ncode"] = false
  end

  after :all do
    # 変換した際に出力される各ファイルを削除
    unless $debug
      glob_path = "*/\\[#{AUTHOR}\\]*.txt\0*/{見出しリスト,調査ログ}.txt"
      glob_path.encode!("Windows-31J") if RbConfig::CONFIG["host_os"] =~ /mswin(?!ce)|mingw|bccwin/i
      Dir.glob(glob_path) do |path|
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
      CommandLine.run(["convert", path, "--no-epub", "--no-open", "--ignore-force", "--ignore-default"])
    end
    output_file = File.join(dir, "[#{AUTHOR}] #{filename}")
    correct_file = File.join(dir, "correct_#{filename}")
    expect(load_file(output_file)).to eq load_file(correct_file)
  end

  it "kanji_num/test_kanji_num.txt" do
    check_answer("kanji_num/test_kanji_num.txt")
  end

  it "nonokagi/test_nonokagi.txt" do
    check_answer("nonokagi/test_nonokagi.txt")
  end

  it "auto_join_bracket/test_auto_join_bracket.txt" do
    check_answer("auto_join_bracket/test_auto_join_bracket.txt")
  end

  it "force_indent_special_chapter/test_force_indent_special_chapter.txt" do
    check_answer("force_indent_special_chapter/test_force_indent_special_chapter.txt")
  end

  it "convert_page_break/test_convert_page_break.txt" do
    check_answer("convert_page_break/test_convert_page_break.txt")
  end

  it "to_odd_leader/test_to_odd_leader.txt" do
    check_answer("to_odd_leader/test_to_odd_leader.txt")
  end

  it "insert_separator_and_replace_txt/test_insert_separator_and_replace_txt.txt" do
    check_answer("insert_separator_and_replace_txt/test_insert_separator_and_replace_txt.txt")
  end

  it "auto_indent/test_auto_indent.txt" do
    check_answer("auto_indent/test_auto_indent.txt")
  end

  it "english/test_english.txt" do
    check_answer("english/test_english.txt")
  end

  it "auto_join_line/test_auto_join_line.txt" do
    check_answer("auto_join_line/test_auto_join_line.txt")
  end

  it "horizontal_ellipsis/test_horizontal_ellipsis.txt" do
    check_answer("horizontal_ellipsis/test_horizontal_ellipsis.txt")
  end

  it "ruby_youon/test_ruby_youon.txt" do
    check_answer("ruby_youon/test_ruby_youon.txt")
  end

  it "convert_numbers/test_convert_numbers.txt" do
    check_answer("convert_numbers/test_convert_numbers.txt")
  end

  it "rome_num/test_rome_num.txt" do
    check_answer("rome_num/test_rome_num.txt")
  end

  it "replace/test_replace.txt" do
    check_answer("replace/test_replace.txt")
  end

  it "sesame/test_sesame.txt" do
    check_answer("sesame/test_sesame.txt")
  end

  it "ruby/test_ruby.txt" do
    check_answer("ruby/test_ruby.txt")
  end

  it "insert_separator/test_insert_separator.txt" do
    check_answer("insert_separator/test_insert_separator.txt")
  end
end
