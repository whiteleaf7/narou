# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "narou"
require_relative "command"
require_relative "helper"
require_relative "inventory"

module CommandLine
  extend self

  def run(argv)
    if Helper.os_windows?
      argv.map! do |arg|
        arg.encode(Encoding::UTF_8)
      end
    end
    argv.unshift("help") if argv.empty?
    arg = argv.shift.downcase
    arg = Command::Shortcuts[arg] || arg
    arg = "help" if arg == "-h" || arg == "--help"
    arg = "version" if arg == "-v" || arg == "--version"
    unless Narou.already_init?
      unless ["help", "version", "init"].include?(arg)
        arg = "help"
      end
    end
    unless Command.get_list.include?(arg)
      error "不明なコマンドです"
      puts
      arg = "help"
    end
    if argv.empty?
      argv += load_default_arguments(arg)
    end
    if argv.delete("--multiple")
      multiple_argument_extract(argv)
    end
    Command.get_list[arg].new.execute(argv)
  end

  def load_default_arguments(cmd)
    default_arguments_list = Inventory.load("local_setting", :local)
    (default_arguments_list["default_args.#{cmd}"] || "").split
  end

  #
  # 引数をスペース以外による区切り文字で展開する
  #
  def multiple_argument_extract(argv)
    delimiter = Inventory.load("local_setting", :local)["multiple-delimiter"] || ","
    argv.map! { |arg|
      arg.split(delimiter)
    }.flatten!
  end
end
