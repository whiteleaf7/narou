# -*- mode: ruby -*-
# -*- coding: utf-8 -*-
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "version"
require "fileutils"
module Narou
  def self.create_git_commit_version
    File.write("commitversion", `git describe --always`.strip)
    "commitversion"
  end
end
at_exit do
  if File.exist?("commitversion")
    FileUtils.rm("commitversion")
  end
end
Encoding.default_external = Encoding::UTF_8
Gem::Specification.new do |gem|
  gem.name          = "narou"
  gem.version       = Version
  gem.license       = "MIT"
  gem.authors       = ["whiteleaf7"]
  gem.email         = ["2nd.leaf@gmail.com"]
  gem.homepage      = "http://whiteleaf.hatenablog.com/"
  gem.summary       = %q{Narou.rb ― 小説家になろうダウンローダ＆縦書用整形スクリプト}
  gem.description   = %q{
小説家になろうで公開されている小説の管理、及び電子書籍データへの
変換を支援します。縦書用に特化されており、横書き用に特化されたWEB小説
を違和感なく縦書で読むことが出来るようになります。
}.split("\n").join
  install_message = <<-EOS
#{"*" * 60}

3.0.5 : 2017/01/16
-------------------
#### 仕様変更
- mail で送信するファイル名を `小説ID.拡張子` で固定するように変更しました
  + メールに添付するファイル名に使えない文字が使われる可能性を排除するため

#### 修正内容
- mail コマンドで送信できない小説がある


3.0.4 : 2016/12/22
-------------------
#### 修正内容
- ハーメルンのR18小説がダウンロード出来ない問題


3.0.3 : 2016/12/03
-------------------
#### 仕様変更
- カクヨムの小説の最新話掲載日が今までは「最終更新日」から取得していたのを、
  目次の一番新しい話の日付を割り当てるように変更

#### 修正内容
- その他の小説の最新話掲載日を確認しようとするとクラッシュする場合がある問題
	+ カクヨムの小説が含まれていると発生していた


3.0.2 : 2016/11/29
-------------------
#### 修正内容
- narou init が正常に実行できない場合がある


3.0.1 : 2016/11/28
-------------------
#### 修正内容
- 削除された小説を更新しようとするとクラッシュする場合がある


3.0.0 : 2016/11/25
-------------------
#### 追加機能
- update コマンドに --ignore-all オプションを追加しました
	+ 更新対象小説を指定しない場合の全件アップデート処理を無効にします
	+ `narou l | narou u --ignore-all` のように PIPE で繋いだ時、処理件数が偶然
	  ０件になった場合に意図せず全件更新にならない為に使用します
- コマンド使用時に `^tag:NAME` でタグの除外指定が出来るようになりました。
  先に実装された WEB UI での除外検索は `-tag:NAME` ですが、コマンドラインでは
  -tag とするとオプションと誤認識されてしまう問題があり、^ に変更しました。
	+ これに合わせて、WEB UI でも ^tag: を使えるようになります（従来の -tag も
	  使えます）
- WEB UI 関連
	- Update ボタンに「タグを指定して更新」を追加しました
	- Update ボタンの「最新話更新日を確認」を刷新しました。なろうAPIを使用して
	  一括で更新されたかを確認することが出来るようになります
		+ コマンドライン版の `narou update --gl` も同様の機能に変わっています。
		  詳細は narou u -h を参照
		+ > “実際に小説のデータが修正されてからなろうAPIに反映されるまで平均5分
		  程度(最大2時間)の誤差があります。”

		  （[公式サイト](http://dev.syosetu.com/man/api/)から引用）
		+ ダイアログ内の各チェックリストの項目を独立させたものが、「な」「他」
		  「(更新アイコン)」ボタンに独立させてあります。詳細はマウスホーバーの説明
		  を参照
		+ 最新話掲載日を確認した結果、新着がありそうな小説には「最新話掲載日」の
		  日付の左上あたりに目印が表示されます
	- 小説リストに「話数」を追加しました
	- 小説リストに「更新チェック日」を追加しました
	- Linux でも Eject ボタンに対応しました
		+ デスクトップにログインした状態での udisks-daemon または udisksd による
		  自動マウントにのみ対応しています
		+ 使用中のデスクトップの外部で `narou web` を動かしている場合(例えばOS
		  起動時に自動起動させた場合やログインし直した場合)、権限の問題により
		  Eject が効かない場合があります
- 設定に `normalize-filename` を追加しました。ファイル名をNFCで正規化します。
  Dropbox 使用時などに合成文字列関係で問題がある場合などに使用して下さい。
  正規化後のファイル名が以前の物と変わった場合、別ファイルと認識されるので理解
  の上で有効にして下さい
- 調査ログ保存時にエラー・警告・INFOの個数を表示するようにしました。
  （`convert.inspect` が false の場合）
- setting.ini の title_date_format に、小説のタグを埋め込める書式 $ntag を追加
  しました。小説にタグがついている場合、全てのタグをカンマ区切りで埋め込めます

#### 仕様変更
- WEB UI の小説リストの初期表示状態を項目数増加に伴い整理しました
	+ 初期ソートを「最新話掲載日」に変更
	+ 種別、DL、更新チェック日、話数は初期状態では非表示
	+ 項目追加に伴い表示のカスタマイズがリセットされるので再設定をお願いします
- 現在ユーザーフォルダに保存されている .narousetting フォルダ(グローバル設定用)
  を .narou フォルダと同じ場所に移動／コピーした場合、そちらを優先して読みに
  行くようになりました
	+ 全てのデータが一つのフォルダにまとめることが出来るようになるので、別PCへの
	  データ移行がしやすくなります
	+ また、現在はサーバー設定がグローバル設定で保存されているため、小説フォルダ
	  を分けても WEB UI サーバのアドレスが同じになってしまっていましたが、別々の
	  アドレス／ポートにすることが可能になります
- 複数のタグを同時に指定した場合、同じ小説が複数回対象になっていたのを一度のみ
  対象になるように変更しました
	+ 例) A と B というタグをもつ小説があったとして、`narou u A B` で二度更新され
	  てしまっていたのが、一度のみ更新されるようになる
