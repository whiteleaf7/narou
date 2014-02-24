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

2014/02/24 : **1.4.3**
* 追加機能もしくは仕様変更
	- **i文庫** に対応しました。専用のzipアーカイブを生成出来るようになります（txtと表紙、挿絵をzipで固めたもの）
		+ `narou s device=ibunko` で切り替えることが出来ます
		+ Drobbox等と連携をするために、 `narou s convert.copy_to=フォルダのパス` を設定することで、
		  zipファイルがコピーされるようになります
		+ i文庫専用レイアウトテンプレート、ibunko_novel.txt.erb が追加されました
		+ `narou convert` コマンドに `--no-zip` オプションが追加されました
	- `setting.ini` に濁点フォントの埋め込みを制御できる `enable_dakuten_font` が追加されました
	- あらすじ及び章も変換処理を施すように変更しました
		+ `converter#before` 及び `after` メソッドの text_type に、 `story` `chapter` が渡されるようになりました
* Bug Fix
	- Windowsにおいて、タイトル及び作者名にCP392外の文字が使われていた場合に変換がエラーになる問題を修正
	- 章タイトルが※で終わる小説をEPUB変換時に警告が出ていたのを修正

2014/02/20 : **1.4.0**
* 重要な修正
	- 小説家になろうのレイアウト変更によって更新処理ができなくなっていたものを修正しました

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
