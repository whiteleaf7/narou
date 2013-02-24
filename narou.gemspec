# -*- mode: ruby -*-
# -*- encoding: utf-8 -*-
#lib = File.expand_path('../lib', __FILE__)
#$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
#require 'narou/version'
require_relative "lib/version"

def create_git_commit_version
  File.write("comitversion", `git describe --always`.strip)
  "commitversion"
end

Gem::Specification.new do |gem|
  gem.name          = "narou"
  gem.version       = Version
  gem.authors       = ["whiteleaf7"]
  gem.email         = ["2nd.leaf@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = "https://github.com/whiteleaf7/narou"

  gem.files         = `git ls-files`.split($/) << create_git_commit_version
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  #gem.add_dependency ""
end
