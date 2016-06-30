Narou.rb ― 「小説家になろう」「小説を読もう！」ダウンローダ＆縦書用整形スクリプト
============================================================

[![Gem Version](https://badge.fury.io/rb/narou.svg)](http://badge.fury.io/rb/narou)
[![Join the chat at https://gitter.im/whiteleaf7/narou](https://badges.gitter.im/whiteleaf7/narou.svg)](https://gitter.im/whiteleaf7/narou?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge) 

概要 - Summary
--------------
このアプリは[小説家になろう](http://syosetu.com/)、[小説を読もう！](http://yomou.syosetu.com/)で公開されている小説の管理、
及び電子書籍データへの変換を支援します。縦書き用に特化されており、
横書き用に特化されたWEB小説を違和感なく縦書きで読むことが出来るようになります。
また、校正機能もありますので、小説としての一般的な整形ルールに矯正します。（例：感嘆符のあとにはスペースが必ずくる）

対応小説サイト：
+ 小説家になろう http://syosetu.com/
+ ノクターンノベルズ http://noc.syosetu.com/
+ ムーンライトノベルズ http://mnlt.syosetu.com/
+ ミッドナイトノベルズ http://mid.syosetu.com/
+ ハーメルン https://syosetu.org/
+ Arcadia http://www.mai-net.net/
+ 暁 http://www.akatsuki-novels.com/ （※300話以上ある作品は未対応）
+ カクヨム https://kakuyomu.jp/

コンソールで操作するアプリケーションですが、ブラウザを使って直感的に操作することができる WEB UI も搭載！（[デモページ](http://whiteleaf7.github.io/narou/demo/)）

主な機能は小説家になろうの小説のダウンロード、更新管理、テキスト整形、AozoraEpub3・kindlegen連携によるEPUB/MOBI出力です。

詳細な説明やインストール方法は **[Narou.rb 説明書](https://github.com/whiteleaf7/narou/wiki)** を御覧ください。

![WEB UI ScreenCapture](https://raw.github.com/wiki/whiteleaf7/narou/images/webui_cap.png)
![Console ScreenCapture](https://raw.github.com/wiki/whiteleaf7/narou/images/narou_cap.gif)

更新履歴 - ChangeLog
--------------------

2.9.4 : 2016/06/16
------------------
#### 仕様変更
- `download.interval` のデフォルト値を0.7秒に変更しました（下限は0秒のまま）

#### 修正
- `update --gl` コマンド（最新話掲載日を更新）で update.interval が反映されて
  いなかったのを修正


2.9.3.1 : 2016/06/15
--------------------
#### 修正
- 凍結済みでも待機時間が発生してしまっていたのを修正


2.9.3 : 2016/06/15
------------------
#### WEB UI
- 小説URLもFilterで検索出来るようにしました
	+ NコードがURLに含まれている為、Nコード検索としても使えます
- ダイジェスト化を検知した際にでる選択肢に、「8. 変換する」を追加しました

#### 仕様変更
- `enable_dakuten_font` を復活させました
	+ AozoraEpub3の一文字濁点フォント機能を使った場合、端末でフォントを切り替えた
	  場合に濁点にならない問題があったため、切り替えた場合でも機能するNarou.rbの
	  濁点フォントを再び使えるようにしました
	+ setting.ini で enable_dakuten_font = true とすることで有効になり、false の
	  場合は AozoraEPub3 の一文字濁点フォント機能を使用します。
	  （デフォルトでは false で、 AozoraEpub3 の機能を使います）
- 更新時に１作品ごとに待機時間が入るようになりました
	+ `update.interval` で待機秒数を指定出来ます（ただし、最低2.5秒必要です）
	+ 更新処理の時間も含まれるので、例えば更新処理に１秒かかった場合は待機時間は
	  1.5秒です。2.5秒以上更新や変換にかかった場合は待機時間は発生しません

#### 修正
- i文庫に変換時にカクヨムのサブチャプターが反映されていなかったのを修正
- WEB UIのタグを編集ダイアログ内でタグをソートしていなかったのを修正


2.9.2 : 2016/04/08
------------------
#### 修正
- WEB UIの個別メニュー「差分を表示」が実行出来ない不具合を修正


----

過去の更新履歴は[こちらを参照](https://github.com/whiteleaf7/narou/blob/master/ChangeLog.md)

----

「小説家になろう」は株式会社ヒナプロジェクトの登録商標です
