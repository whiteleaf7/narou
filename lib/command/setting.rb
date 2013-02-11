# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../localsetting"

module Command
  class Setting < CommandBase
    def oneline_help
      "各コマンドの設定を変更します"
    end

    SETTING_VARIABLES = {
      # 変数名  => [受け付ける型, 説明]
      "convert.no-epub" => [:boolean, "EPUB変換を無効にするかどうか"],
      "convert.no-mobi" => [:boolean, "MOBI変換を無効にするかどうか"],
      "convert.no-open" => [:boolean, "変換終了時に保存フォルダを開かない"],
      "convert.copy_to" => [:directory, "変換したらこのフォルダにコピーする\n" +
                                    "    ※存在しないフォルダだとエラーになるので注意"],
      "aozoraepub3path" => [:directory, "AozoraEpub3のあるフォルダを変更"]
    }

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

  Variable List:
      EOS

      @opt.separator("        <name>           <value>              説明")
      SETTING_VARIABLES.each do |name, info|
        type_description = self.class.variable_type_to_description(info[0])
        @opt.separator("    #{name.ljust(18)} #{type_description} #{info[1]}")
      end

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
    end

    def self.variable_type_to_description(type)
      case type
      when :boolean
        "true/false  "
      when :integer
        "数値        "
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

    def valid_variable_name?(name)
      SETTING_VARIABLES.include?(name)
    end

    #
    # 名前と値の有効性を確認し、値の文字列を設定に基づいた型にキャストして返す
    # 不正な設定名もしくは値の場合は例外を吐く
    #
    def validate_variable(name, value)
      unless valid_variable_name?(name)
        raise InvalidVariableName, "#{name} は不明な名前です"
      end
      casted_value = string_cast_to_type(value, SETTING_VARIABLES[name][0])
      casted_value
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
      LocalSetting.get["local_setting"].each do |name, value|
        puts "#{name}=#{value}"
      end
    end

    def execute(argv)
      super
      if argv.empty?
        puts @opt.help
        return
      end
      local_settings = LocalSetting.get["local_setting"]
      argv.each do |arg|
        name, value = arg.split("=", 2).map(&:strip)
        if value.nil?
          if valid_variable_name?(name)
            warn "書式が間違っています。#{name}=値 のように書いて下さい"
          else
            warn "書式が間違っています。"
          end
          next
        end
        if value == ""
          local_settings.delete(name)
          puts "#{name} の設定を削除しました"
          next
        end
        begin
          casted_value = validate_variable(name, value)
        rescue InvalidVariableName, InvalidVariableType => e
          warn e.message
          next
        end
        local_settings[name] = casted_value
        puts "#{name} を #{casted_value} に設定しました"
      end
      LocalSetting.get.save_settings
    end
  end
end
