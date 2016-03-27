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
#{"*" * 60}

2.9.0 : 2016/03/28
------------------
#### WEB UI
- メニュー(歯車アイコン)に「サーバを再起動」を追加しました。WEB UIから直接WEB
  UIサーバを再起動できるようになります
- 「Narou.rbについて」ダイアログで最新バージョンを確認できた場合に、その場で
  システムの更新及び再起動が出来るようになりました。
  （sudo が必要な環境の場合はコマンドで更新して下さい）
- 小説リスト部分で右クリックすることで個別メニューを呼び出せるようになりました
- 各小説をそれぞれ個別に更新出来るボタンを追加しました
- 「表示」メニューを拡張しました
	+ 「変換設定ページは新規タブで開く」を追加しました
	+ 「ボタンを画面下部に固定」を追加しました
	+ 「個別メニューを編集」を追加しました
- 「ツール」に「メモ帳」を追加しました
	+ メモはサーバに保存され、各PC間で共有出来ます。個別メニューの編集内容の
	  受渡しや小説URLの一時的プールなどに使うことを想定しています
- タグ検索をフィルターに統合しました
	+ フィルター欄に `tag:タグ名` と入力することでタグ検索が可能になります。
	  （既存のキーワード検索との併用も可能です）
	+ `tag:タグ名1 tag:タグ名2` と複数入力することで、複数のタグでの絞り込みが
	  可能です
	+ `-tag:タグ名` と `-` を付けることで、除外タグ検索になります
	+ メニューのタグか小説リストのタグ名をクリックすることで、フィルター欄に自動
	  で入力されます。また、Altキーを押しながらクリックすることで、除外タグが入力
	  されます
- タグの並び順をソートするようにしました
- 一部のボタンのアイコンを変更しました
- ツールチップを表示してしばらくしたら自動で閉じるようにしました
- 表示件数に200、500を追加しました
- 電子書籍端末を接続時に、取り外すための Eject ボタンを表示するようにしました
  （現時点でMacのみサポート）

#### 追加機能
- [カクヨム](https://kakuyomu.jp/)に対応しました
	+ 各話の更新状況を（目次ページから）取得する方法が現時点で無いので、新着のみ
	  取得出来ます（各話を最新の状態にしたい場合は、強制ダウンロードをする必要が
	  あります）
- `narou setting 変数名` コマンドで現在の設定値を確認出来るようになりました。
  (例 `narou s device`)
- `list` コマンドに `--gl` オプションが追加されました
	+ 表示・ソート対象の日付を更新日から最新話掲載日に切り替えます
	+ general-lastup の略です
- 変換プリセットを追加しました
	- n5115cq 最果てのパラディン
	- n7594ct 10年ごしの引きニートを辞めて外出したら自宅ごと異世界に転移してた

#### 仕様変更
- 変換処理で body や introduction 等を処理して最後に subtitle を変換していた
  のを先に subtitle を処理するように変更しました
	- converter.rb でサブタイトルで本文の処理内容を調整したい場合に今までの処理順
	  では不可能だったため
- title_date_format の $s が古い作品だと5桁になってしまうのを4桁に収まるように
  調整しました（小説家になろうの最も古い作品が4桁に収まるようにしました）
- `あ゛` のような記述を濁点フォントに置き換える処理を廃止し、AozoraEpub3 による
  一文字フォント置き換え機能に任せるようにしました
	+ `narou init` が必要です
	+ この変更に伴い、setting.ini の enable_dakuten_font は廃止されました
	+ Kindle 端末において、挿絵が表紙画像になってしまう問題がこの仕様変更で改善
	  されます

#### 修正
- httpsなサイトでダウンロード用のブックマークレットが動かない問題に対応しました
  （ヘルプからブックマークレットの再取得が必要です）
- Windows において、WEB UI の「Narou.rbについて」ダイアログで最新バージョンの
  確認に失敗する場合がある問題に対応しました
- WEB UI の小説リストの項目を入れ替えた後に各種ボタンが反応しなくなるのを修正
- 凍結済み小説を強制更新した際に凍結が解除されてしまう場合があったのを修正
- thin などがすでにインストール済みの場合に narou web コマンドで WEB UI サーバ
  を起動できない場合があるので、必ず WEBrick で起動するようにしました
- ノクターン・ムーンライト・ミッドナイトノベルズの認証方法変更後、Nコードのみで
  ダウンロードが出来なくなっていたのを修正
- Linux でダウンロード時にエラーが出る場合があったのを修正
- その他パフォーマンス等の調整

#{"*" * 60}
  EOS
  gem.post_install_message = install_message.gsub("\t", "  ")

  gem.required_ruby_version = ">=2.1.0"

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
  gem.add_runtime_dependency 'tilt', '~> 2.0', '>= 2.0.1'
  gem.add_runtime_dependency 'sass', '~> 3.4', '>= 3.4.18'
  gem.add_runtime_dependency 'haml', '~> 4.0', '>= 4.0.7'
  gem.add_runtime_dependency 'memoist', '~> 0.11.0'
  gem.add_runtime_dependency 'systemu', '~> 2.6', '>= 2.6.5'
  gem.add_runtime_dependency 'erubis', '~> 2.7'
  gem.add_runtime_dependency 'open_uri_redirections', '~> 0.2', '>= 0.2.1'
end

