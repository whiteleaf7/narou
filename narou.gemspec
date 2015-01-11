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

2.0.0 : 2014/12/26
------------------
#### 追加機能
- `web` コマンドを実装しました。ブラウザベースによるWEB UIを使うことが出来ます
	+ `narou web` でWEBサーバを起動し、自動的にブラウザが開きます
	+ ブラウザは可能な限り最新を推奨。IEは9以下は動きません
- `download.use-subdirectory` オプションが追加されました。小説IDの先頭数文字で
  サブフォルダを作成しグループ分けすることで、大量の小説を管理する場合のパフォ
  ーマンス劣化に対応します
	+ `narou s download.use-subdirectory=true` として設定出来ます
	+ すでに管理済みの小説の保存フォルダは変更されません
- ダウンロード時やアップデート時の最後に、容量不足等で書籍データを送信出来なか
  ったファイル一覧を表示するようにしました

#### 仕様変更
- 終了コードを整理しました
	+ 正常終了時：0
	+ 異常終了時：127
	+ updateコマンド及びdownloadコマンドで失敗した場合：失敗した小説の数
	+ settingコマンド：設定でエラーになった数
- 見出しリスト.txt を保存しなくなりました

#### Bug Fix
- 新規ダウンロードする際にエラーになる場合があったのを修正 #53
- 小説家になろうのルビ仕様に準拠していない書式があったのを修正

		｜が存在していなく、かつ《 》内に自動ルビ化対象文字以外がある場合に
		ルビ化はされない

- 上記修正に伴い、ログ・ホライズン（n8725k）の converter.rb を差し替えました
- Java がインストールされていない場合でも EPUB ファイルの作成が成功したと表示
  されてしまうのを修正 #55


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
end

