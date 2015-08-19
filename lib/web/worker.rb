# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "singleton"
require_relative "pushserver"

class Narou::Worker
  include Singleton

  attr_reader :size

  def initialize
    @queue = Queue.new
    @size = 0
    @mutex = Mutex.new
    @worker_thread = nil
    @push_server = Narou::PushServer.instance
    @cancel_signal = false
    @thread_of_block_executing = nil
  end

  def running?
    !@worker_thread.!
  end

  def start
    return if running?
    @worker_thread = Thread.new do
      loop do
        begin
          q = @queue.pop
          if canceled?
            @queue.clear
            @cancel_signal = false
          else
            #q[:block].call
            @thread_of_block_executing = Thread.new do
              q[:block].call
            end
            @thread_of_block_executing.tap do |th|
              th.join
              th = nil
            end
          end
        rescue SystemExit
        rescue Exception => e
          # Workerスレッド内での例外は表示するだけしてスレッドは生かしたままにする
          STDOUT.puts $@.shift + ": #{e.message} (#{e.class})"
          $@.each do |b|
            STDOUT.puts "  from #{b}"
          end
        ensure
          if q[:counting]
            countdown
            notification_queue
          end
        end
      end
    end
  end

  def self.cancel
    instance.cancel
  end

  def cancel
    @mutex.synchronize do
      if @size > 0
        @cancel_signal = true
        @size = 0
        @thread_of_block_executing.raise(Interrupt) if @thread_of_block_executing
        Thread.pass
      end
    end
  end

  def self.canceled?
    instance.canceled?
  end

  def canceled?
    @cancel_signal
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
    countup if counting
    notification_queue
    @queue.push(block: block, counting: counting)
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
      @size = 0 if @size < 0
    end
  end
end

