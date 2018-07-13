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

3.2.4: 2018/07/14
------------------
#### 追加機能
- WEB UI の Download ボタンに、DL終了後にメールで送信するオプションを追加

#### 修正内容
- enable_inspect が有効だと変換後にエラーが出ていた
- 分割して変換した場合にあらすじにURLが含まれていると変換結果がおかしくなる
- カクヨムのあらすじが取得できなくなっていた


3.2.3: 2018/05/27
------------------
#### 修正内容
- タイトルに ` が含まれていると変換時にエラーが出ていた
- Windows でDL用ブックマークレットを動かすとエラーが出ていた


3.2.2: 2018/05/24
------------------
#### 仕様変更
- narou コマンド実行時に実行フォルダ直下に narou.rb ファイルが存在する場合、
  そちらを読み込むように変更しました（開発者向け）
  + Windows はもともと narou.bat を読み込んでいたので無関係。macOS や Linux
    環境において、bin/narou を使わなくても良くなりました

#### 修正内容
- カクヨムの変更に対応

----

「小説家になろう」は株式会社ヒナプロジェクトの登録商標です
