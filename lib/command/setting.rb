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

    class InvalidSelectValue < StandardError; end

    def self.oneline_help
      "各コマンドの設定を変更します"
    end

    def initialize
      super("[<name>=<value> ...] [options]")
      @opt.separator <<-EOS

  ・各コマンドの設定の変更が出来ます。
  ・Global な設定はユーザープロファイルに保存され、すべての narou コマンドで使われます
  ・下の一覧は一部です。すべてを確認するには -a オプションを付けて確認して下さい
  ・default. で始まる設定は、setting.ini で未設定時の項目の挙動を指定することが出来ます
  ・force. で始まる設定は、setting.ini や default.* 等の指定を全て無視して項目の挙動を強制出来ます

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
      variable_definition = SETTING_VARIABLES[scope][name]
      case variable_definition[:type]
      when :select
        select_values = variable_definition[:select_keys]
        unless select_values.include?(value)
          raise InvalidSelectValue, "不明な値です。#{select_values.join(", ")} の中から指定して下さい"
        end
        casted_value = value
      when :multiple
        select_values = variable_definition[:select_keys]
        value.split(",").each do |input_value|
          unless select_values.include?(input_value)
            raise InvalidSelectValue, "不明な値です。#{select_values.join(", ")} の中から指定して下さい"
          end
        end
        casted_value = value
      else
        casted_value = Helper.string_cast_to_type(value, variable_definition[:type])
      end
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

    def sweep_dust_variable(target_name, settings)
      deleted = false
      settings.each_value do |scoped_settings|
        if scoped_settings.has_key?(target_name)
          scoped_settings.delete(target_name)
          deleted = true
        end
      end
      deleted
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
        if value.nil?
          output_error("書式が間違っています。#{name}=値 のように書いて下さい", name)
          next
        end
        scope = get_scope_of_variable_name(name)
        unless scope
          if value == ""
            # 定義上ではすでに存在しないが、設定ファイルには残っている古い変数
            # を削除できるようにする
            if sweep_dust_variable(name, settings)
              puts "#{name} の設定を削除しました"
            else
              output_error("#{name} という変数は存在しません", name)
            end
          else
            output_error("#{name} という変数は設定出来ません", name)
          end
          next
        end
        if value == ""
          hook_call(:modify_settings, settings[scope], name, nil)
          next
        end
        begin
          scope, casted_value = casting_variable(name, value)
        rescue Helper::InvalidVariableName, Helper::InvalidVariableType, InvalidSelectValue => e
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
        if @options["all"] || !info[:invisible]
          type_description = Helper.variable_type_to_description(info[:type])
          result << "    <bold><green>#{name.ljust(18)}</green></bold> #{type_description} #{info[:help]}\n".termcolor
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

    SETTING_VARIABLES = {
      local: {
        # 変数名 => { type: 受け付ける型, help: 説明[, invisible: 不可視化フラグ,
        #             select_keys: 選択肢型の時のキー(配列),
        #             select_summaries: 選択肢型の時のキーの概要(配列)] }
        "device" => {
          type: :select,
          help: "変換、送信対象の端末(sendの--help参照)",
          select_keys: Device::DEVICES.keys,
          select_summaries: Device::DEVICES.values.map { |d| d::DISPLAY_NAME }
        },
        "update.strong" => {
          type: :boolean, help: "更新漏れが無い様に改稿日の分は必ずDLするか"
        },
        "update.logging" => {
          type: :boolean, help: "更新時のログを保存するかどうか"
        },
        "update.convert-only-new-arrival" => {
          type: :boolean, help: "更新時に新着のみ変換を実行するかどうか"
        },
        "update.sort-by" => {
          type: :select,
          help: "アップデートを指定した項目順で行う\n#{Narou.update_sort_key_summaries(40)}",
          select_keys: Narou::UPDATE_SORT_KEYS.keys,
          select_summaries: Narou::UPDATE_SORT_KEYS.values
        },
        "convert.copy-to" => {
          type: :directory,
          help: "変換したらこのフォルダにコピーする\n" \
                "      ※注意：存在しないフォルダだとエラーになる"
        },
        "convert.copy-to-grouping" => {
          type: :boolean, help: "copy-toで指定したフォルダの中で更にdevice毎にフォルダを振り分ける"
        },
        "convert.copy_to" => {
          type: :directory, help: "copy-toの昔の書き方(非推奨)", invisible: true
        },
        "convert.no-epub" => {
          type: :boolean, help: "EPUB変換を無効にするか", invisible: true
        },
        "convert.no-mobi" => {
          type: :boolean, help: "MOBI変換を無効にするか", invisible: true
        },
        "convert.no-strip" => {
          type: :boolean,
          help: "MOBIのstripを無効にするか\n" \
                "      ※注意：KDP用のMOBIはstripしないでください",
          invisible: true
        },
        "convert.no-zip" => {
          type: :boolean, help: "i文庫用のzipファイル作成を無効にするか", invisible: true
        },
        "convert.no-open" => {
          type: :boolean, help: "変換時に保存フォルダを開かないようにするか"
        },
        "convert.inspect" => {
          type: :boolean, help: "常に変換時に調査結果を表示するか"
        },
        "convert.multi-device" => {
          type: :multiple,
          help: "複数の端末用に同時に変換する。deviceよりも優先される。" \
                "端末名をカンマ区切りで入力。ただのEPUBを出力したい場合はepubを指定",
          select_keys: Device::DEVICES.keys,
          select_summaries: Device::DEVICES.values.map { |d| d::DISPLAY_NAME }
        },
        "download.interval" => {
          type: :float, help: "各話DL時に指定した秒数待機する。デフォルト0"
        },
        "download.wait-steps" => {
          type: :integer,
          help: "この値で指定した話数ごとにウェイトを入れる\n" \
                "      ※注意：11以上を設定してもなろうの場合は10話ごとにウェイトが入ります"
        },
        "download.use-subdirectory" => {
          type: :boolean,
          help: "小説を一定数ごとにサブフォルダへ分けて保存するか\n" \
                "      ※注意：小説を大量に同一フォルダに保存するとパフォーマンスが劣化する回避策"
        },
        "send.without-freeze" => {
          type: :boolean, help: "一括送信時に凍結された小説は対象外に"
        },
        "send.backup-bookmark" => {
          type: :boolean, help: "一括送信時に栞データを自動でバックアップするか(KindlePW系用)"
        },
        "multiple-delimiter" => {
          type: :string, help:  "--multiple指定時の区切り文字"
        },
      },
      global: {
        "aozoraepub3dir" => {
          type: :directory, help: "AozoraEpub3のあるフォルダを指定", invisible: true
        },
        "difftool" => {
          type: :string, help: "Diffで使うツールのパスを指定する"
        },
        "difftool.arg" => {
          type: :string, help: "difftoolで使う引数を設定(オプション)"
        },
        "no-color" => {
          type: :boolean, help: "カラー表示を無効にするか"
        },
        "server-port" => {
          type: :integer, help: "WEBサーバ起動時のポート"
        },
        "server-bind" => {
          type: :string, help: "WEBサーバのホスト制限(未設定時:起動PCのIP)", invisible: true
        },
        "over18" => {
          type: :boolean, help: "18歳以上かどうか", invisible: true
        },
        "dismiss-notice" => {
          type: :boolean, help: "お知らせを消すかどうか", invisible: true
        },
      }
    }

    %w(default force).each do |kind|
      NovelSetting::ORIGINAL_SETTINGS.each do |default|
        value = {
          type: default[:type],
          help: "\n      " + default[:help],
          invisible: true,
          select_keys: default[:select_keys],
          select_summaries: default[:select_summaries]
        }
        SETTING_VARIABLES[:local]["#{kind}." + default[:name]] = value
      end
    end

    Dir.glob(File.expand_path(File.join(File.dirname(__FILE__), "*.rb"))) do |path|
      cmd_name = File.basename(path, ".rb")
      SETTING_VARIABLES[:local]["default_args." + cmd_name] = {
        type: :string, help: "#{cmd_name} コマンドのデフォルトオプション", invisible: true
      }
    end

    SETTING_VARIABLES.freeze
  end
end
