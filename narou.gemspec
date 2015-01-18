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

2.0.2 : 2015/01/16
------------------
#### 仕様変更
- 青空文庫形式のコメントの削除はWEB小説を変換する場合は無効にするように変更
- `web` コマンド実行時すでにサーバが立ち上がっていてもブラウザを開くように変更
- ダウンロード時に表示する節のタイトルを表示するタイミングを調整

#### Bug Fix
- WEB UI起動時には送信失敗リスト表示時に入力を求めないように修正
- ハーメルンの小説が非公開設定になるとエラーになるのを修正 #59
- `mail` コマンドで送信時にエラーが出る場合がある問題に対応


2.1.0 : 2015/01/19
------------------
#### 追加機能
- `convert.multi-device` オプションが追加されました
	+ `convert` コマンド使用時に複数のフォーマットへ同時に変換することが出来ます
	+ `narou s convert.multi-device=kindle,kobo,reader` のようにカンマ区切りで
	  設定します。この設定を有効にした場合、変換時に `device` 設定は無視されます
	+ `send` コマンド時には通常通り `device` の設定が使用されます
	+ 普通のEPUBが出力したい場合、端末名として `epub` を指定して下さい
- `update.logging` オプションが追加されました
	+ `update` コマンド使用時にログを保存するようになります
	+ `narou s update.logging=true` で設定出来ます
	+ ログはテキストファイルとして `log/` フォルダに保存されます(最新30件まで)。
	  また、 `narou u --log N` コマンドでも確認出来ます(N=1以上の整数)。
		Nを省略した場合は最新のログが表示されます。短縮する場合は `narou u -l N`
- `send.backup-bookmark` オプションが追加されました
	+ `send` コマンド使用時に端末の栞データを自動でバックアップします(KindlePW系
	  専用。他の端末も栞データの仕様が分かれば対応可能)
	+ `narou s send.backup-bookmark=true` で設定出来ます
	+ 一括送信時(`narou send` とだけコマンドを打った時)のみバックアップします
	+ 上記設定をせずに手動でバックアップする場合は `narou send --backup-bookmark`
	  もしくは `narou send -b` で行います
	+ バックアップした栞データを復元（端末にコピー）するには
	  `narou send --restore-bookmark` もしくは `narou send -r` で行います
- 変換設定に行頭字下げを強制的に行う `enable_force_indent` を追加しました
	+ enable_auto_indent は作者の意図的な字下げ無しを考慮して、全体的に字下げが
	  行われていない時にのみ字下げをするのに対して、今回のオプションは強制的に
	  字下げを行います。作者の字下げ忘れが多い場合に有効です
- WEB UI用ブックマークレットを実行した時にサーバがオフラインかどうか分かるよう
  になりました。ヘルプ画面からブックマークレットを更新して下さい

#### 仕様変更
- `convert.copy_to` を `convert.copy-to` へ変更しました(表記ゆれの統一の為)
	+ copy_to も後方互換維持のため残されますが、今後は非推奨になります
- `flag` コマンドが削除されました

#### Bug Fix
- WEB UI: リロードしても変換中のプログレスバーが表示されるように修正 #57

#### その他
- 将来的に対応バージョンを上げる予定なので、古いRuby（2.1.0未満）を使用している
  場合にお知らせを表示するようになりました。当面は1.9.3でも動くままですが、いま
  のうちにRuby2.1.0以上へのアップグレードをお願いします


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

