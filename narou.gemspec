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

2014/07/14 : **1.5.10**
* 追加機能もしくは仕様変更
	- `download` コマンドに対話モードを追加しました
		+ `narou d` と対象小説を指定せずに実行すると対話モードに移行します（-f 等のオプションは指定出来ます）
		+ 連続してNコードもしくはURLを入力できるモードです。ArcadiaのURLは " " で囲む必要がありません
		+ 想定される使い方：
			* 複数のURLを書いたテキストをコピペして流しこむ
			* テキストファイルからリダイレクトで入力する
				- `narou d < list.txt`
			* BATファイル等で `narou d` のみを実行し、新規DL時の入力を簡便にする
	- 自動生成される converter.rb に簡単な説明を付け加えるようにしました
	- remove コマンドの --with-file オプションに短縮版 -w を追加しました
	- `narou init` 実行時に現在の AozoraEpub3 の場所を表示するようになりました
	- `update` コマンドに新着小説のみを変換するオプション `--convert-only-new-arrival` (短縮 `-a` )が
	  追加されました（naoh87さんによる実装）
		+ もしこのオプションをデフォルトの挙動にしたければ、 `narou s default_args.update=-a` として下さい
	- 変換用のプリセットデータを追加
		+ デスマーチからはじまる異世界狂想曲(n9902bn)
		+ この世界がゲームだと俺だけが知っている(n9078bd)
		+ まのわ ～魔物倒す・能力奪う・私強くなる～(n3730bn)
	- すでに同梱されているプリセットデータを一部更新
		+ 異世界迷宮で奴隷ハーレムを(n4259s)
		+ ログ・ホライズン(n8725k)
* Bug Fix
	- replace.txt で置換対象を削除するという表現（あいう<tab><改行>）が出来なかったのを修正
	- `--time` オプションで表示される実行時間がより正確になるように調整しました

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
