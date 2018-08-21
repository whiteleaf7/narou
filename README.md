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

3.2.5.1: 2018/08/21
------------------
#### 修正内容
- WEB UI の小説リストの幅が、一部項目で極端にでかくなる場合があるのを修正


3.2.5: 2018/08/21
------------------
#### 追加機能
- 個別設定に `enable_prolonged_sound_mark_to_dash` を追加
  + ２つ以上の長音記号を全角ダッシュに置換します
- 個別設定に `disable_alphabet_word_to_zenkaku` を追加
  + enable_alphabet_force_zenkaku が false の場合に、8文字未満の英単語を全角に
    する機能を抑制する。英文中にルビがふってあり、英文ではなく英単語と認識され
    て全角化されてしまう場合などに使用
- 環境設定の `convert.copy-to-grouping` に「掲載サイト」毎にまとめる機能を追加
  (設定が真偽値ではなく文字列(複数)に変更)
  + deivce: 端末毎にまとめる
  + site: 掲載サイト毎にまとめる
  + 設定例: `narou s convert.copy-to-grouping=device,site`
    - 端末フォルダの中に更に掲載サイトのフォルダが作られる
- 小説プリセット追加
  + 異世界転生したけど日本語が通じなかった（なろう版／カクヨム版）
  + ありふれた職業で世界最強

#### WEB UI 追加機能
- 「作者コメント表示」機能を追加。まえがき・あとがきだけを一覧化します
  + 個別メニューからのみアクセス可能
- 小説リストに「あらすじ」ボタンを追加。初期設定は非表示なので
  「表示＞表示する項目を設定」から設定してください
  + あらすじはフィルターの対象外です
- 小説リストの幅を広げる機能を追加。それに合わせて各項目の幅を微調整しました
  + 「表示＞小説リストの幅を広げる」から設定
- 個別メニューの表示スタイルを変更する機能を追加
  + 「表示＞個別メニューの表示スタイルを選択」から設定
  + Windows スタイル：
    メニューが画面外にはみ出そうとしたら、カーソルの上側に表示する
  + Mac スタイル：
    メニューが画面外にはみ出そうとしたら、メニューがはみ出ないよう上にずれる
- 一部のメニュー項目にショートカットキーを追加
  + 小説リストの幅を広げる : W
  + 凍結中以外を表示 : Shift+F
  + 凍結中を表示 : F
  + 選択した小説のタグを編集 : T

#### 修正内容
- `auto_join_line` の連結する条件を調整
  + 次行の行頭が数字だった場合には連結しない
- 作者名が変更された場合も更新されるように修正
- ネットワーク接続のタイムアウトでクラッシュするのを修正


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

----

「小説家になろう」は株式会社ヒナプロジェクトの登録商標です
