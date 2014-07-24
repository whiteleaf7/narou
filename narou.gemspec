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

2014/07/24 : **1.5.11**
* 追加機能もしくは仕様変更
	- 改稿の更新漏れ対策として、 `update.strong` オプションが追加されました
		+ `narou s update.strong=true` として設定して下さい
		+ 改稿日の更新は必ずダウンロードされるようになります（当日はアップデートする度にDLします）。
		  何度も改稿された小説では、更新のタイミングによっては改稿内容を取りこぼす可能性があるため、
		  このオプションを有効にすることで必ず拾えるようにします
		+ ファイルのタイムスタンプをチェックするので、更新動作が多少遅くなります
	- 指定の話数ごとにウェイトを入れられる `download.wait-steps` オプションが追加されました
		+ `narou s download.wait-steps=10` として設定して下さい
		+ 小説家になろうの場合は11話以上を指定しても10話ごとにウェイトが入ります
	- `backup` コマンドを追加しました
		+ 使用例： `narou backup 0` 、 `narou ba 0`
		+ 小説保存フォルダ直下の backup フォルダに、バックアップ以外の全てのファイルをZIPで固めて保存します
	- ダイジェスト化検出時の処理項目に「バックアップの作成」と「保存フォルダを開く」を追加しました
* Bug Fix
	- まのわ(n3730bn)のプリセット変換スクリプトの挙動を調整
	- 暁で一部あらすじが正常に取れていない小説があったので修正

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
