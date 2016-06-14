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

2.9.3.1 : 2016/06/15
--------------------
#### 修正
- 凍結済みでも待機時間が発生してしまっていたのを修正

2.9.3 : 2016/06/15
------------------
#### WEB UI
- 小説URLもFilterで検索出来るようにしました
	+ NコードがURLに含まれている為、Nコード検索としても使えます
- ダイジェスト化を検知した際にでる選択肢に、「8. 変換する」を追加しました

#### 仕様変更
- `enable_dakuten_font` を復活させました
	+ AozoraEpub3の一文字濁点フォント機能を使った場合、端末でフォントを切り替えた
	  場合に濁点にならない問題があったため、切り替えた場合でも機能するNarou.rbの
	  濁点フォントを再び使えるようにしました
	+ setting.ini で enable_dakuten_font = true とすることで有効になり、false の
	  場合は AozoraEPub3 の一文字濁点フォント機能を使用します。
	  （デフォルトでは false で、 AozoraEpub3 の機能を使います）
- 更新時に１作品ごとに待機時間が入るようになりました
	+ `update.interval` で待機秒数を指定出来ます（ただし、最低2.5秒必要です）
	+ 更新処理の時間も含まれるので、例えば更新処理に１秒かかった場合は待機時間は
	  1.5秒です。2.5秒以上更新や変換にかかった場合は待機時間は発生しません

#### 修正
- i文庫に変換時にカクヨムのサブチャプターが反映されていなかったのを修正
- WEB UIのタグを編集ダイアログ内でタグをソートしていなかったのを修正

#{"*" * 60}
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
  gem.add_runtime_dependency 'open_uri_redirections', '~> 0.2', '>= 0.2.1'
end

