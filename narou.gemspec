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
  if File.exist?("commitversion")
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

2.4.0 : 2015/05/16
------------------
#### 追加機能
- WEB UI に保存フォルダを開くためのボタンを表示する項目「保存先」を追加しました
- WEB UI に項目「最新話掲載日」を追加しました
	+ 「小説家になろう」と「ハーメルン」のみ対応しています（updateした小説から
	  反映されていきます）。更新が無いと反映されないため、手動で反映させたい場合
	  はWEB UI サーバを落とした状態で `narou u --gl` コマンドを使用して下さい。
	  （基本的に一度実行するだけで十分です）

#### 仕様変更
- 小説リストの「新着」及び「更新」の表示基準を調整しました
- replace.txt による置換を行うタイミングを変更しました
	+ 今までは (before→本体処理→after)＊話数分→置換 という処理順だったものが、
	  (before→本体処理→after→置換)＊話数分 という処理順になりました

#### Bug Fix
- `enable_insert_word_separator` を有効にした場合に発生する以下の不具合を修正
	+ 開きカッコの禁則処理が Kindle で処理されなくなる
	+ replace.txt による置換が正常に行われない場合がある
	+ URLが含まれている文章の単語分割が正常に行われない
- あらすじだけ更新された場合にデータベースが更新されていなかった不具合を修正
- 小説サイトのサーバーがダウンしている時にエラーがでる問題を修正
- WEB UI の小説リストにおいて、更新・新着の表示期間が過ぎているにも関わらず、
  アップデート等をした際に消えない不具合を修正
- ハーメルンで非公開になっている小説をアップデートするとエラーになる不具合
  を修正

#{"*" * 79}
  EOS
  gem.post_install_message = install_message.gsub("\t", "  ")

  gem.required_ruby_version = ">=1.9.3"

  gem.files         = `git ls-files`.split("\n") << Narou.create_git_commit_version
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.add_runtime_dependency 'termcolorlight', '~> 1.0', '>= 1.1.1'
  gem.add_runtime_dependency 'rubyzip', '~> 1.1', '>= 1.1.0'
  gem.add_runtime_dependency 'mail', '2.5.4'
  gem.add_runtime_dependency 'pony', '~> 1.8'
  gem.add_runtime_dependency 'diff-lcs', '~> 1.2', '>= 1.2.5'
  gem.add_runtime_dependency 'sinatra', '~> 1.4', '>= 1.4.5'
  gem.add_runtime_dependency 'sinatra-contrib', '~> 1.4', '>= 1.4.2'
  gem.add_runtime_dependency 'sass', '~> 3.4', '>= 3.4.4'
  gem.add_runtime_dependency 'haml', '~> 4.0', '>= 4.0.5'
  gem.add_runtime_dependency 'memoist', '~> 0.11.0'
end

