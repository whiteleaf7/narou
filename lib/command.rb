# -*- coding: UTF-8 -*-
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
    "alias" => Alias.new,
    "error"=> Error.new,
    "remove" => Remove.new,
    "setting" => Setting.new,
    "folder" => Folder.new,
    "browser" => Browser.new,
    "freeze" => Freeze.new,
    "help" => Help.new,
    "version" => Version.new,
    #"new" => New.new,
    #"interactive" => Interactive.new,
    "init" => Init.new   # 特殊コマンドなので一覧には表示されない
  }

  # ショートカット定義
  # COMMAND_LIST の上から順に優先度が高い
  Shortcuts = Hash[*get_list.keys.reverse.map { |s|
    [s[0], s, s[0..1], s]
  }.flatten]
end
