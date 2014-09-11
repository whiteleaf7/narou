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

1.6.0 : 2014/08/28
------------------
#### 追加機能
- **iBooks** での管理に対応しました
	+ Mac OS X Mavericks以上が対象です
	+ `narou s device=ibooks` で変更できます
	+ 初回登録時はiBooksでEPUBファイルを開くので、ウィンドウが大量に開くことに
	  ご注意ください。次回以降はiBooksの管理フォルダを直接更新してウィンドウが
	  開くことはありません
- **JRuby** での実行に対応しました（Windowsでは環境変数JAVA_OPTSに
  -Dfile.encoding=UTF8を設定して下さい）
- `diff` コマンドで外部ツールがなくても更新された部分の差分を表示できるように
  なりました
	+ `difftool` が設定されていない場合、独自の差分表示処理を行います。
	  小説用なので一文字単位の修正がわかりやすいように調整してあります

	  ![diff使用時のイメージ](https://raw.github.com/wiki/whiteleaf7/narou/images/diff_cap.png)
- `tag` コマンドが追加されました
	+ 小説に自由にタグを付けることができ、絞り込み等で使用出来ます
		+ タグを追加: `narou tag -a akatsuki 0`
		+ タグが付いた小説を表示: `narou tag akatsuki`
		+ コマンドの対象小説をタグで指定: `narou update akatsuki`
		+ その他詳細な説明は `narou tag -h` を参照して下さい
- `list` コマンドが拡張されます
	+ `--site` オプション(短縮: -s)が追加されました。掲載小説サイト名を合わせて
	  表示します
	+ `--author` オプション(短縮:-a)が追加されました。作者名を合わせて表示します
	+ `--tag` オプション(短縮: -t)が追加されました。タグで小説を検索出来ます
		* `narou l -t tagname` 、 `narou l -t "tag1 tag2"`
		* `narou l -t` と引数を省略すると全ての小説をタグつきで表示
	+ `--grep` オプション(短縮: -g)が追加されました。リストの中から指定された
	  文字列で検索します。最終的に表示される内容から検索するため、作者名やサイト
	  名等そのままでは表示されない要素から検索したい場合、それぞれを表示するオプ
	  ションも合わせて指定して下さい
		* 例1： リストから作者名に“紫炎”が含まれる小説を探したい場合
			- `narou list --author --grep 紫炎` 或いは `narou l -ag 紫炎`
		* 例2: 小説家になろう以外の小説を表示したい場合
			- `narou list --site --grep "-小説家になろう"` 或いは
			  `narou l -sg "-小説家になろう"` (-をつけることでNOT検索)
		* 例3: ハーメルンの小説からSAOを含む小説を探す
			- `narou l -sg "ハーメルン SAO"` (スペース区切りによるAND検索)
	+ listコマンドの結果をパイプで他のコマンドに接続できるようになりました
		* 例1: ハーメルに掲載されている小説にhamelnタグを付けたい
			- `narou l -sg ハーメルン | narou t -a hameln`
		* 例2: 短編を全て凍結したい
			- `narou l -f ss | narou freeze --on`
		* 注意点として、パイプでつないだ場合は remove コマンドは確認メッセージを
		  出さずに削除します
- `convert` コマンドに `--ignore-force` オプションが追加されました。
  `narou s force.設定名=値` として強制上書きされる設定を一時的に無効にします
- 空改行の削除処理を制御する `enable_pack_blank_line` オプションが追加されました
	+ デフォルトでは有効です。無効にするには各小説の setting.ini に
	  `enable_pack_blank_line=false` を追加するか、
	  `narou s force.enable_pack_blank_line=false` を実行して下さい
- `freeze` コマンドに強制凍結及び解除する `--on` 及び `--off` オプションが追加
  されました

#### 仕様変更
- `update.strong` の挙動を、「当日分は必ずDLする」から「当日分は内容を見て更新
  されているか確認する」に変更しました。またタイムスタンプを記録するようにし、
  アップデート時のパフォーマンスを向上させました
- デバイス設定時に最低限必要な関連項目を設定変更するようになりました
- 空改行の間引き具合を若干弱くしました
- `list` コマンドの `--type` オプションを `--kind` (短縮:-k)に変更しました
- 差分オブジェクトの書式を `20YY.MM.DD@hh;mm;ss` から `20YY.MM.DD@hh.mm.ss` に
  変更します
	+ このバージョンから反映。以前のバージョンで作成された差分は旧書式のままです
- 新着のみの更新の場合差分データを作成しないように変更しました
- `backup` コマンドで作成するZIPファイルの内部ファイルパス文字エンコーディング
  をOS毎に変更するようにしました
	+ Windows = Windows-31J、その他OS = UTF-8
- `flag` コマンドは非推奨になり、tagコマンドに統一されます。今後完結フラグを立
  てる場合、 `narou tag -a end 0` として下さい。flagコマンドは1.7.0で廃止される
	予定です
	+ flagデータをtagデータに移行する場合は `narou flag --convert-tag` を実行
	  して下さい
- 完結の情報を自動で付与するようになりました。完結を検知したら end タグを追加
  します
	+ 現在は小説家になろう関連サイトとハーメルンのみ自動検知します
- 選択肢を選ぶときエンターを押す必要がなくなりました
- このバージョンからセマンティックバージョニングに移行します
	+ Major.Minor.Teen という形式で、特別なアップデートでMajor、追加機能を含む
	  アップデートでMinor、バグ修正のみのアップデートでTeenの番号を増やします

#### Bug Fix
- 小説が掲載サイトから削除されていない時(500や503)にも自動凍結していたのを修正
- iBooksで閲覧時章タイトルページのレイアウトが崩れていたのを修正
- iBooksで閲覧時Arcadiaの掲載アドレスがあるページでエラーがでていたのを修正 #47
- ハーメルンで作者名が正常に取得できない場合があったのを修正 #48
- ハーメルンで連載形式の短編が1話目しか取得できていなかったのを修正 #49
- 自動字下げの判定処理が正常に動作していなかったのを修正
- `diff` コマンドの差分表示時に更新日が挿入されない場合があったのを修正
- `diff` コマンドで小説家になろう以外の小説の差分がHTMLタグ付きのまま表示されて
  いたのを修正
- 未対応のURLを入力した場合にエラーが出るようになっていたのを修正
- 小説家になろうの短編のあらすじで改行が無視されていたのを修正
- 小説家になろうの短編のあらすじで先頭に縦棒（｜）が入ってしまう問題に対応 #46
- 小説家になろうの挿絵を認識出来ない場合があったのを修正
- 前書き・後書き内にある挿絵を単ページ化出来なかったのを修正 #8
- 漢数字変換で対応桁数以上を変換しようとしてクラッシュしていたのを修正
- その他ヘルプ文の訂正や無駄な処理削減等多数の細かい調整

1.6.1 : 2014/09/05
------------------
#### Bug Fix
- Ruby1.9.3において `tag` コマンドが使用出来ない問題を修正
- flag データを設定し、その後削除した場合に flag --convert-tag コマンドがクラッシュする問題を修正

1.6.2 : 2014/09/08
------------------
#### 仕様変更
- あらすじだけ変更された場合も更新とみなすようになりました

#### Bug Fix
- `download.wait-steps` でウェイトを入れるタイミングがおかしくなっていたため、
  503エラーが頻発するようになっていたのを修正
- 完結しているにもかかわらず完結タグが付与されない場合があったのを修正。また、
  完結していた小説が連載を再開した場合、完結タグを削除するようになりました
- 話数が減っているにも関わらずダイジェスト化検知出来ない場合があったのを修正

1.6.3 : 2014/09/11
------------------
#### Bug Fix
- ハーメルン、Arcadiaにおいて小説が削除されている場合にエラーが出ていたのを修正
- １話も投稿されていない小説でエラーが出ていたのを修正


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
  gem.add_runtime_dependency 'termcolor', '~> 1.2', '>= 1.2.2'
  gem.add_runtime_dependency 'rubyzip', '~> 1.1', '>= 1.1.0'
  gem.add_runtime_dependency 'pony', '~> 1.8'
  gem.add_runtime_dependency 'diff-lcs', '~> 1.2', '>= 1.2.5'
end