- send --without-freeze オプションを指定時、対象小説を指定した場合でも凍結時は
  送信されなくなりました。（send.without-freeze を設定していても同じ）
	+ WEB UI ではこれまでと同様に一括時のみ凍結済みは送信されず、個別指定時は凍結
	  済みでも送信出来ます
- send --without-freeze オプションの短縮形として -w を設定しました
- send で送信時、対象小説を指定した／しないに関わらずタイムスタンプを必ず比較
  して新しければ送信するように変更しました
	+ 必ず送信したい場合は --force オプションを指定して下さい
- 栞のバックアップ・レストア時にタイムスタンプを見て新しい場合のみコピーする
  ように変更しました

#### 修正内容
- カクヨムの情報が一部取得出来なくなっていた
- mail コマンド送信時に添付ファイルに @ が付いている場合、全角の＠に置換する様
  にしました
- WEB UI でタグ検索時にフィルター末尾に自動で半角空白を挿入するようにしました
- list コマンドで検索やタグによる絞り込みと＜limit＞の指定による表示個数を制限
  を併用した場合に、＜limit＞で指定した分のみしか絞り込み対象になっていなかった
- list --filter series を指定時に一つも連載小説が表示されていなかった
- Linux 環境で send コマンドが送信出来ない場合があった #119
- 小説IDが一桁の場合に、download.use-subdirectory で作られるサブフォルダに半角
  スペースが含まれてしまっていた
- WEB UI のフィルターのおいて、本来表示されない内部データにまでマッチングして
  しまう不具合
- update.logging オプションが有効な場合に、アップデートをしない時でもログを
  保存してしまう場合がある不具合
- その他動作の安定性を向上などの細かい修正

#{"*" * 60}
  EOS
  gem.post_install_message = install_message.gsub("\t", "  ")

  gem.required_ruby_version = ">=2.1.0"

  gem.files = `git ls-files`.split("\n").reject { |fn| fn =~ %r!^spec/|^"spec! } << Narou.create_git_commit_version
  gem.executables = gem.files.grep(%r!^bin/!).map { |f| File.basename(f) }

  gem.add_runtime_dependency 'termcolorlight', '~> 1.0', '>= 1.1.1'
  gem.add_runtime_dependency 'rubyzip', '~> 1.1', '>= 1.1.0'
  gem.add_runtime_dependency 'mail', '2.5.4'
  gem.add_runtime_dependency 'pony', '~> 1.8'
  gem.add_runtime_dependency 'diff-lcs', '~> 1.2', '>= 1.2.5'
  gem.add_runtime_dependency 'sinatra', '~> 1.4', '>= 1.4.5'
  gem.add_runtime_dependency 'sinatra-contrib', '~> 1.4', '>= 1.4.2'
  gem.add_runtime_dependency 'tilt', '~> 2.0', '>= 2.0.1'
  gem.add_runtime_dependency 'sass', '~> 3.4', '>= 3.4.18'
  gem.add_runtime_dependency 'haml', '~> 4.0', '>= 4.0.7'
  gem.add_runtime_dependency 'memoist', '~> 0.11.0'
  gem.add_runtime_dependency 'systemu', '~> 2.6', '>= 2.6.5'
  gem.add_runtime_dependency 'erubis', '~> 2.7'
  gem.add_runtime_dependency 'open_uri_redirections', '~> 0.2', '>= 0.2.1'
end

