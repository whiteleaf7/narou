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

1.7.0 : 2014/09/27
------------------
#### 追加機能
- `list` コマンドの `--filter` オプションに `frozen` 及び `nonfrozen` が追加
  されました。凍結状態のフィルタリングが可能になります。また、同時に複数の値を
  受け付けるようになりました

		narou list -f frozen （凍結された小説のみ表示）
		narou list -f nonfrozen （凍結されていない小説のみ表示）
		narou list -f "ss nonfrozen" （凍結されていない短編を表示）

#### 仕様変更
- 英文判定文字に `&:;_-` を追加しました
	+ 今までおかしかった例：Tuez-les tous, Dieu reconnaitra les siens）
- 8文字以上の半角アルファベットは全角に変換せずに半角のままになります

#### Bug Fix
- 行頭が英文で始まる行がオートインデントできていなかったのを修正

#### その他
- 起動にかかる時間及び表示処理速度を向上させました(起動時間がv1.6に比べて約50%短縮)


1.7.1 : 2014/10/16
------------------
#### Bug Fix
- 暁の18禁小説がダウンロードできなかったのを修正


narou コマンドのインストール or アップデートが完了しました。
詳しい説明は `narou help' コマンドをご覧下さい。

  NOTICE
  初めてこのアプリケーションを使う場合、小説管理用のフォルダを初期化する必要があります。
  任意のフォルダで `narou init' を実行して下さい。

#{"*" * 79}
  EOS
  gem.post_install_message = install_message.gsub("\t", "  ")

  gem.required_ruby_version = ">=1.9.3"

  gem.files         = `git ls-files`.split("\n") << Narou.create_git_commit_version
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.add_runtime_dependency 'termcolorlight', '~> 1.0', '>= 1.0.0'
  gem.add_runtime_dependency 'rubyzip', '~> 1.1', '>= 1.1.0'
  gem.add_runtime_dependency 'pony', '~> 1.8'
  gem.add_runtime_dependency 'diff-lcs', '~> 1.2', '>= 1.2.5'
end
