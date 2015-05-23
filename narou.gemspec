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

2.4.1 : 2015/05/24
------------------
#### 追加機能
- WEB UI の Update ボタンに「表示されている小説を更新」、「最新話掲載日を更新」
  という選択肢を追加しました
	+ 表示されている小説を更新：見える範囲内の小説を選択せずに更新出来る。タグ検
	  索やフィルターで絞り込んだあとにいちいち選択する必要がなくなる
	+ 最新話掲載日を更新： `narou u --gl` を WEB UI からも実行出来るようにした物

#### 仕様変更
- WEB UI の項目「最新話掲載日」をArcadia及び暁にも対応させました
	+ それに伴い `narou u --gl` コマンドもArcadiaと暁に対応します
- `narou u --gl` コマンドが凍結済み小説は無視するように変更しました
- 最新話掲載日の経過日時表記に「3d」（3日以内に掲載）を追加しました

#### Bug Fix
- WEB UI のタグ検索が部分一致になっていたのを完全一致に修正しました
- 連続したミュートが正しく変換できていなかったのを修正


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

