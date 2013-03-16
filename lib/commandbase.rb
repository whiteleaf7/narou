# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "optparse"

module Command
  class CommandBase
    def initialize(postfix = "")
      @opt = OptionParser.new(nil, 20)
      @opt.banner = ("<green>" +
                     TermColor.escape("Usage: narou #{self.class.to_s.scan(/::(.+)$/)[0][0].downcase} #{postfix}") +
                     "</green>").termcolor
      @options = {}
    end

    def execute(argv)
      @opt.parse!(argv)
    rescue OptionParser::InvalidOption => e
      error "不正なオプションです(#{e})"
      exit 1
    rescue OptionParser::MissingArgument => e
      error "オプションの引数が不正です(#{e})"
      exit 1
    end

    #
    # 普通にコマンドを実行するけど、exit(2) を補足してexitstatus を返す
    # 正常終了なら0
    #
    def self.execute_and_rescue_exit(argv)
      self.new.execute(argv)
    rescue SystemExit => e
      e.status
    else
      0
    end

    def oneline_help(msg)
      ""
    end
  end
end
