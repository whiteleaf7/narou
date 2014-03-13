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

2014/03/09 : **1.5.2**
* 追加機能もしくは仕様変更
	- **Cygwin** に対応しました（laplace22さんによる実装）
	- `narou mail` コマンドを追加しました
		+ 主にSend to Kindleを使うことを想定したコマンドです。送信用にメールアドレスが必要です
		+ 初めて `narou mail` コマンドを使った際に、自動で設定用ファイルが作成されます。そのファイルを
		  編集することで初めてコマンドが使えるようになります
	- setting.ini の `enable_transform_date` をデフォルトで false に変更（新規DLから反映）
* Bug Fix
	- ハーメルンで前書き後書きが正常に取得出来ない問題を修正
	- ハーメルンでダウンロード時にエラーが出る場合があった問題を修正 #43

2014/03/13 : **1.5.3**
* 追加機能もしくは仕様変更
	- 小説の最後に「（本を読み終わりました）」と表示されるようになりました
		+ setting.ini で `enable_display_end_of_book` を false 、もしくはコマンドで
		  `narou s force.enable_display_end_of_book=false` とすることで抑制出来ます
* Bug Fix
	- ◯つき数字などがまじると文字化けする可能性があった問題を修正

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
