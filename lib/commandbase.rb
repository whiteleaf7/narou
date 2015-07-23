# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "optparse"

module Command
  class CommandBase
    # postfixies は改行で区切ることで2パターン以上記述できる
    def initialize(postfixies = "")
      @opt = OptionParser.new(nil, 20)
      command_name = self.class.to_s.scan(/::(.+)$/)[0][0].downcase
      banner = postfixies.split("\n").map.with_index { |postfix, i|
        (i == 0 ? "Usage: " : "   or: ") + "narou #{command_name} #{postfix}"
      }.join("\n")
      @opt.banner = "<bold><green>#{TermColorLight.escape(banner)}</green></bold>".termcolor
      @options = {}
      # ヘルプを見やすく色付け
      def @opt.help
        msg = super
        # 見出し部分
        msg.gsub!(/((?:Examples|Options|Configuration|[^\s]+? Variable List):)/) do
          "<underline><bold>#{$1}</bold></underline>".termcolor
        end
        # Examples のコメント部分
        msg.gsub!(/(#.+)$/) do
          "<cyan>#{TermColorLight.escape($1)}</cyan>".termcolor
        end
        # 文字列部分
        msg.gsub!(/(".+?")/) do
          "<yellow>#{TermColorLight.escape($1)}</yellow>".termcolor
        end
        msg
      end
    end

    def execute(argv)
      @options.clear
      load_local_settings
      @opt.parse!(argv)
    rescue OptionParser::InvalidOption => e
      error "不明なオプションです(#{e})"
      exit Narou::EXIT_ERROR_CODE
    rescue OptionParser::InvalidArgument => e
      error "オプションの引数が正しくありません(#{e})"
      exit Narou::EXIT_ERROR_CODE
    rescue OptionParser::MissingArgument => e
      error "オプションの引数が指定されていないか正しくありません(#{e})"
      exit Narou::EXIT_ERROR_CODE
    rescue OptionParser::AmbiguousOption => e
      error "曖昧な省略オプションです(#{e})"
      exit Narou::EXIT_ERROR_CODE
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
    # タグ情報をID情報に展開する
    #
    def tagname_to_ids(array)
      database = Database.instance
      tag_index = Hash.new { [] }
      database.each do |id, data|
        tags = data["tags"] || []
        tags.each do |tag|
          tag_index[tag] |= [id]
        end
      end
      array.map! { |arg|
        if arg =~ /^[0-9]+$/
          # 優先度はID＞タグのため、数字のみ指定されたら
          # そのIDが存在した場合はIDとみなす
          next arg if database[arg.to_i]
        end
        if arg =~ /^tag:(.+)$/
          # tag:タグ名 は直接タグと指定できる形式
          # (数字タグとIDがかぶった場合にタグを指定出来るようにするもの)
          arg = $1
        end
        ids = tag_index[arg]
        ids.empty? ? arg : ids
      }.flatten!
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

    def self.oneline_help
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
