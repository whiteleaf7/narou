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

2.5.0 : 2015/07/10
------------------
#### 追加機能
- WEB UI の個別メニューから「差分を表示」を選択した際に、過去の差分を選択出来る
  ようにしました
- WEB UI の個別メニューに「タグを編集」を追加しました
- 変換設定の各項目の共通設定を変更できる default.* 系設定を追加しました
	+ この共通設定は setting.ini で未設定の項目がある場合に適用されます。また、
	  force.* が設定されていた場合は setting.ini、共通設定ともに無視されます
	+ 例えば `enable_illust` の共通設定を変更したい場合、
	  `narou s default.enable_illust=false` とすることで変更出来ます
	  (WEB UIからは環境設定のページで隠しオプションを表示)
- `convert` コマンドに `--ignore-default` オプションを追加しました。変換時の
  default.* 系設定を無視します
- `convert.copy-to-grouping` オプションを追加しました
	+ copy-to で指定したフォルダの中に更に device もしくは convert.multi-device
	  で指定した端末毎に振り分けるように出来ます
	+ 有効にするには `narou s convert.copy-to-grouping=true` を実行して下さい
- 全小説を対象にした replace.txt による置換に対応しました
	+ narou init を使用したフォルダに replace.txt を設置すると認識します。
	  WEB UI においては環境設定にて設定できます
- `update` コマンドにアップデートの順番を変更する `--sort-by` オプションが追加
  されました（短縮 `-s`）
	+ `narou u --sort-by general_update` のように直接コマンドのオプションとして
	  指定するか、 `narou s update.sort-by=general_update` と設定として保存して
	  下さい
	+ 指定出来るのは id, last_update(更新日), title(タイトル), author(作者名),
	  new_arrivals_date(新着日), general_lastup(最新話掲載日) です
- WEB UI の設定画面において一部項目をセレクトボックスで選択出来るようにしました

#### 仕様変更
- default.* 系設定追加に伴い、新規DL時の setting.ini の全ての項目がコメント
  アウトされた状態で生成されます。また、WEB UI の個別変換設定画面にて、各項目に
  「未設定」が追加されます
- `setting` コマンド(WEB UIにおける環境設定)の項目の順序・表示を変更しました
- `setting` コマンドの一部項目で適切な値が入力されなかった場合にエラーが出る
  ようになりました
- WEB UI の個別メニュー内項目の並び順を変更しました
- WEB UI サーバ起動中にコマンドラインで更新した場合でもサーバを再起動せずに変更
  が反映されるようになりました

#### Bug Fix
- `enable_insert_word_separator` を有効時に `［` が正常に禁則処理されない問題を
  修正
- i文庫形式に変換する際に `enable_illust` の設定が無視されていたのを修正
- WEB UI サーバ起動中に converter.rb を編集しても反映されなかったのを修正
- 文章中のリンクが正しく飛べない場合があったのを修正

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
end

