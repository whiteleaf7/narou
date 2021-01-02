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

3.5.1: 2020/03/21
-----------------
#### 修正内容
- 小説家になろう系列の挿絵をダウンロード時に、サムネイル画像を取得するように
  なってしまっていたのを修正
- Ruby 2.7 で narou setting -l を実行時に警告が大量に出ていたのを修正

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
  gem.add_runtime_dependency 'sinatra', '~> 2.0', '>= 2.0.8.1'
  gem.add_runtime_dependency 'sinatra-contrib', '~> 2.0', '>= 2.0.8.1'
  gem.add_runtime_dependency 'tilt', '~> 2.0', '>= 2.0.10'
  gem.add_runtime_dependency 'sassc', '~> 2.4'
  gem.add_runtime_dependency 'haml', '>= 5.1.2', '< 6'
  gem.add_runtime_dependency 'memoist', '~> 0.11.0'
  gem.add_runtime_dependency 'systemu', '~> 2.6', '>= 2.6.5'
  gem.add_runtime_dependency 'erubis', '~> 2.7'
  gem.add_runtime_dependency 'open_uri_redirections', '~> 0.2', '>= 0.2.1'
  gem.add_runtime_dependency 'activesupport', '>= 5.2', '< 7.0'
  gem.add_runtime_dependency 'unicode-display_width', '~> 1.4'
  gem.add_runtime_dependency 'webrick', '~> 1.7'

  gem.add_development_dependency 'rspec', '~> 3.9'
  gem.add_development_dependency 'rspec-retry', '~> 0.6'
  gem.add_development_dependency 'rspec_junit_formatter', '~> 0.4'
  gem.add_development_dependency 'timecop', '~> 0.9'
  gem.add_development_dependency 'pry', '~> 0.12'
  gem.add_development_dependency 'pry-byebug', '~> 3.8'
  gem.add_development_dependency 'awesome_print', '~> 1.8'
  gem.add_development_dependency 'simplecov', '~> 0.20'
end

