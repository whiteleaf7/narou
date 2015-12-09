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

2.8.0 : 2015/12/09
------------------
#### 追加機能
- setting.ini に項目をいくつか追加しました
	+ `title_date_format` の拡張書式として $s と $t を追加しました。
		* $s : 2045年くらいまでの残り時間(10分間隔)を4桁の文字列で埋め込めます。
		  タイトルの先頭に付加することで端末のタイトルソートで更新順に並び替えたり
		  等に利用出来ます
		* $t : 小説のタイトルそのものを埋め込めます。$t を利用することでタイトルの
		  前後両方に日付等を付与することが可能になります。$t が使用された場合は
		  title_date_align は無視されます
	+ `enable_add_end_to_title` を追加しました。完結済小説のタイトルに(完結)と
	  表示するかを制御出来ます
	+ `cut_old_subtitles` を追加しました。指定した話数分変換の対象外にすることで
	  変換速度を上げたり容量を節約したり出来ます。（カットした分栞が後ろにずれる
	  と思うので注意して下さい）
	+ `author_comment_style` を追加しました。前書き・後書きの装飾方法を指定出来る
	  ようになります
		* css:CSSで装飾。今までの奴です。何も設定しなければこれが使われます
		* simple:シンプルに段落。字下げして文字を小さくしただけなのでデザインが崩れ
		  にくいです。CSSで装飾すると不具合がでるKoboやAdobe Digital Editionでは
		  こちらの使用をおすすめします
		* plain:装飾しない。本文との間に区切り線をいれただけで、本文と同じ文字で
		  表示します
		* 一括で変更する場合は `narou s default.author_comment_style=simple` 等と
		  デフォルト値を設定して下さい
- ダイジェスト化時の選択肢を自動で選んでくれる
  `download.choices-of-digest-options` という設定を追加しました
	+ `narou s download.choices-of-digest-options=4,1` のようにカンマ区切りで
	  選択したい項目を順番に設定して下さい。詳細は `narou s` コマンドを参照。
	  WEB UI では「環境設定＞詳細」にあります
- `convert.filename-to-ncode` という設定を追加しました。出力する書籍ファイル名
  を「ドメイン名_Nコード」で固定出来ます
	+ `narou s convert.filename-to-ncode=true` で設定出来ます。WEB UI では
	  「環境設定＞一般」にあります
	+ この機能により、作者名や小説タイトルが変わった際に出力ファイル名まで一緒に
	  変更されてしまい栞が消えるのを防いだり、Kobo端末で不正なファイル名と認識
	  されないようにすることが出来ます
	+ 注意：最低一度は対象小説を更新しないと、変換してもファイル名は変わりません

#### 仕様変更
- `enable_add_end_to_title` の追加に伴い、タイトルへの完結表示はデフォルトでは
  行わなくなりました
- rawデータや本文データを保存する際に長過ぎるファイル名を一定の長さで端折るよう
  になりました
	+ この影響で、update 時にエラーが出る場合があります。その場合は再度 update を
	  することで以降は正常に更新することが出来ます（その際に新着と表示されますが
	  仕様です）
- `author_comment_style` の追加に伴い、Koboの前書き・後書きの装飾を特別に切り替
  える処理を削除しました。`narou s default.author_comment_style=simple` で変更
  して下さい
- 行頭で半角スペースで字下げをしてものを全角スペースで置換するようになりました

#### Bug Fix
- 暁の小説で前書き・後書きがあった場合に正常に取得できなくなっていたのを修正


2.8.1 : 2015/12/10
------------------
#### 追加機能
- setting.ini の `title_date_format` に下記の拡張書式を追加しました
	+ $ns : 小説が掲載されているサイト名
	+ $nt : 小説種別（短編 or 連載）

#### 仕様変更
- `convert.filename-to-ncode` でファイル名をNコード化するのに、更新をしなくても
  変換出来るようにしました

#{"*" * 79}
  EOS
  gem.post_install_message = install_message.gsub("\t", "  ")

  gem.required_ruby_version = ">=2.1.0"

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
  gem.add_runtime_dependency 'tilt', '~> 2.0', '>= 2.0.1'
  gem.add_runtime_dependency 'sass', '~> 3.4', '>= 3.4.18'
  gem.add_runtime_dependency 'haml', '~> 4.0', '>= 4.0.7'
  gem.add_runtime_dependency 'memoist', '~> 0.11.0'
  gem.add_runtime_dependency 'systemu', '~> 2.6', '>= 2.6.5'
  gem.add_runtime_dependency 'erubis', '~> 2.7'
end

