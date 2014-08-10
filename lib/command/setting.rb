# -*- coding: utf-8 -*-
#
#

require_relative "../systemsetting"
require_relative "../novelsetting"

module Command
  class Setting < CommandBase
    def oneline_help
      "各コマンドの設定を変更します"
    end

    class InvalidVariableType < StandardError
      def initialize(type)
        super("値が #{Setting.variable_type_to_description(type).rstrip} ではありません")
      end
    end

    class UnknownVariableType < StandardError
      def initialize(type)
        super("unknwon variable type (:#{type})")
      end
    end

    class InvalidVariableName < StandardError; end

    def initialize
      super("[<name>=<value> ...] [options]")
      @opt.separator <<-EOS

  ・各コマンドの設定の変更が出来ます。
  ・Global な設定はユーザープロファイルに保存され、すべての narou コマンドで使われます。
  ・下の一覧は一部です。すべてを確認するには -a オプションを付けて確認して下さい。

  Local Variable List:
        <name>           <value>              説明
      EOS
      @opt.separator(get_variable_list_strings(:local))

      @opt.separator("\n  Global Variable List:")
      @opt.separator(get_variable_list_strings(:global))

      @opt.separator <<-EOS

  Example:
    narou setting --list
    narou setting convert.no-open=true
    narou setting convert.no-epub=   # 右辺に何も書かないとその設定を削除できる
    narou setting convert.copy_to=C:/dropbox/mobi
    narou s convert.copy_to="C:\\Documents and Settings\\user\\epub"

  Optioins:
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

    def self.variable_type_to_description(type)
      case type
      when :boolean
        "true/false  "
      when :integer
        "整数        "
      when :float
        "小数点数    "
      when :string
        "文字列      "
      when :directory
        "フォルダパス"
      when :file
        "ファイルパス"
      else
        raise UnknownVariableType, type
      end
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
        raise InvalidVariableName, "#{name} は不明な名前です"
      end
      casted_value = string_cast_to_type(value, SETTING_VARIABLES[scope][name][0])
      [scope, casted_value]
    end

    def string_cast_to_type(value, type)
      result = nil
      case type
      when :boolean
        case value
        when /true/i
          result = true
        when /false/i
          result = false
        else
          raise InvalidVariableType, type
        end
      when :integer
        if value =~ /^[+-]?\d+$/
          result = value.to_i
        else
          raise InvalidVariableType, type
        end
      when :float
        if value =~ /^[+-]?\d+\.?\d*$/
          result = value.to_f
        else
          raise InvalidVariableType, type
        end
      when :directory, :file
        if File.method("#{type}?").call(value)
          result = File.expand_path(value)
        else
          raise InvalidVariableType, type
        end
      when :string
        result = value
      else
        raise UnknownVariableType, type
      end
      result
    end

    def output_setting_list
      settings = {
        local: LocalSetting.get["local_setting"],
        global: GlobalSetting.get["global_setting"]
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

    def execute(argv)
      super
      if argv.empty?
        puts @opt.help
        return
      end
      settings = {
        local: LocalSetting.get["local_setting"],
        global: GlobalSetting.get["global_setting"]
      }
      device = Narou.get_device
      self.extend(device.get_hook_module) if device
      argv.each do |arg|
        name, value = arg.split("=", 2).map(&:strip)
        if name == ""
          error "書式が間違っています。変数名=値 のように書いて下さい"
          next
        end
        scope = get_scope_of_variable_name(name)
        unless scope
          error "#{name} という変数は存在しません"
          next
        end
        if value.nil?
          error "書式が間違っています。#{name}=値 のように書いて下さい"
          next
        end
        if value == ""
          hook_call(:modify_settings, settings[scope], name, nil)
          next
        end
        begin
          scope, casted_value = casting_variable(name, value)
        rescue InvalidVariableName, InvalidVariableType => e
          error e.message
          next
        end
        hook_call(:modify_settings, settings[scope], name, casted_value)
      end
      LocalSetting.get.save_settings
      GlobalSetting.get.save_settings
    end

    def modify_settings(scoped_settings, name, value)
      if value.nil?
        scoped_settings.delete(name)
        puts "#{name} の設定を削除しました"
      else
        scoped_settings[name] = value
        puts "#{name} を #{value} に設定しました"
      end
      if name == "device"
        modify_settings_when_device_changed(scoped_settings)
      end
    end

    def modify_settings_when_device_changed(settings)
      device = Device.create(settings["device"])
      message = StringIO.new
      device.get_relative_variables.each do |name, value|
        if value.nil?
          settings.delete(name)
          message.puts "  <red>← #{name} が削除されました</red>".termcolor
        elsif settings[name].nil? || settings[name] != value
          settings[name] = value
          message.puts "  <green>→ #{name} が #{value} に変更されました</green>".termcolor
        end
      end
      if message.length > 0
        puts "端末を#{device.display_name}に指定したことで、以下の関連設定が変更されました"
        puts message.string
      end
    rescue Device::UnknownDevice => e
      error e.message
      puts "設定できるのは #{Device::DEVICES.keys.join(", ")} です"
    end

    def get_variable_list_strings(scope)
      result = ""
      SETTING_VARIABLES[scope].each do |name, info|
        if @options["all"] || info[2] != INVISIBLE
          type_description = self.class.variable_type_to_description(info[0])
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

    TYPE_OF_VALUE = {
      TrueClass => :boolean, FalseClass => :boolean, Fixnum => :integer,
      Float => :float, String => :string
    }

    INVISIBLE = true

    SETTING_VARIABLES = {
      local: {
        # 変数名 => [受け付ける型, 説明(, 不可視化フラグ)]
        "convert.no-epub" => [:boolean, "EPUB変換を無効にするか"],
        "convert.no-mobi" => [:boolean, "MOBI変換を無効にするか"],
        "convert.no-strip" => [:boolean, "MOBIのstripを無効にするか\n" +
                                         " " * 6 + "※注意：KDP用のMOBIはstripしないでください"],
        "convert.no-zip" => [:boolean, "i文庫用のzipファイルを作らない"],
        "convert.no-open" => [:boolean, "変換終了時に保存フォルダを開かない"],
        "convert.copy_to" => [:directory, "変換したらこのフォルダにコピーする\n" +
                                          " " * 6 + "※注意：存在しないフォルダだとエラーになる"],
        "convert.inspect" => [:boolean, "常に変換時に調査結果を表示するか"],
        "download.interval" => [:float, "各話DL時に指定した秒数待機する。デフォルト0"],
        "download.wait-steps" => [:integer, "この値で指定した話数ごとにウェイトを入れる\n" +
                                       " " * 6 + "※注意：11以上を設定してもなろうの場合は10話ごとにウェイトが入ります"],
        "send.without-freeze" => [:boolean, "`全話'送信時に凍結された小説は対象外に"],
        "update.strong" => [:boolean, "更新漏れが無いように改稿日の分は必ずDLする"],
        "device" => [:string, "変換、送信対象の端末(sendの--help参照)"],
        "multiple-delimiter" => [:string, "--multiple指定時の区切り文字"],
      },
      global: {
        "aozoraepub3dir" => [:directory, "AozoraEpub3のあるフォルダを指定", INVISIBLE],
        "difftool" => [:string, "Diffで使うツールのパスを指定する"],
        "difftool.arg" => [:string, "difftoolで使う引数を設定(オプション)"],
        "no-color" => [:boolean, "表示内容に色を付けない"],
        "over18" => [:boolean, "", INVISIBLE],
      }
    }

    NovelSetting::DEFAULT_SETTINGS.each do |default|
      SETTING_VARIABLES[:local]["force." + default[:name]] = [
        #TYPE_OF_VALUE[default[:value].class], "\n      " + default[:help], INVISIBLE
        TYPE_OF_VALUE[default[:value].class], "", INVISIBLE
      ]
    end

    Dir.glob(File.expand_path(File.join(File.dirname(__FILE__), "*.rb"))) do |path|
      cmd_name = File.basename(path, ".rb")
      SETTING_VARIABLES[:local]["default_args." + cmd_name] = [:string, "", INVISIBLE]
    end
  end
end
