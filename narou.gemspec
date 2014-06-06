# -*- mode: ruby -*-
# -*- coding: utf-8 -*-
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "version"

require "fileutils"

module Narou
  def self.create_git_commit_version
    File.write("commitversion", `git describe --always`.strip)
    "commitversion"
  end
end

at_exit do
  if File.exists?("commitversion")
    FileUtils.rm("commitversion")
  end
end

Encoding.default_external = Encoding::UTF_8

Gem::Specification.new do |gem|
  gem.name          = "narou"
  gem.version       = Version
  gem.license       = "MIT"
  gem.authors       = ["whiteleaf7"]
  gem.email         = ["2nd.leaf@gmail.com"]
  gem.homepage      = "http://whiteleaf.hatenablog.com/"
  gem.summary       = %q{Narou.rb ― 小説家になろうダウンローダ＆縦書用整形スクリプト}
  gem.description   = %q{
小説家になろうで公開されている小説の管理、及び電子書籍データへの
変換を支援します。縦書用に特化されており、横書き用に特化されたWEB小説
を違和感なく縦書で読むことが出来るようになります。
}.split("\n").join

  install_message = <<-EOS
#{"*" * 79}

narou コマンドのインストール or アップデートが完了しました。
詳しい説明は `narou help' コマンドをご覧下さい。

  NOTICE
  初めてこのアプリケーションを使う場合、小説管理用のフォルダを初期化する必要があります。
  任意のフォルダで `narou init' を実行して下さい。

2014/06/04 : **1.5.6**
* 追加機能もしくは仕様変更
	- 小説のタイトルに更新日をつける機能を追加しました
		+ `narou s force.enable_add_date_to_title=true` として設定して下さい（標準ではオフ）
		+ 書式は `title_date_format` 、位置は `title_date_align` で指定出来ます（詳細は setting.ini 参照）
	- `flag` コマンドを追加しました
		+ `narou flag end 10` と指定出来ます
		+ 現在は end（完結フラグ）のみ指定できます。`list` コマンド及び、小説タイトルに (完結) と表示されるようになります
	- 小説の管理フォルダ(narou initしたところ)に `device` フォルダをつくることで、 `send` コマンド用の設定ファイルを
	  独自に用意出来るようになりました。
		+ 設定ファイルは https://github.com/whiteleaf7/narou/tree/master/lib/device を参考に作成して下さい。
* Bug Fix
	- !?の一文字表記（0x2049）等でゴミが出てしまう問題を修正

2014/06/06 : **1.5.6.1**
* 追加機能もしくは仕様変更
	- タイトルにつく更新日の日付を新着があった日付に変更
* Bug Fix
	- 初期化時に `narou init` を実行できない問題を修正

#{"*" * 79}
  EOS
  gem.post_install_message = install_message.gsub("\t", " ")

  gem.required_ruby_version = ">=1.9.3"

  gem.files         = `git ls-files`.split("\n") << Narou.create_git_commit_version
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.add_runtime_dependency 'termcolor', '~> 1.2', '>= 1.2.2'
  gem.add_runtime_dependency 'rubyzip', '~> 1.1', '>= 1.1.0'
  gem.add_runtime_dependency 'pony', '~> 1.8'
end
