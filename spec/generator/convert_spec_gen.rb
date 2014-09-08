# -*- Encoding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

# convert コマンドのテストを自動生成する
#
# spec/data/convert_test/ 以下に各種テストケースごとにフォルダ分けして、
# その中に test_HOGE.txt を用意すると認識する。
# そのテストケースごとにreplace.txtやsetting.iniも置ける。
# テキストのタイトルは(拡張子を除いた)ファイル名と同じでなければならない。
# 想定する出力例は correct_test_HOGE.txt に書く。

require "erb"

spec_dir = File.expand_path(File.join(File.dirname(__FILE__), ".."))
recipe_dir = File.join(spec_dir, "data/convert_test")
pwd = Dir.pwd
Dir.chdir(recipe_dir)
# テストファイルのリストを作成
convert_test_text_list = Dir.glob(File.join("*", "test_*.txt")).keep_if { |path|
  dir = File.dirname(path)
  basename = File.basename(path)
  unless File.exist?(File.join(dir, "correct_#{basename}"))
    puts <<-EOS
[Warning]
テストケース(#{path})は見つかりましたが、出力例のテキストデータが見つかりません。
correct_#{basename} を用意して下さい。

    EOS
  end
  true
}
Dir.chdir(pwd)
result = ERB.new(DATA.read, nil, "-").result(binding)
output_path = File.join(spec_dir, "convert_spec.rb")
File.write(output_path, result)
puts "#{output_path} を出力しました"

__END__
# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#
# auto generated at <%= Time.now %>

Encoding.default_external = Encoding::UTF_8

require "termcolor"
require_relative "../lib/commandline"
require_relative "../lib/logger"

AUTHOR = "whiteleaf"
$debug = File.exist?(File.expand_path(File.join(File.dirname(__FILE__), "../debug")))

describe "convert" do
  before :all do
    test_text_dir = File.join(File.dirname(__FILE__), "data/convert_test")
    @pwd = Dir.pwd
    Dir.chdir(test_text_dir)
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
      CommandLine.run(["convert", path, "--no-epub", "--no-open", "--ignore-force"])
    end
    output_file = File.join(dir, "[#{AUTHOR}] #{filename}")
    correct_file = File.join(dir, "correct_#{filename}")
    expect(load_file(output_file)).to eq load_file(correct_file)
  end
<% convert_test_text_list.each do |path| %>
  it "<%= path %>" do
    check_answer("<%= path %>")
  end
<% end -%>
end
