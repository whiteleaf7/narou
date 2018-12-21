Narou.rb - 小説家になろうのダウンローダ＆縦書き整形＆管理アプリ。Kindle（などの電子書籍端末）でなろうを読む場合に超便利です！
===================================================================================

[![Gem Version](https://badge.fury.io/rb/narou.svg)](http://badge.fury.io/rb/narou)
[![Join the chat at https://gitter.im/whiteleaf7/narou](https://badges.gitter.im/whiteleaf7/narou.svg)](https://gitter.im/whiteleaf7/narou?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

概要 - Summary
--------------
このアプリは[小説家になろう](http://syosetu.com/)などで公開されている小説の管理、
及び電子書籍データへの変換を支援します。縦書き用に特化されており、
横書きに最適化されたWEB小説を違和感なく縦書きで読むことが出来るようになります。
また、校正機能もありますので、小説としての一般的な整形ルールに矯正します。（例：感嘆符のあとにはスペースが必ずくる）

小説家になろうを含めて、下記のサイトに対応しています。
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
その他にも変換したデータを直接電子書籍端末へ送信する機能は、メールで送信する機能などもあります。

詳細な説明やインストール方法は **[Narou.rb 説明書](https://github.com/whiteleaf7/narou/wiki)** を御覧ください。

![WEB UI ScreenCapture](https://raw.github.com/wiki/whiteleaf7/narou/images/webui_cap.png)
![Console ScreenCapture](https://raw.github.com/wiki/whiteleaf7/narou/images/narou_cap.gif)

更新履歴 - ChangeLog
--------------------

3.4.1: 2018/12/18
------------------
#### 修正内容
- 3.4.0 の変更で小説家になろうの短編がダウンロードできなくなっていた


3.4.0: 2018/12/18
------------------
#### 仕様変更
- WEB UI の小説リストにおいて、ID のソート順を降順からに変更しました

#### 修正内容
- Linux と第10世代 Kindle PW の組み合わせで Eject 時にエラーが起こるのを修正
- 小説家になろうの仕様変更に対応

----

「小説家になろう」は株式会社ヒナプロジェクトの登録商標です
