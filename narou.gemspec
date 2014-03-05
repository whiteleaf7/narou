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

2014/03/06 : **1.5.0**
* 追加機能もしくは仕様変更
	- 小説投稿サイト ハーメルン (http://syosetu.org/) に対応しました
	- 小説投稿サイト Arcadia (http://www.mai-net.net/) に対応しました
		+ Arcadiaは `narou d "http://www.mai-net.net/bbs/sst/sst.php?～略～&n=0&count=1"` のように
		  URLを " で囲まないとコマンドがきちんと通りませんのでご注意下さい
	- このバージョン以降ダウンロードした小説の保存フォルダ名には、タイトルの前にIDが付加されるようになりました
	- アラビア数字を漢数字に変換しないパターンを追加（％や単位系）
	- `setting.ini` の項目、 `enable_narou_illust` が `enable_illust` に変更になりました
* Bug Fix
	- `narou browser --vote` コマンドがなろうのレイアウト変更に対応していなかったので修正
	- 半角カナを全角カナに変換するように修正 #36
	- 小説のタイトルにはルビをふれないように修正 #37

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
