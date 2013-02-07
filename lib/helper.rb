# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "open3"

#
# 雑多なお助けメソッド群
#
module Helper
  def self.os_windows?
    RUBY_PLATFORM =~ /mswin(?!ce)|mingw|cygwin|bccwin/i
  end

  class AsyncCommand
    def self.exec(command, &block)
      async_command = new(command)
      while async_command.running?
        block.call
        sleep(0.5)
      end
      async_command.response
    end

    def initialize(command)
      @command_response = nil
      @command_running = true
      Thread.new do
        @command_response = Open3.capture3(command)
        @command_running = false
      end
    end

    def running?
      @command_running
    end

    def response
      @command_response
    end
  end
end
