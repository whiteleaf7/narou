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

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  Ruby2.2の公式サポートが2018年3月末で終了することに合わせて、
  Narou.rbも2018年3月末でRuby2.2を動作対象から外します。
  早めにRuby2.4などの新しいバージョンへの移行をオススメします。
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


3.1.9: 2017/10/19
------------------
#### 修正内容
- Ruby 2.4 を使っている場合に mail コマンドを使うと警告メッセージが出ていた
- cleanコマンドでエラーが出る場合があった
- ハーメルンの仕様変更で小説が正しく取得出来なくなる場合があった


3.1.8: 2017/09/30
------------------
#### 仕様変更
- 3.1.7 でデフォルト設定をオフにした「かぎ括弧内自動連結」ですが、一旦またオン
  に戻しました。二転三転して申し訳ありません
- コンソール上でのカラー表示時の処理方法を変更しました(Windowsのみ)
  + narou setting の color-parser を変更することで今までの処理方法に戻せます
  + `narou s color-parser=self` 今までの処理方法(独力でカラー処理)
  + `narou s color-parser=system` システムにカラー表示を任せる(デフォルト)
  + 稀に表示時にエラーになってしまう現象への対策です


3.1.7: 2017/09/28
------------------
#### 仕様変更
- かぎ括弧内自動連結のデフォルト設定をオフに変更しました。
  今までと同じように標準で連結したい場合は default.enable_auto_join_in_brackets
  を有効にして下さい

#### 修正内容
- 小説家になろうのSSL化に対応

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
end

