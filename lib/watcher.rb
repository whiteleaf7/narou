# -*- coding: utf-8 -*-
#
# Copyright 2014 whiteleaf. All rights reserved.
#

module Watcher
  extend self

  @@counter = {}

  def included(klass)
    return if @@counter[klass]
    @@counter[klass] = {}
    mod = Module.new
    klass.class_eval do
      alias_method(:org_initialize, :initialize)
      define_method(:initialize) do |*init_argv, &init_b|
        self.methods.each do |name|
          next if Object.methods.include?(name) || name =~ /^__.+?__$/ || name == :included
          @@counter[klass][name] = 0
          mod.__send__(:define_method, name) do |*argv, &b|
            @@counter[klass][name] += 1
            super(*argv, &b)
          end
        end
        self.extend mod
        org_initialize(*init_argv, &init_b)
      end
    end
  end

  def __display_report__
    puts
    puts "=================="
    puts "  Watcher Report"
    puts "=================="
    @@counter.each do |klass, data|
      next if data.count == 0
      puts "class #{klass}"
      data.select { |_, c| c > 0 }.each do |name, count|
        puts "#{name.to_s.rjust(30)} = #{count}"
      end
      not_call_methods = data.select { |_, c| c == 0 }.keys
      if not_call_methods.count > 0
        puts "* not call methods *"
        puts not_call_methods.join(", ")
      end
      puts
    end
  end

  def __regist__(*klasses)
    klasses.each do |klass|
      klass.__send__(:include, self)
    end
  end
end

at_exit do
  Watcher.__display_report__
end
