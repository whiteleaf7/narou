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

  # この順番がヘルプに表示される順番
  COMMAND_LIST = {
    "download" => Download,
    "update" => Update,
    "list" => List,
    "convert" => Convert,
    "diff" => Diff,
    "setting" => Setting,
    "alias" => Alias,
    "inspect"=> Inspect,
    "send" => Send,
    "folder" => Folder,
    "browser" => Browser,
    "remove" => Remove,
    "freeze" => Freeze,
    "tag" => Tag,
    "web" => Web,
    "mail" => Mail,
    "backup" => Backup,
    "csv" => Csv,
    "clean" => Clean,
    "help" => Help,
    "version" => Version,
    "init" => Init
  }

  # ショートカット定義
  # COMMAND_LIST の上から順に優先度が高い
  Shortcuts = Hash[*get_list.keys.reverse.map { |s|
    [s[0], s, s[0..1], s]
  }.flatten]
end
