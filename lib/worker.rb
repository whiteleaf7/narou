# frozen_string_literal: true

#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "singleton"
require_relative "mixin/all"

module Narou
  class Worker
    include Singleton
    include Mixin::OutputError

    attr_accessor :queue, :mutex, :size, :worker_thread, :cancel_signal, :thread_of_block_executing,
                  :push_server

    def self.run
      instance.start
    end

    def self.push_server=(server)
      instance.push_server = server
    end

    def initialize
      self.queue = Queue.new
      self.mutex = Mutex.new
      self.size = 0
      self.worker_thread = nil
      self.cancel_signal = false
      self.thread_of_block_executing = nil
    end

    def running?
      worker_thread.present?
    end

    def start
      return if running?
      self.worker_thread = Thread.new do
        loop do
          begin
            q = queue.pop
            self.cancel_signal = false
            self.thread_of_block_executing = Thread.new do
              q[:block].call
            end
            thread_of_block_executing.join
            self.thread_of_block_executing = nil
          rescue SystemExit
          rescue Interrupt
            thread_of_block_executing&.raise(Interrupt)
            self.thread_of_block_executing = nil
            sleep 0.1
          rescue Exception => e
            output_error($stdout2, e)
          ensure
            countdown
          end
        end
      end
    end

    def self.join
      instance.join
    end

    def join
      until size.zero?
        unless thread_of_block_executing
          Thread.pass
          next
        end
        thread_of_block_executing&.join
      end
    rescue Interrupt
      thread_of_block_executing&.raise(Interrupt)
      self.thread_of_block_executing = nil
      sleep 0.1
    end

    def self.cancel
      instance.cancel
    end

    def cancel
      mutex.synchronize do
        if size > 0
          self.cancel_signal = true
          self.size = 0
          thread_of_block_executing&.raise(Interrupt)
          self.thread_of_block_executing = nil
          queue.clear
        end
      end
      Thread.pass
    end

    def self.canceled?
      instance.canceled?
    end

    def canceled?
      cancel_signal
    end

    def self.stop
      instance.stop
    end

    def stop
      cancel
      worker_thread&.kill
      self.worker_thread = nil
    end

    def self.push(&block)
      instance.push(&block)
    end

    def push(&block)
      countup
      queue.push(block: block)
    end

    def notification_queue
      push_server&.send_all("notification.queue" => [Narou::WebWorker.instance.size, size])
    end

    def countup
      mutex.synchronize do
        self.size += 1
        notification_queue
      end
    end

    def countdown
      mutex.synchronize do
        self.size -= 1
        self.size = 0 if size < 0
        notification_queue
      end
    end
  end
end

if Narou.concurrency_enabled?
  Thread.abort_on_exception = true
  Narou::Worker.run

  at_exit do
    unless Narou.web?
      Narou::Worker.join
      Narou::Worker.stop
    end
  end
end
