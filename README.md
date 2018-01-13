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

```
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  Ruby2.2の公式サポートが2018年3月末で終了することに合わせて、
  Narou.rbも2018年3月末でRuby2.2を動作対象から外します。
  早めにRuby2.4などの新しいバージョンへの移行をオススメします。
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
```

更新履歴 - ChangeLog
--------------------

3.1.11: 2017/11/21
------------------
#### 追加機能
- trace コマンドを追加しました。エラー発生時の詳細ログを表示できます

#### 修正内容
- ダイジェストを検知した場合の選択肢で、選んだ順番によってクラッシュする場合が
  ある不具合


3.1.10: 2017/11/20
------------------
#### 仕様変更
- httpでダウンロードしたとしても目次アドレスをhttpsに強制切り替えを行います
  (SSL対応サイトのみ)

#### 修正内容
- アドレスがhttpとhttpsの違いだけで、同じ小説を別の小説として扱われてしまう
- gem ライブラリのアップデートにより mail コマンドが動かなくなっていた
- ハーメルンのアドレス変更に対応
- 「DLボタン設置」ブックマークレットをhttpsアドレス下でも動くように修正
  + ヘルプページからブックマークレットの再取得が必要です。古いものは動きません
  + 最近のブラウザじゃないとたぶん動きません
- Arcadiaでカテゴリがない古い小説をダウンロード出来ない場合がある

----

「小説家になろう」は株式会社ヒナプロジェクトの登録商標です
