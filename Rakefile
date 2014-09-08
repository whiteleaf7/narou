# -*- mode: ruby -*-
# -*- coding: utf-8 -*-

task :default => [:spec]
begin
  require "rspec/core/rake_task"
  RSpec::Core::RakeTask.new(:spec) do |spec|
    spec.pattern = 'spec/**/*_spec.rb'
    spec.rspec_opts = ['-cr spec_helper']
  end
rescue LoadError
end
