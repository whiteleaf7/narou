# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "optparse"

module Command
  class CommandBase
    def initialize(postfix = "")
      @opt = OptionParser.new(nil, 20)
      @opt.banner = ("<bold><green>" +
                     TermColor.escape("Usage: narou #{self.class.to_s.scan(/::(.+)$/)[0][0].downcase} #{postfix}") +
                     "</green></bold>").termcolor
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

    def load_local_settings
      command_prefix = self.class.to_s.scan(/[^:]+$/)[0].downcase
      local_settings = Inventory.load("local_setting", :local)
      local_settings.each do |name, value|
        if name =~ /^#{command_prefix}\.(.+)$/
          @options[$1] = value
        end
      end
    end

    #
    # 普通にコマンドを実行するけど、exit(2) を補足してexitstatus を返す
    # 正常終了なら0
    #
    def self.execute!(argv)
      self.new.execute(argv)
    rescue SystemExit => e
      e.status
    else
      0
    end

    def oneline_help(msg)
      ""
    end

    #
    # 指定したメソッドを呼び出す際に、フック関数があればそれ経由で呼ぶ
    #
    # 指定したメソッドは存在しなくてもいい。存在しなければ空のProcが作られる
    #
    def hook_call(target_method, *argv)
      hook = "hook_#{target_method}"
      target_method_proc = self.method(target_method) rescue ->{}
      if respond_to?(hook)
        self.__send__(hook, *argv, &target_method_proc)
      else
        target_method_proc.call(*argv)
      end
    end

    #
    # 設定の強制設定
    #
    def force_change_settings_function(pairs)
      settings = Inventory.load("local_setting", :local)
      modified = false
      pairs.each do |name, value|
        if settings[name].nil? || settings[name] != value
          settings[name] = value
          puts "<bold><cyan>#{name} を #{value} に強制変更しました</cyan></bold>".termcolor
          modified = true
        end
      end
      settings.save if modified
    end
  end
end
