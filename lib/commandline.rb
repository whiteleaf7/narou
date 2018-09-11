# frozen_string_literal: true

#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "narou"
require_relative "command"
require_relative "helper"
require_relative "inventory"

module CommandLine
  module_function

  def run(*argv, catch_exit: false)
    argv.flatten!
    argv_for_windows(argv)
    cmd_name = take_command_name(argv)
    proc_default_arguments(argv, cmd_name)
    if argv.delete("--multiple")
      multiple_argument_extract(argv)
    end
    unless STDIN.tty?
      # pipeで接続された場合、標準入力からIDリストを受け取って引数に繋げる
      argv += (STDIN.gets || "").split
    end
    command = Command.get_list[cmd_name]
    if catch_exit
      command.execute!(argv)
    else
      command.new.execute(argv)
    end
  ensure
    Command::Convert.display_sending_error_list
  end

  #
  # exit を捕捉して終了コードを返す
  #
  def run!(*argv)
    run(*argv, catch_exit: true)
  end

  def load_default_arguments(cmd)
    default_arguments_list = Inventory.load("local_setting")
    (default_arguments_list["default_args.#{cmd}"] || "").split
  end

  def argv_for_windows(argv)
    return unless Helper.os_windows?
    argv.map! do |arg|
      arg&.encode(Encoding::UTF_8)
    end
  end

  def take_command_name(argv)
    argv.unshift("help") if argv.empty?
    name = argv.shift.downcase
    name = Command::Shortcuts[name] || name
    name = case name
           when "-v", "--version"
             "version"
           when "-h", "--help"
             "help"
           else
             name
           end
    unless Narou.already_init?
      unless %w(help version init).include?(name)
        name = "help"
      end
    end
    unless Command.get_list.include?(name)
      error "不明なコマンドです。narou help を確認してください"
      exit Narou::EXIT_ERROR_CODE
    end
    name
  end

  def proc_default_arguments(argv, name)
    if argv.empty? && STDIN.tty?
      argv.concat(load_default_arguments(name))
    end
  end

  #
  # 引数をスペース以外による区切り文字で展開する
  #
  def multiple_argument_extract(argv)
    delimiter = Inventory.load("local_setting")["multiple-delimiter"] || ","
    argv.map! { |arg|
      arg.split(delimiter)
    }.flatten!
  end
end
