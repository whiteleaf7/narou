# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "singleton"

class Narou::Worker
  include Singleton

  attr_reader :size

  def initialize
    @queue = Queue.new
    @size = 0
    @mutex = Mutex.new
    @worker_thread = nil
    @push_server = Narou::PushServer.instance
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
          q = @queue.pop
          q[:block].call
          countdown if q[:counting]
          notification_queue
        rescue SystemExit
        end
      end
    end
  end

  def stop
    @worker_thread.kill if @worker_thread
    @worker_thread = nil
  end

  #
  # システム用のワーカー追加。内部カウントは増やさない
  #
  def self.push_as_system_worker(&block)
    instance.push(false, &block)
  end

  def self.push(&block)
    instance.push(&block)
  end

  def push(counting = true, &block)
    @queue.push(block: block, counting: counting)
    countup if counting
    notification_queue
  end

  def notification_queue
    @push_server.send_all("notification.queue" => @size)
  end

  def countup
    @mutex.synchronize do
      @size += 1
    end
  end

  def countdown
    @mutex.synchronize do
      @size -= 1
    end
  end
end

