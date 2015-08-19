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
#{"*" * 79}

2.6.0 : 2015/07/31
------------------
#### 追加機能
- hotnentry 機能を追加しました
	+ update 時に新着投稿のみを一つにまとめた書籍データを生成します(hotentry
	  フォルダに保存されます。`convert.copy-to` が設定されていてれば、そこにも
		コピーします)
	+ `narou s hotentry=true` で有効に出来ます
	+ この機能は `convert.no-epub` の制限を受けないので、no-epub を有効にしておき
	  update 時に hotnentry のデータのみを変換するで更新時間の短縮等も可能です
	+ 収録順序を変更したい場合は `update.sort-by` を設定して下さい。更新順に収録
	  されます
	+ 変換時にデバイスへ送信しなかった場合は `narou send` もしくは `narou send
	  hotentry` にて **最新の** hotnetry データを送信します
	+ `narou mail hotentry` にて最新の hotentry をメール送信します。また、
	  `narou s hotentry.auto-mail=true` と設定していた場合、変換時に自動でメール
	  送信します（mail の設定が済んでいる場合のみ）
	+ 変換設定は各小説の設定がそれぞれ適用されます
	+ multi-device には未対応です
- `update` コマンドに凍結済みでも更新する `--force` オプションを追加しました
- `setting` コマンドに `--burn` オプションを追加しました
	+ 指定した小説の setting.ini の未設定項目に共通設定を焼付け（書き込み）ます
	+ `narou s --burn ID's` として実行して下さい
	  (WEB UIにおいてはOtherボタンに追加)
- setting.ini に `title_date_target` を追加しました。小説タイトルに付加する日付
  の種類を選択できます
- 設定プリセット追加
	+ n7975cr 蜘蛛ですが、なにか？

#### WEB UI
- Download に複数の小説を同時に指定出来るようにしました
- 個別変換設定ページのタイトルに小説のタイトルを付けるようにしました
- 環境設定画面をタブで整理しました
- setting.ini に保存する時にコメントを復元するようにしました
- 設定画面の選択肢を「する、しない」から「はい、いいえ」に変更しました
- Remove ボタンの通常削除と完全削除をひとつに統合しました
- テーマ機能を追加しました（環境設定＞一般＞theme）
	+ 実験的機能なので、以降のアップデートで削除される可能性もあります
- 凍結表示状態をブラウザを閉じても維持するように変更しました

#### 仕様変更
- タグとエイリアスに hotentry という名前を設定出来ないようにしました
- 小説内の調査を `enable_inspect` を有効にしないと実行しないように変更しました
  （カギ括弧関連の調査が、カギ括弧を多用する小説だとかなりの負荷になるため）
- setting.ini 内の `enable_inspect_invalid_openclose_brackets` を廃止し、
  `enable_inspect` に統合しました

#### Bug Fix
- `enable_insert_char_separator` でルビが消える不具合を修正
- 暁の18禁小説がダウンロードできなくなっていたのを修正
- ハーメルンで&lt; &gt;に囲まれた文字が消える不具合を修正
- 小説家になろうのルビ仕様に追随できていなかった部分を修正
- WEB UI の凍結表示状態がおかしくなることがあったのを修正


2.6.1 : 2015/08/03
------------------
#### 追加機能
- setting.iniに装飾タグを削除する `enable_strip_decoration_tag` を追加しました
	+ タグ内で改行されておかしくなった場合に対処出来るようにするためのものです

#### Bug Fix
- 章が存在する小説で章ページおかしくなる不具合を修正
- Arcadia でトリップのついていない作者名が正しく取得出来ない不具合を修正

#{"*" * 79}
  EOS
  gem.post_install_message = install_message.gsub("\t", "  ")

  gem.required_ruby_version = ">=1.9.3"

  gem.files         = `git ls-files`.split("\n") << Narou.create_git_commit_version
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.add_runtime_dependency 'termcolorlight', '~> 1.0', '>= 1.1.1'
  gem.add_runtime_dependency 'rubyzip', '~> 1.1', '>= 1.1.0'
  gem.add_runtime_dependency 'mail', '2.5.4'
  gem.add_runtime_dependency 'pony', '~> 1.8'
  gem.add_runtime_dependency 'diff-lcs', '~> 1.2', '>= 1.2.5'
  gem.add_runtime_dependency 'sinatra', '~> 1.4', '>= 1.4.5'
  gem.add_runtime_dependency 'sinatra-contrib', '~> 1.4', '>= 1.4.2'
  gem.add_runtime_dependency 'sass', '~> 3.4', '>= 3.4.4'
  gem.add_runtime_dependency 'haml', '~> 4.0', '>= 4.0.5'
  gem.add_runtime_dependency 'memoist', '~> 0.11.0'
  gem.add_runtime_dependency 'systemu', '~> 2.6', '>= 2.6.5'
end

