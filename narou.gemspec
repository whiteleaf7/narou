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

3.2.2: 2018/05/24
------------------
#### 仕様変更
- narou コマンド実行時に実行フォルダ直下に narou.rb ファイルが存在する場合、
  そちらを読み込むように変更しました（開発者向け）
  + Windows はもともと narou.bat を読み込んでいたので無関係。macOS や Linux
    環境において、bin/narou を使わなくても良くなりました

#### 修正内容
- カクヨムの変更に対応


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

#{"*" * 60}
  EOS
  gem.post_install_message = install_message.gsub("\t", "  ")

  gem.required_ruby_version = ">=2.1.0"

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
end

