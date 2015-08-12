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

2.6.1 : 2015/08/03
------------------
#### 追加機能
- setting.iniに装飾タグを削除する `enable_strip_decoration_tag` を追加しました
	+ タグ内で改行されておかしくなった場合に対処出来るようにするためのものです

#### Bug Fix
- 章が存在する小説で章ページおかしくなる不具合を修正
- Arcadia でトリップのついていない作者名が正しく取得出来ない不具合を修正



2.6.0 : 2015/07/31
------------------
#### 追加機能
- hotnentry 機能を追加しました
	+ update 時に新着投稿のみを一つにまとめた書籍データを生成します(hotentry
	  フォルダに保存されます。`convert.copy-to` が設定されていてれば、そこにも
		コピーします)
	+ `narou s hotentry=true` で有効に出来ます
	+ この機能は `convert.no-epub` の制限を受けないので、no-epub を有効にしておき
	  update 時に hotnentry のデータのみを変換するで更新時間の短縮等も可能です
	+ 収録順序を変更したい場合は `update.sort-by` を設定して下さい。更新順に収録
	  されます
	+ 変換時にデバイスへ送信しなかった場合は `narou send` もしくは `narou send
	  hotentry` にて **最新の** hotnetry データを送信します
	+ `narou mail hotentry` にて最新の hotentry をメール送信します。また、
	  `narou s hotentry.auto-mail=true` と設定していた場合、変換時に自動でメール
	  送信します（mail の設定が済んでいる場合のみ）
	+ 変換設定は各小説の設定がそれぞれ適用されます
	+ multi-device には未対応です
- `update` コマンドに凍結済みでも更新する `--force` オプションを追加しました
- `setting` コマンドに `--burn` オプションを追加しました
	+ 指定した小説の setting.ini の未設定項目に共通設定を焼付け（書き込み）ます
	+ `narou s --burn ID's` として実行して下さい
	  (WEB UIにおいてはOtherボタンに追加)
- setting.ini に `title_date_target` を追加しました。小説タイトルに付加する日付
  の種類を選択できます
- 設定プリセット追加
	+ n7975cr 蜘蛛ですが、なにか？

#### WEB UI
- Download に複数の小説を同時に指定出来るようにしました
- 個別変換設定ページのタイトルに小説のタイトルを付けるようにしました
- 環境設定画面をタブで整理しました
- setting.ini に保存する時にコメントを復元するようにしました
- 設定画面の選択肢を「する、しない」から「はい、いいえ」に変更しました
- Remove ボタンの通常削除と完全削除をひとつに統合しました
- テーマ機能を追加しました（環境設定＞一般＞theme）
	+ 実験的機能なので、以降のアップデートで削除される可能性もあります
- 凍結表示状態をブラウザを閉じても維持するように変更しました

#### 仕様変更
- タグとエイリアスに hotentry という名前を設定出来ないようにしました
- 小説内の調査を `enable_inspect` を有効にしないと実行しないように変更しました
  （カギ括弧関連の調査が、カギ括弧を多用する小説だとかなりの負荷になるため）
- setting.ini 内の `enable_inspect_invalid_openclose_brackets` を廃止し、
  `enable_inspect` に統合しました

#### Bug Fix
- `enable_insert_char_separator` でルビが消える不具合を修正
- 暁の18禁小説がダウンロードできなくなっていたのを修正
- ハーメルンで&lt; &gt;に囲まれた文字が消える不具合を修正
- 小説家になろうのルビ仕様に追随できていなかった部分を修正
- WEB UI の凍結表示状態がおかしくなることがあったのを修正



2.5.2 : 2015/07/23
------------------
#### 仕様変更
- タグに一部の記号を設定出来ないようにしました
- IDとタグがかぶった場合（404等）、IDを優先するように変更しました。かぶっている
  状態でタグを明示的に指定する場合は `tag:タグ名` と指定して下さい
	+ 例： `narou u tag:404` 404タグが付いた小説を更新する

#### Bug Fix
- IDと同じタグがある場合に操作が不可能になる不具合を修正


2.5.1 : 2015/07/10
------------------
#### Bug Fix
- WEB UI において個別変換設定ページに移動するとエラーがでる問題を修正
- `inspect` コマンドを使用するとエラーがでる問題を修正



----

過去の更新履歴は[こちらを参照](https://github.com/whiteleaf7/narou/blob/master/ChangeLog.md)

----

「小説家になろう」は株式会社ヒナプロジェクトの登録商標です
