Narou.rb ― 「小説家になろう」「小説を読もう！」ダウンローダ＆縦書用整形スクリプト
============================================================

概要 - Summary
--------------
このアプリは[小説家になろう](http://syosetu.com/)、[小説を読もう！](http://yomou.syosetu.com/)で公開されている小説の管理、
及び電子書籍データへの変換を支援します。縦書き用に特化されており、
横書き用に特化されたWEB小説を違和感なく縦書きで読むことが出来るようになります。
また、校正機能もありますので、小説としての一般的な整形ルールに矯正します。（例：感嘆符のあとにはスペースが必ずくる）

[ノクターンノベルズ](http://noc.syosetu.com/)及び[ムーンライトノベルズ](http://mnlt.syosetu.com/)にも対応しています。

**NEW!!**
[ハーメルン](http://syosetu.org/)、[Arcadia](http://www.mai-net.net/)（理想郷）、[暁](http://www.akatsuki-novels.com/)にも対応しました！

全てコンソールで操作するCUIアプリケーションです。

主な機能は小説家になろうの小説のダウンロード、更新管理、テキスト整形、AozoraEpub3・kindlegen連携によるEPUB/MOBI出力です。

詳細な説明やインストール方法は **[Narou.rb 説明書](https://github.com/whiteleaf7/narou/wiki)** を御覧ください。

![ScreenCapture](https://raw.github.com/wiki/whiteleaf7/narou/images/narou_cap.gif)

更新履歴 - ChangeLog
--------------------

2014/06/14 : **1.5.7**
* 追加機能もしくは仕様変更
	- 小説家になろうにおいて、10話ごとにかけていたウェイトを削除
* Bug Fix
	- &#39; (') のエンティティ変換を追加

2014/06/06 : **1.5.6.1**
* 追加機能もしくは仕様変更
	- タイトルにつく更新日の日付を新着があった日付に変更
* Bug Fix
	- 初期化時に `narou init` を実行できない問題を修正

2014/06/04 : **1.5.6**
* 追加機能もしくは仕様変更
	- 小説のタイトルに更新日をつける機能を追加しました
		+ `narou s force.enable_add_date_to_title=true` として有効にして下さい（標準ではオフ）
		+ 書式は `title_date_format` 、位置は `title_date_align` で自由に変更出来ます
			* title_date_format: 付与する日付のフォーマット。書式は http://bit.ly/1m5e3w7 を参照
			* title_date_align: 付与する日付の位置。left か right
			* `narou s force.title_date_format="(%-m/%-d)"`
			* `narou s force.title_date_align=left`
	- `flag` コマンドを追加しました
		+ `narou flag end 10` と指定出来ます
		+ 現在は end（完結フラグ）のみ指定できます。`list` コマンド及び、小説タイトルに (完結) と表示されるようになります
		 （小説タイトルについては次の変換から反映）
	- 小説の管理フォルダ(narou initしたところ)に `device` フォルダをつくることで、 `send` コマンド用の設定ファイルを
	  独自に用意出来るようになりました
		+ 設定ファイルは https://github.com/whiteleaf7/narou/tree/master/lib/device を参考に作成して下さい
* Bug Fix
	- !?の一文字表記（0x2049）等でゴミが出てしまう問題を修正

2014/05/15 : **1.5.5.1**
* Bug Fix
	- 暁の小説で一部正常にDLできないものがあったので修正

2014/05/15 : **1.5.5**
* 追加機能もしくは仕様変更
	- 小説投稿サイト **[暁](http://www.akatsuki-novels.com/)** に対応しました
* Bug Fix
	- タイトルに " が含まれている場合に正常に変換できない問題を修正

2014/03/21 : **1.5.4**
* 重要な修正
	- 小説家になろうの仕様変更で更新できなくなっていたのを修正しました

2014/03/13 : **1.5.3**
* 追加機能もしくは仕様変更
	- 小説の最後に「（本を読み終わりました）」と表示されるようになりました
		+ setting.ini で `enable_display_end_of_book` を false 、もしくはコマンドで
		  `narou s force.enable_display_end_of_book=false` とすることで抑制出来ます
* Bug Fix
	- ◯つき数字などがまじると文字化けする可能性があった問題を修正

2014/03/09 : **1.5.2.1**
* Bug Fix
	- 1.5.2 で発生する新規小説DL時のエラーを修正

----

「小説家になろう」は株式会社ヒナプロジェクトの登録商標です
