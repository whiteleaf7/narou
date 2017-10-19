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

3.1.9: 2017/10/19
------------------
#### 修正内容
- Ruby 2.4 を使っている場合に mail コマンドを使うと警告メッセージが出ていた
- cleanコマンドでエラーが出る場合があった
- ハーメルンの仕様変更で小説が正しく取得出来なくなる場合があった


3.1.8: 2017/09/30
------------------
#### 仕様変更
- 3.1.7 でデフォルト設定をオフにした「かぎ括弧内自動連結」ですが、一旦またオン
  に戻しました。二転三転して申し訳ありません
- コンソール上でのカラー表示時の処理方法を変更しました(Windowsのみ)
  + narou setting の color-parser を変更することで今までの処理方法に戻せます
  + `narou s color-parser=self` 今までの処理方法(独力でカラー処理)
  + `narou s color-parser=system` システムにカラー表示を任せる(デフォルト)
  + 稀に表示時にエラーになってしまう現象への対策です


3.1.7: 2017/09/28
------------------
#### 仕様変更
- かぎ括弧内自動連結のデフォルト設定をオフに変更しました。
  今までと同じように標準で連結したい場合は default.enable_auto_join_in_brackets
  を有効にして下さい

#### 修正内容
- 小説家になろうのSSL化に対応

----

「小説家になろう」は株式会社ヒナプロジェクトの登録商標です
