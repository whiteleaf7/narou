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

2.3.1 : 2015/03/24
------------------
#### Bug Fix
- `enable_insert_word_separator` の動作が単語単位ではなく文字単位で選択になって
  しまっていたのを修正
	- 文字単位での選択は `enable_insert_char_separator` という設定で出来るように
	  しました

2.3.0 : 2015/03/21
------------------
#### 追加機能
- Kindle端末で単語の選択を出来るようにするために、小説別変換設定に
  `enable_insert_word_separator` オプションが追加されました
	+ このオプションを使うためには `narou init` を実行して AozoraEpub3 の設定を
	  修正する必要があります
	+ 各小説の setting.ini 内に `enable_insert_word_separator=true` と追加で書き
	  込むか、 `narou s force.enable_insert_word_separator=true` とコマンドを打ち
	  込むことで有効に出来ます。（WEB UI で設定すると楽です）
	+ このオプションは、Kindle端末で単語が選択出来ない問題に対応するものです。
	  device が kindle の時のみ使用可能です。また、Send to Kindle で mobi を azw3
	  に変換する場合は単語選択は可能なので、設定する必要はありません

#### Bug Fix
- ハーメルンの仕様変更に対応しました


narou コマンドのインストール or アップデートが完了しました。
詳しい説明は `narou help' コマンドをご覧下さい。

  NOTICE
  初めてこのアプリケーションを使う場合、小説管理用のフォルダを初期化する必要があります。
  任意のフォルダで `narou init' を実行して下さい。

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

