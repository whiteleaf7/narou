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

2014/02/26 : **1.4.4**
* 追加機能もしくは仕様変更
	- **短編小説** に対応しました
		+ `narou list` コマンドで短編小説にはタイトルの後ろに（短編）と付きます
	- `narou list` コマンドが拡張されました
		+ 一覧の表示を絞る `--filter` オプションを追加しました（短縮 -f）
			- `--filter` に続いて `series` （連載）、`ss` （短編）を指定出来ます
			- コマンド例： `narou list --filter series` 連載小説のみを表示する
			- コマンド例： `narou list -f ss -rl` 短編小説のみを更新の古い順に表示する
		+ 表示する項目を増やす `--type` オプションを追加しました（短縮 -t）
			- オプションを指定すると「種別」という項目が追加され、「連載」か「短編」かが表示されます
	- `narou remove` コマンドに全ての短編小説を削除する `--all-ss` オプションが追加されました
		+ ファイルも全て消すには通常通り `--with--file` オプションを同時に付ける必要があります
	- `narou download` コマンドにダウンロードが終わったあと削除する `--remove` オプションが追加されました（短縮 -r）
		+ 更新をチェックする必要があまりない短編小説などのためのオプションです
		+ 小説データフォルダ下にファイルは残っているので、ダウンロード時に送信まで行わなかった場合は、手動で
		  書籍データをコピーすることが出来ます。また、ファイルを消す場合も手動で削除する必要があります
* Bug Fix
	- 検索除外設定されている小説がダウンロード出来ない問題を修正

#{"*" * 79}
  EOS
  gem.post_install_message = install_message.gsub("\t", " ")

  gem.required_ruby_version = ">=1.9.3"

  gem.files         = `git ls-files`.split("\n") << Narou.create_git_commit_version
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.add_runtime_dependency 'termcolor', '~> 1.2', '>= 1.2.2'
  gem.add_runtime_dependency 'rubyzip', '~> 1.1', '>= 1.1.0'
end
