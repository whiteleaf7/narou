# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "singleton"

class Narou::Worker
  include Singleton

  def initialize
    @queue = Queue.new
    @worker_thread = nil
  end

  def running?
    !@worker_thread.!
  end

  def start
    return if running?
    Thread.abort_on_exception = true
    @worker_thread = Thread.new do
      loop do
        begin
          @queue.pop.call
        rescue SystemExit
        end
      end
    end
  end

  def stop
    @worker_thread.kill if @worker_thread
    @worker_thread = nil
  end

  def self.push(&block)
    instance.push(&block)
  end

  def push(&block)
    @queue.push(block)
  end
end

