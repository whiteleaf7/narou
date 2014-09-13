# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

class Narou::Worker
  include Singleton

  def initialize
    @queue = Queue.new
  end

  def start
    Thread.new do
      loop do
        @queue.pop.call
      end
    end
  end

  def request(&block)
    @queue.push(block)
  end
end

