Narou.rb ― 「小説家になろう」「小説を読もう！」ダウンローダ＆縦書用整形スクリプト
============================================================

[![Gem Version](https://badge.fury.io/rb/narou.svg)](http://badge.fury.io/rb/narou)

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

2.3.3 : 2015/04/24
------------------
#### Bug Fix
- `enable_ruby_youon_to_big` で拗音が大きくならない場合があったのを修正
- WEB UI 起動中にタイトルやあらすじが変更された場合に反映されない場合があった
  のを修正
	+ アップデート時に10分以上経ったキャッシュは捨てるようにしました


2.3.2 : 2015/04/01
------------------
#### Bug Fix
- `enable_insert_char_separator` でルビ及び外字注記が壊れる問題を修正


2.3.1 : 2015/03/24
------------------
#### Bug Fix
- `enable_insert_word_separator` の動作が単語単位ではなく文字単位で選択になって
  しまっていたのを修正
	- 文字単位での選択は `enable_insert_char_separator` という設定で出来るように
	  しました
- 漢数字変換を無効にした場合に章見出しの自動インデント機能が壊れる問題を修正

2.3.0 : 2015/03/21
------------------
#### 追加機能
- Kindle端末で単語の選択を出来るようにするために、小説別変換設定に
  `enable_insert_word_separator` オプションが追加されました
	+ このオプションを使うためには `narou init` を実行して AozoraEpub3 の設定を
	  修正する必要があります
	+ 各小説の setting.ini 内に `enable_insert_word_separator=true` と追加で書き
	  込むか、 `narou s force.enable_insert_word_separator=true` とコマンドを打ち
	  込むことで有効に出来ます。（WEB UI で設定すると楽です）
	+ このオプションは、Kindle端末で単語が選択出来ない問題に対応するものです。
	  device が kindle の時のみ使用可能です。また、Send to Kindle で mobi を azw3
	  に変換する場合は単語選択は可能なので、設定する必要はありません

#### Bug Fix
- ハーメルンの仕様変更に対応しました


----

過去の更新履歴は[こちらを参照](https://github.com/whiteleaf7/narou/blob/master/ChangeLog.md)

----

「小説家になろう」は株式会社ヒナプロジェクトの登録商標です
