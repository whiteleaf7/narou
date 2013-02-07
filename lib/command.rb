# -*- Encoding: UTF-8 -*-
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
    #"new" => New.new,
    "convert" => Convert.new,
    #"interactive" => Interactive.new,
    "help" => Help.new,
    "version" => Version.new
  }

  Shortcuts = Hash[*get_list.keys.map { |s|
    [s[0], s, s[0..1], s]
  }.flatten]
end
