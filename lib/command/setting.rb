# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../inventory"
require_relative "../novelsetting"
require_relative "../eventable"

module Command
  class Setting < CommandBase
    include Narou::Eventable

    def self.oneline_help
      "各コマンドの設定を変更します"
    end

    def initialize
      super("[<name>=<value> ...] [options]")
      @opt.separator <<-EOS

  ・各コマンドの設定の変更が出来ます。
  ・Global な設定はユーザープロファイルに保存され、すべての narou コマンドで使われます
  ・下の一覧は一部です。すべてを確認するには -a オプションを付けて確認して下さい

  Local Variable List:
        <name>           <value>              説明
      EOS
      @opt.separator(get_variable_list_strings(:local))

      @opt.separator("\n  Global Variable List:")
      @opt.separator(get_variable_list_strings(:global))

      @opt.separator <<-EOS

  Examples:
    narou setting --list
    narou setting convert.no-open=true
    narou setting convert.no-epub=   # 右辺に何も書かないとその設定を削除できる
    narou setting convert.copy-to=C:/dropbox/mobi
    narou s convert.copy-to="C:\\Documents and Settings\\user\\epub"

  Options:
      EOS
      @opt.on("-l", "--list", "現在の設定値を確認する") {
        output_setting_list
        exit 0
      }
      @opt.on("-a", "--all", "設定できる全ての変数名を表示する") {
        @options["all"] = true
        display_variable_list
        exit 0
      }
    end

    def get_scope_of_variable_name(name)
      [:local, :global].each do |scope|
        if SETTING_VARIABLES[scope].include?(name)
          return scope
        end
      end
      nil
    end

    #
    # 値の文字列を設定に基づいた型にキャストして、[scope, value] 形式で返す
    # 不正な設定名もしくは値の場合は例外を吐く
    #
    def casting_variable(name, value)
      scope = get_scope_of_variable_name(name)
      unless scope
        raise Helper::InvalidVariableName, "#{name} は不明な名前です"
      end
      casted_value = Helper.string_cast_to_type(value, SETTING_VARIABLES[scope][name][0])
      [scope, casted_value]
    end

    def output_setting_list
      settings = {
        local: Inventory.load("local_setting", :local),
        global: Inventory.load("global_setting", :global)
      }
      settings.each do |scope, scoped_settings|
        puts "[#{scope.capitalize} Variables]"
        scoped_settings.each do |name, value|
          if value =~ / /
            value = "'#{value}'"
          end
          puts "<bold><green>#{name}</green></bold>=#{value}".termcolor
        end
      end
    end

    def output_error(msg, name = nil)
      @error_count += 1
      error msg
      trigger(:error, msg, name)
    end

    def execute(argv)
      super
      if argv.empty?
        puts @opt.help
        return
      end
      settings = {
        local: Inventory.load("local_setting", :local),
        global: Inventory.load("global_setting", :global)
      }
      device = Narou.get_device
      @error_count = 0
      self.extend(device.get_hook_module) if device
      argv.each do |arg|
        name, value = arg.split("=", 2).map(&:strip)
        if name == ""
          output_error("書式が間違っています。変数名=値 のように書いて下さい")
          next
        end
        scope = get_scope_of_variable_name(name)
        unless scope
          output_error("#{name} という変数は存在しません", name)
          next
        end
        if value.nil?
          output_error("書式が間違っています。#{name}=値 のように書いて下さい", name)
          next
        end
        if value == ""
          hook_call(:modify_settings, settings[scope], name, nil)
          next
        end
        begin
          scope, casted_value = casting_variable(name, value)
        rescue Helper::InvalidVariableName, Helper::InvalidVariableType => e
          output_error(e.message, name)
          next
        end
        hook_call(:modify_settings, settings[scope], name, casted_value)
      end
      settings[:local].save
      settings[:global].save
      exit @error_count if @error_count > 0
    end

    def modify_settings(scoped_settings, name, value)
      if value.nil?
        scoped_settings.delete(name)
        puts "#{name} の設定を削除しました"
      else
        scoped_settings[name] = value
        puts "#{name} を #{value} に設定しました"
      end
      if name == "device" && value
        modify_settings_when_device_changed(scoped_settings)
      end
    end

    def modify_settings_when_device_changed(settings)
      device = Device.create(settings["device"])
      message = StringIO.new
      device.get_relative_variables.each do |name, value|
        if value.nil?
          settings.delete(name)
          message.puts "  <bold><red>← #{name} が削除されました</red></bold>".termcolor
        elsif settings[name].nil? || settings[name] != value
          settings[name] = value
          message.puts "  <bold><green>→ #{name} が #{value} に変更されました</green></bold>".termcolor
        end
      end
      if message.length > 0
        puts "端末を#{device.display_name}に指定したことで、以下の関連設定が変更されました"
        puts message.string
      end
    rescue Device::UnknownDevice => e
      output_error("#{e.message}\n設定できるのは #{Device::DEVICES.keys.join(", ")} です", "device")
    end

    def get_variable_list_strings(scope)
      result = ""
      SETTING_VARIABLES[scope].each do |name, info|
        if @options["all"] || info[2] != INVISIBLE
          type_description = Helper.variable_type_to_description(info[0])
          result << "    <bold><green>#{name.ljust(18)}</green></bold> #{type_description} #{info[1]}\n".termcolor
        end
      end
      result
    end

    def display_variable_list
      puts "Local Variable List:"
      puts get_variable_list_strings(:local).gsub(/^ {4}/, "")
      puts
      puts "Global Variable List:"
      puts get_variable_list_strings(:global).gsub(/^ {4}/, "")
    end

    def self.get_setting_variables
      SETTING_VARIABLES
    end

    INVISIBLE = true

    SETTING_VARIABLES = {
      local: {
        # 変数名 => [受け付ける型, 説明(, 不可視化フラグ)]
        "convert.no-epub" => [:boolean, "EPUB変換を無効にするか"],
        "convert.no-mobi" => [:boolean, "MOBI変換を無効にするか"],
        "convert.no-strip" => [:boolean, "MOBIのstripを無効にするか\n" +
                                         " " * 6 + "※注意：KDP用のMOBIはstripしないでください"],
        "convert.no-zip" => [:boolean, "i文庫用のzipファイル作成を無効にするか"],
        "convert.no-open" => [:boolean, "変換時に保存フォルダを開かないようにするか"],
        "convert.copy-to" => [:directory, "変換したらこのフォルダにコピーする\n" +
                                          " " * 6 + "※注意：存在しないフォルダだとエラーになる"],
        "convert.copy_to" => [:directory, "copy-toの昔の書き方(非推奨)", INVISIBLE],
        "convert.copy-epub" => [:boolean, "copy-toでMOBIコピー時にEPUBも同時にコピーする"],
        "convert.inspect" => [:boolean, "常に変換時に調査結果を表示するか"],
        "download.interval" => [:float, "各話DL時に指定した秒数待機する。デフォルト0"],
        "download.wait-steps" => [:integer, "この値で指定した話数ごとにウェイトを入れる\n" +
                                       " " * 6 + "※注意：11以上を設定してもなろうの場合は10話ごとにウェイトが入ります"],
        "download.use-subdirectory" => [:boolean, "小説を一定数ごとにサブフォルダへ分けて保存するか\n" +
                                                  " " * 6 + "※注意：小説を大量に同一フォルダに保存するとパフォーマンスが劣化する回避策"],
        "send.without-freeze" => [:boolean, "`全話'送信時に凍結された小説は対象外に"],
        "update.strong" => [:boolean, "更新漏れが無い様に改稿日の分は必ずDLするか"],
        "device" => [:string, "変換、送信対象の端末(sendの--help参照)"],
        "multiple-delimiter" => [:string, "--multiple指定時の区切り文字"],
      },
      global: {
        "aozoraepub3dir" => [:directory, "AozoraEpub3のあるフォルダを指定", INVISIBLE],
        "difftool" => [:string, "Diffで使うツールのパスを指定する"],
        "difftool.arg" => [:string, "difftoolで使う引数を設定(オプション)"],
        "no-color" => [:boolean, "カラー表示を無効にするか"],
        "server-port" => [:integer, "WEBサーバ起動時のポート"],
        "server-bind" => [:string, "WEBサーバのホスト制限(未設定時:起動PCのIP)", INVISIBLE],
        "over18" => [:boolean, "18歳以上かどうか", INVISIBLE],
      }
    }

    NovelSetting::DEFAULT_SETTINGS.each do |default|
      SETTING_VARIABLES[:local]["force." + default[:name]] = [
        Helper.type_of_value(default[:value]), "\n      " + default[:help], INVISIBLE
      ]
    end

    Dir.glob(File.expand_path(File.join(File.dirname(__FILE__), "*.rb"))) do |path|
      cmd_name = File.basename(path, ".rb")
      SETTING_VARIABLES[:local]["default_args." + cmd_name] =
        [:string, "#{cmd_name} コマンドのデフォルトオプション", INVISIBLE]
    end

    SETTING_VARIABLES.freeze
  end
end
