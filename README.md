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

3.2.1: 2018/05/20
------------------
#### 追加機能
- download コマンドに --mail (-m) オプションを追加しました。ダウンロード完了後
  にメールで送信します

#### WEB UI 関連
- ヘルプページに「Narou.rbでダウンロード＆メール」というブックマークレットを
  追加しました

#### 修正内容
- device が未設定時にクラッシュしていた


3.2.0: 2018/05/16
------------------
#### 追加機能
- 小説の行の高さを設定することで行間を調整することが出来る機能を追加しました。
  init コマンドを使用することで調整が可能です
  + `narou init` とコマンドを打ち込んだ場合、AozoraEpub3フォルダの場所を聞かれ
    たあとに、行の高さを尋ねられるので入力します
  + オプションで指定する場合は `narou init -p :keep -l 1.8` の様に指定します
  + 設定後に convert した小説から反映されます
- 小説の作品名及び作者名、ファイル名を制御する設定が個別設定に追加されました
  + novel_author, novel_title, output_filename の３項目が追加
  + novel_author 及び novel_title は作品データ内及び出力ファイル名に影響
  + output_filename は全ての設定を無視して出力ファイル名を強制変更(拡張子不要)
- 小説の分割を行う設定 `slice_size` が追加されました。slice_size で指定した
  話数で小説を分割します

#### WEB UI 関連
- 「文字数」と「平均文字数」の項目を追加しました。
  『表示＞表示する項目を設定』メニューから設定出来ます
  + 文字数はダウンロードや更新をかけた際に反映されます
  + 小説家になろう系列、ハーメルン、カクヨムのサイトに対応しています
- 小説リスト内の作者名及び掲載サイト名をクリックした時に、フィルターに自動的に
  入力されるようになりました
- テーマ設定名を `webui.theme` に変更しました。テーマ機能を使っている場合は
  再度環境設定から設定をお願いします（環境設定＞WEB UI）
- 小説リストを更新するタイミングを選択する設定`webui.table.reload-timing`を
  追加しました
- 「表示」の「全ての項目を表示」及び「表示設定を全てリセット」に確認ダイアログ
  が表示されるようにしました

#### 仕様変更
- 個別設定の機能から enable_double_dash_to_image を削除しました

#### 修正内容
- server-digest-auth.enableを有効にしてもユーザー名とパスワードが未設定の場合は
  認証がかからない様に変更
- ハーメルンのサブタイトルにルビが振られた小説が正常にダウンロード出来ない場合
  がある
- カクヨムの小説がダウンロードできなくなったことへの対応

----

「小説家になろう」は株式会社ヒナプロジェクトの登録商標です
