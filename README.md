Narou.rb ― 「小説家になろう」「小説を読もう！」ダウンローダ＆縦書用整形スクリプト
============================================================

[![Gem Version](https://badge.fury.io/rb/narou.svg)](http://badge.fury.io/rb/narou)

お知らせ
--------
	Narou.rb の動作環境において、Ruby 2.0.0 でのサポートは2015年8月31日で打ち切ります。
	すでに Ruby 2.0.0 はセキュリティフィックスのみ提供されており、保守は2016年2月24日に終了すると予告されています。
	Ruby 2.1.0 以上へのバージョンアップをお願いします


概要 - Summary
--------------
このアプリは[小説家になろう](http://syosetu.com/)、[小説を読もう！](http://yomou.syosetu.com/)で公開されている小説の管理、
及び電子書籍データへの変換を支援します。縦書き用に特化されており、
横書き用に特化されたWEB小説を違和感なく縦書きで読むことが出来るようになります。
また、校正機能もありますので、小説としての一般的な整形ルールに矯正します。（例：感嘆符のあとにはスペースが必ずくる）

対応小説サイト：
+ 小説家になろう（小説を読もう） http://syosetu.com/
+ ノクターンノベルズ http://noc.syosetu.com/
+ ムーンライトノベルズ http://mnlt.syosetu.com/
+ ハーメルン http://syosetu.org/
+ Arcadia http://www.mai-net.net/
+ 暁 http://www.akatsuki-novels.com/

コンソールで操作するアプリケーションですが、ブラウザを使って直感的に操作することができる WEB UI も搭載！（[デモページ](http://whiteleaf7.github.io/narou/demo/)）

主な機能は小説家になろうの小説のダウンロード、更新管理、テキスト整形、AozoraEpub3・kindlegen連携によるEPUB/MOBI出力です。

詳細な説明やインストール方法は **[Narou.rb 説明書](https://github.com/whiteleaf7/narou/wiki)** を御覧ください。

![WEB UI ScreenCapture](https://raw.github.com/wiki/whiteleaf7/narou/images/webui_cap.png)
![Console ScreenCapture](https://raw.github.com/wiki/whiteleaf7/narou/images/narou_cap.gif)

更新履歴 - ChangeLog
--------------------

2.8.0 : 2015/12/09
------------------
#### 追加機能
- setting.ini に項目をいくつか追加しました
	+ `title_date_format` の拡張書式として $s と $t を追加しました。
		* $s : 2045年くらいまでの残り時間(10分間隔)を4桁の文字列で埋め込めます。
		  タイトルの先頭に付加することで端末のタイトルソートで更新順に並び替えたり
		  等に利用出来ます
		* $t : 小説のタイトルそのものを埋め込めます。$t を利用することでタイトルの
		  前後両方に日付等を付与することが可能になります。$t が使用された場合は
		  title_date_align は無視されます
	+ `enable_add_end_to_title` を追加しました。完結済小説のタイトルに(完結)と
	  表示するかを制御出来ます
	+ `cut_old_subtitles` を追加しました。指定した話数分変換の対象外にすることで
	  変換速度を上げたり容量を節約したり出来ます。（カットした分栞が後ろにずれる
	  と思うので注意して下さい）
	+ `author_comment_style` を追加しました。前書き・後書きの装飾方法を指定出来る
	  ようになります
		* css:CSSで装飾。今までの奴です。何も設定しなければこれが使われます
		* simple:シンプルに段落。字下げして文字を小さくしただけなのでデザインが崩れ
		  にくいです。CSSで装飾すると不具合がでるKoboやAdobe Digital Editionでは
		  こちらの使用をおすすめします
		* plain:装飾しない。本文との間に区切り線をいれただけで、本文と同じ文字で
		  表示します
		* 一括で変更する場合は `narou s default.author_comment_style=simple` 等と
		  デフォルト値を設定して下さい
- ダイジェスト化時の選択肢を自動で選んでくれる
  `download.choices-of-digest-options` という設定を追加しました
	+ `narou s download.choices-of-digest-options=4,1` のようにカンマ区切りで
	  選択したい項目を順番に設定して下さい。詳細は `narou s` コマンドを参照。
	  WEB UI では「環境設定＞詳細」にあります
- `convert.filename-to-ncode` という設定を追加しました。出力する書籍ファイル名
  を「ドメイン名_Nコード」で固定出来ます
	+ `narou s convert.filename-to-ncode=true` で設定出来ます。WEB UI では
	  「環境設定＞一般」にあります
	+ この機能により、作者名や小説タイトルが変わった際に出力ファイル名まで一緒に
	  変更されてしまい栞が消えるのを防いだり、Kobo端末で不正なファイル名と認識
	  されないようにすることが出来ます
	+ 注意：最低一度は対象小説を更新しないと、変換してもファイル名は変わりません

#### 仕様変更
- `enable_add_end_to_title` の追加に伴い、タイトルへの完結表示はデフォルトでは
  行わなくなりました
- rawデータや本文データを保存する際に長過ぎるファイル名を一定の長さで端折るよう
  になりました
	+ この影響で、update 時にエラーが出る場合があります。その場合は再度 update を
	  することで以降は正常に更新することが出来ます（その際に新着と表示されますが
	  仕様です）
- `author_comment_style` の追加に伴い、Koboの前書き・後書きの装飾を特別に切り替
  える処理を削除しました。`narou s default.author_comment_style=simple` で変更
  して下さい
- 行頭で半角スペースで字下げをしてものを全角スペースで置換するようになりました

#### Bug Fix
- 暁の小説で前書き・後書きがあった場合に正常に取得できなくなっていたのを修正


2.7.2 : 2015/12/01
------------------
#### Bug Fix
- ハーメルンの仕様変更に伴い、本文が取得できなくなっていたのを修正
- ハーメルン、暁において前書き・後書きが前話以前のもが使われてしまう場合があるのを
  修正
- 標準入力に null を渡すとエラーになっていたのを修正 #73


----

過去の更新履歴は[こちらを参照](https://github.com/whiteleaf7/narou/blob/master/ChangeLog.md)

----

「小説家になろう」は株式会社ヒナプロジェクトの登録商標です
