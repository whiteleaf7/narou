# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "optparse"
require_relative "commandbase"
Dir.glob(File.expand_path(File.join(File.dirname(__FILE__), "command", "*.rb"))) do |path|
  require path
end

module Command
  #
  # コマンド一覧を取得
  #
  def self.get_list
    COMMAND_LIST
  end

  COMMAND_LIST = {
    "download" => Download.new,
    "update" => Update.new,
    "list" => List.new,
    "convert" => Convert.new,
    "diff" => Diff.new,
    "setting" => Setting.new,
    "alias" => Alias.new,
    "inspect"=> Inspect.new,
    "send" => Send.new,
    "folder" => Folder.new,
    "browser" => Browser.new,
    "remove" => Remove.new,
    "freeze" => Freeze.new,
    "flag" => Flag.new,
    "mail" => Mail.new,
    "backup" => Backup.new,
    "help" => Help.new,
    "version" => Version.new,
    "init" => Init.new
  }

  # ショートカット定義
  # COMMAND_LIST の上から順に優先度が高い
  Shortcuts = Hash[*get_list.keys.reverse.map { |s|
    [s[0], s, s[0..1], s]
  }.flatten]
end
