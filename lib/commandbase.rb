# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "optparse"
require "termcolorlight"
require_relative "web/worker"

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
      local_settings = Inventory.load("local_setting")
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
      tag_index = database.tag_indexies
      all_ids = database.ids
      expanded_array = array.map { |arg|
        if arg =~ /\A\d+\z/
          # 優先度はID＞タグのため、数字のみ指定されたら
          # そのIDが存在した場合はIDとみなす
          id = arg.to_i
          next id if database[id]
        end
        ids =
          case arg
          when /\Atag:(.+)\z/
            # tag:タグ名 は直接タグと指定できる形式
            # (数字タグとIDがかぶった場合にタグを指定出来るようにするもの)
            arg = $1
            tag_index[$1]
          when /\A\^tag:(.+)\z/
            # ^tag:タグ名 は除外タグ指定
            arg = $1
            indexies = tag_index[$1]
            indexies.empty? ? [] : all_ids - indexies
          else
            tag_index[arg]
          end
        ids.empty? ? arg : ids
      }.flatten.uniq
      array.replace(expanded_array)
    end

    #
    # コマンドを実行するが、アプリケーションは終了させない
    # (SystemExit を補足し、終了コードを返り値とする)
    #
    def execute!(argv)
      execute(argv)
    rescue SystemExit => e
      e.status
    else
      0
    end

    def self.execute!(argv)
      self.new.execute!(argv)
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
      settings = Inventory.load("local_setting")
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
