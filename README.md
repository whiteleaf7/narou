Narou.rb ― 小説家になろうダウンローダ＆縦書用整形スクリプト
============================================================

説明 - Description
------------------

小説家になろうから小説をダウンロードして、縦書で読みやすいようにテキストを整形し、AozoraEPUB3を使ってEPUB化します。
小説の更新管理もできます。

作った人 - Author
-----------------
* whiteleaf
* Twitter: https://twitter.com/sasalove7
* Blog: http://whiteleaf.hatenablog.com/

必須ツール - Require tools
--------------------------
* Ruby 1.9.3以上 (Windows: http://www.artonx.org/data/asr/, その他OS: 適当に)
* AozoraEpub3 1.1.0系 (http://www18.atwiki.jp/hmdev/pages/21.html)
* Java 6以降（AozoraEpub3で必須）
* kindlegen 2.7 (http://www.amazon.com/gp/feature.html?ie=UTF8&docId=1000765211)

機能っぽい一覧 - Functions
--------------------------
```
 Usage: narou <command> [arguments...] [options...]

 コマンドの簡単な説明:
   download     指定した小説をダウンロードします
   update       小説を更新します
   list         現在管理している小説の一覧を表示します
   convert      小説を変換します。管理小説以外にテキストファイルも変換可能
   diff         アップデートされた小説の変更点を表示します
   setting      各コマンドの設定を変更します
   alias        小説のIDに紐付けた別名を作成します
   inspect      小説状態の調査状況ログを表示します
   send         変換したEPUB/MOBIを電子書籍端末に送信します
   folder       小説の保存フォルダを開きます
   browser      小説の掲載ページをブラウザで開きます
   remove       小説を削除します
   freeze       小説の凍結設定を行います
   help         このヘルプを表示します
   version      バージョンを表示します
   init         AozoraEpub3 の再設定を行います

  各コマンドの詳細は narou <command> -h/--help を参照してください。
  各コマンドは先頭の一文字か二文字でも指定できます。
  (e.g. `narou d n4259s', `narou fr musyoku')
```

インストール - How to install
-----------------------------
* 事前に AozoraEpub3 をインストールしておきます。
  → http://www18.atwiki.jp/hmdev/pages/21.html

* kindlegen を AozoraEpub3 をインストールしたフォルダにコピーします。
  → http://www.amazon.com/gp/feature.html?ie=UTF8&docId=1000765211

* Narou.rb をインストールします。
  コンソールで
```
gem install narou
```

* 小説の管理用として任意のフォルダで、
```
narou init
```
  あとは画面の説明に従って下さい。

使い方 - How to use
-------------------
基本的な使い方

narou init したフォルダで、narou <command> を適宜実行します。
```
narou downlaod Nコード
narou update Nコード
narou convert Nコード
```
等と使います。

（書きかけ）

サポート - Support
------------------
https://twitter.com/sasalove7 , http://whiteleaf.hatenablog.com/

上記のツイッター及びブログで今後要望等を取り扱いたいと思います。

添付のDMincho.ttfについて - About DMincho font
----------------------------------------------
WEB小説でよく見かける「あ゛」のような表現を、縦書でも再現するための濁点つきフォントです。

青キン明朝フォントをカスタマイズして使用しています。

オリジナルはIPA明朝フォントであり、ライセンスは IPAフォントライセンスv1.0 の元に「派生プログラム」として
再配布されています。

ライセンスに基づく一般公開は以下のURLになります。また、
オリジナルなIPA明朝フォントに戻す場合、下記からDL出来るアーカイブに同梱の ipam.otf で上書きして下さい。

http://ux.getuploader.com/whiteleaf/download/23/ipam.rar
