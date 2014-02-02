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

  gem.post_install_message = <<-EOS
#{"*" * 79}

narou コマンドのインストール or アップデートが完了しました。
詳しい説明は `narou help' コマンドをご覧下さい。

  NOTICE
  初めてこのアプリケーションを使う場合、小説管理用のフォルダを初期化する必要があります。
  任意のフォルダで `narou init' を実行して下さい。

更新内容
2014/02/03 : **1.3.5**
* Bug Fix
	- 小説を削除したあと再度ダウンロードしようとした場合にエラーが出ていたのを修正
	- タイトル名の末端に半角スペースがある小説が正常にダウンロード出来ない問題を修正
* 追加機能もしくは仕様変更
	- 小説変換プリセットに n2525bs (魔剣ゾルディの女主人公とっかえひっかえ成長記録) 追加
	- ダウンロードが完了した時に同時に凍結させるオプションを追加
		+ `download` コマンドに `--freeze` (短縮名 -z) オプションが追加されました
			* コマンド例： `narou download --freeze n4029bs`
			* コマンド例： `narou d n4029bs -z`
	- Mac上での動作改善コードの取り込み（https://github.com/yossoy/narou）
		+ java の動作不良対応、Kindle 対応

#{"*" * 79}
  EOS

  gem.required_ruby_version = ">=1.9.3"

  gem.files         = `git ls-files`.split("\n") << Narou.create_git_commit_version
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.add_dependency "termcolor", ">=1.2.2"
end
