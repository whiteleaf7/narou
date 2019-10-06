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

3.4.7: 2019/10/06
-----------------
#### 修正内容
- 3.4.6 の修正では更新日時が正常に取れていなかったのを修正
  - **注意**
    3.4.6 で更新した小説の目次データは壊れているので、そのまま 3.4.7 で更新する
    と大量の再ダウンロードが発生します。目次データを復元するコマンドを用意した
    のでそれを使用して下さい
  - コマンドライン上で `narou restore346` を実行すると、壊れた目次データを復元
    出来ます

#{"*" * 60}
  EOS
  gem.post_install_message = install_message.gsub("\t", "  ")

  gem.required_ruby_version = ">=2.3.0"

  gem.files = `git ls-files`.split("\n").reject { |fn| fn =~ %r!^spec/|^"spec! } << Narou.create_git_commit_version
  gem.executables = gem.files.grep(%r!^bin/!).map { |f| File.basename(f) }

  gem.add_runtime_dependency 'termcolorlight', '~> 1.0', '>= 1.1.1'
  gem.add_runtime_dependency 'rubyzip', '~> 2.0', '>= 2.0.0'
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

