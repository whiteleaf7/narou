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

3.1.4 : 2017/08/22
------------------
#### 追加機能
- WEB UIにDigest認証の設定を追加しました。設定に server-digest-auth.* 関連の値
  が追加されています。詳しくは narou s -a かWEB UIの設定画面(Globalタブ)を参照
  して下さい

#### 修正内容
- 小説家になろうの目次の仕様変更に対応
- 小説家になろうのルビ仕様に追随できていなかった部分(ふりがなに空白を含む場合)
  を修正


3.1.3 : 2017/07/10
------------------
#### 修正内容
- hotentry.auto-mail を有効にしても、更新時に hotentry がメールで送信されなく
  なっていた


3.1.2 : 2017/06/10
------------------
#### 追加機能
- WEB UIにおいて、フィルターに入力されている状況をアドレスバーに反映するように
  しました。(ブックマークなどをすることでフィルターの状況を記憶・再現出来ます)

#### 修正内容
- WEB UIにおいて、凍結状態の表示状態に関わらず小説データを内部で取得していた事
  により、表示速度が低下していたのを修正しました
- 暁の常時 https 化に対応


3.1.1 : 2017/04/05
------------------
#### 追加機能
- `clean` コマンドを実装しました。サブタイトルの変更等により参照されなくなった
  ゴミファイルを削除することが出来ます。詳細は `narou clean -h`を参照して下さい
- WEB UI からメールを送信する機能を追加しました
  + Other ボタンと、個別メニューに追加されます

#### 修正内容
- Ruby 2.4 対応
- WEB UI のアバウトダイアログで、最新バージョンチェックが正しく動かなくなる場合
  があったのを修正
- WEB UI から「凍結済みでも更新」が使用出来ずにエラーが出ていたのを修正

----

「小説家になろう」は株式会社ヒナプロジェクトの登録商標です
