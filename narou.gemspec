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
  gem.version       = ::Narou::VERSION
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

#{"*" * 60}
  EOS
  gem.post_install_message = install_message.gsub("\t", "  ")

  gem.required_ruby_version = ">=2.3.0"

  gem.files = `git ls-files`.split("\n").reject { |fn| fn =~ %r!^spec/|^"spec! } << Narou.create_git_commit_version
  gem.executables = gem.files.grep(%r!^bin/!).map { |f| File.basename(f) }

  gem.add_runtime_dependency 'termcolorlight', '~> 1.0', '>= 1.1.1'
  gem.add_runtime_dependency 'rubyzip', '~> 1.1', '>= 1.1.0'
  gem.add_runtime_dependency 'mail', '~> 2.6.0', '>= 2.6.6'
  gem.add_runtime_dependency 'pony', '~> 1', '>= 1.11'
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
  gem.add_runtime_dependency 'activesupport', '~> 5.2'
  gem.add_runtime_dependency 'unicode-display_width', '~> 1.4'
end

