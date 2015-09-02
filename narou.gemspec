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

2.7.0 : 2015/08/23
------------------
#### 追加機能
- setting.ini に `enable_double_dash_to_image` を追加しました
	+ ２倍ダッシュ（――）を画像に差し替えます。細めに調整してあるので、Kindle の
	  デフォルトフォントの様にダッシュが太い環境でご使用ください(iBooksだと崩れる
	  ので使わない方が良いです)
	+ `narou init` が必要です
- `csv` コマンドを実装しました。管理している小説の情報をCSV形式で出力したり、
  インポートしたり出来ます。詳細は `narou csv -h` を参照して下さい
- 容量節約のための設定 `economy` を追加しました。変換後の作業ファイルの削除等を
  制御できます
	+ 設定は `narou s economy=設定値をカンマ区切り` or WEB UI の環境設定＞詳細
		- cleanup_temp : 変換後に作業ファイルを削除
		- send_delete : 送信後に書籍ファイルを削除
		- nosave_diff : 差分ファイルを保存しない
		- nosave_raw : rawデータを保存しない
- ネタバレ防止設定 `guard-spoiler` を追加しました。ダウンロード時に各話タイトル
  を伏せ字で表示します
	+ 設定は `narou s guard-spoiler=true` or WEB UI の環境設定＞詳細
- 処理の中断関係を強化しました
	+ update 中に中断した場合は以降の更新は全てキャンセルされるようになります
	+ 変換中に処理を中断した場合、次回の update コマンド実行時に再変換されます

#### WEB UI
- タグの色を変更出来るようにしました
- 「処理の中断」ボタンをコンソール右上に追加しました。現在処理しているものも
  含めて、全てのキューを破棄します
- 「個別＞差分を表示」で表示されるダイアログに「差分を消去」ボタンを追加しました
- リンクのドラッグ＆ドロップに対応しました。Downloadボタンを押すか「ツール＞D&D
  ウィンドウを開く」を実行して下さい
	+ 文章内リンク及びMacとWindowsのショートカットファイル(複数可)に対応
	+ IEにおいて、ドメイン間でリンクをD&Dするためには設定が必要です。
	  http://whiteleaf.hatenablog.com/entry/ie_dnd_setting を参照して下さい
- 「ツール＞CSV形式でリストをダウンロード」を追加しました
- 「ツール＞CSVファイルからインポート」を追加しました
- 新しいブックマークレット「DLボタンを設置」を追加しました。WEB UIのヘルプから
  取得できます
- 選択モードにハイブリッド選択モードを追加しました。クリックで選択、ドラッグで
  範囲選択が出来ます
- hotentry が有効な場合に Send ボタンに「hotentry を送信」を追加するようにしました
- ブックマークレットで表示されるウィンドウにキューアイコンを表示するように変更
- fix: FirefoxとIEで小説リスト上のタグ検索の解除ボタンを押した場合、ツールチップが
  消えない場合があったのを修正
- fix: IEでメニューのタグ一覧が自動で更新されていなかったのを修正
- fix: メニューが隠れた際にメニュー部分の背景色が消えていたのを修正
- fix: 差分表示で変更後の行が太字になっていないのを修正
- fix: リストが自動更新された際に範囲選択モードのままボタンが押せなかったのを修正

#### 仕様変更
- `tag` コマンドで対象小説を指定しなくてもタグの色を変更出来るようにしました
- 変換設定の `enable_auto_join_line` が有効な場合で、行末読点の次の行頭に全角
  スペースが２個以上ある場合は連結しないようにしました
- converter.rb 内から処理中の小説に関するデータを取得できるようにしました
	+ @subtitles: その小説の処理対象の情報(Hash)が入っている配列。hotentry 処理中
	  の場合は新規部分のみしか入っていない
	+ @current_index: 現在何話目を処理しているか(0から@subtitles.size-1まで)

#### BugFix
- Windowsにおいて日本語を含むフォルダで narou init しようとするとエラーが出て
  いたのを修正
- `update --gl` コマンドでエラーが起きる場合があったのを修正


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
  gem.add_runtime_dependency 'tilt', '~> 2.0', '>= 2.0.1'
  gem.add_runtime_dependency 'sass', '~> 3.4', '>= 3.4.18'
  gem.add_runtime_dependency 'haml', '~> 4.0', '>= 4.0.7'
  gem.add_runtime_dependency 'memoist', '~> 0.11.0'
  gem.add_runtime_dependency 'systemu', '~> 2.6', '>= 2.6.5'
end

