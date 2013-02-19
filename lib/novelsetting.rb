# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "fileutils"
require_relative "ini"

class NovelSetting
  INI_NAME = "setting.ini"

  attr_accessor :author, :title, :archive_path

  def self.load(target)
    archive_path = Downloader.get_novel_data_dir_by_target(target)
    if archive_path
      setting = new(archive_path)
      data = Downloader.get_data_by_target(target)
      setting.author = data["author"]
      setting.title = data["title"]
      setting
    else
      nil
    end
  end

  def initialize(archive_path)
    @archive_path = archive_path
    load_settings
    set_attribute
  end

  #
  # 小説変換時の設定値読込
  #
  # 設定値の優先順位は
  # 1. narou setting コマンドで設定した force.*
  # 2. setting.ini
  # 3. DEFAULT_SETTINGS
  #
  def load_settings
    @setting = {}
    ini_path = File.join(@archive_path, INI_NAME)
    ini = Ini.load_file(ini_path) rescue Ini.load("")
    force_settings = {}
    # 設定値を強制的に上書きするデータの読込
    LocalSetting.get["local_setting"].each { |name, value|
      if name =~ /^force\.(.+)$/
        force_settings[$1] = value
      end
    }
    DEFAULT_SETTINGS.each do |element|
      name, value = element[:name], element[:value]
      if force_settings.include?(name)
        @setting[name] = force_settings[name]
      elsif ini["global"].include?(name)
        @setting[name] = ini["global"][name]
      else
        @setting[name] = value
      end
    end
    # デフォルト設定以外を読み込む
    ini["global"].each do |s|
      unless @setting.include?(s[0])
        @setting[s[0]] = cast_type(s[1])
      end
    end
  end

  def set_attribute
    @setting.each_key do |key|
      instance_eval <<-EOS
        def #{key}
          @setting["#{key}"]
        end

        def #{key}=(value)
          @setting["#{key}"] = value
        end
      EOS
    end
  end

  DEFAULT_SETTINGS = [
    # name: 変数名
    # value: 初期値
    # help: 説明(setting.ini に書き出される)
    {
      name: "enable_convert_num_to_kanji",
      value: true,
      help: "数字の漢数字変換を有効に"
    },
    {
      name: "enable_kanji_num_with_units",
      value: true,
      help: "漢数字変換した場合、千・万などに変換するか"
    },
    {
      name: "kanji_num_with_units_lower_digit_zero",
      value: 2,
      help: "〇(ゼロ)が最低この数字以上付いてないと千・万をつける対象にしない"
    },
    {
      name: "enable_alphabet_force_zenkaku",
      value: false,
      help: "アルファベットを強制的に全角にする。falseの場合英文は半角、それ以外は全角になる"
    },
    {
      name: "enable_hanji_sage",
      value: true,
      help: "鍵カッコ等の半字下げを有効に(kindle paperwhite向け設定)"
    },
    {
      name: "enable_auto_indent",
      value: true,
      help: "自動行頭字下げ機能。行頭字下げが行われているかを判断し、適切に行頭字下げをする"
    },
    {
      name: "enable_auto_join_in_brackets",
      value: true,
      help: "鍵カッコ内自動連結を有効に\n例)\n「～～～！\n　＊＊＊？」  → 「～～～！　＊＊＊？」"
    },
    {
      name: "enable_inspect_invalid_openclose_brackets",
      value: true,
      help: "鍵カッコ内のとじ開きが正しくされているかどうか調査する"
    },
    {
      name: "enable_auto_join_line",
      value: true,
      help: "行末が読点で終わっている部分を出来るだけ連結する"
    },
    {
      name: "enable_enchant_midashi",
      value: true,
      help: "［＃改ページ］直後の行に中見出しを付与する（テキストファイルを直接変換する場合のみの設定）"
    },
    {
      name: "enable_author_comments",
      value: true,
      help: "作者コメントを検出するか（テキストファイルを直接変換する場合のみの設定）"
    },
    {
      name: "enable_erase_introduction",
      value: true,
      help: "前書きを削除するか"
    },
    {
      name: "enable_erase_postscript",
      value: false,
      help: "後書きを削除するか"
    },
    {
      name: "enable_ruby",
      value: true,
      help: "ルビ処理対策を有効に"
    },
    {
      name: "enable_narou_illust",
      value: true,
      help: "小説家になろうの挿絵タグを有効にする（false なら削除）"
    },
    {
      name: "enable_transform_fraction",
      value: false,
      help: "○／×表記を×分の○表記に変換する。日付表記(10/23)と誤爆しやすいので注意"
    },
    {
      name: "enable_transform_date",
      value: true,
      help: "日付表記(20yy/mm/dd)を任意の形式(date_formatで指定)に変換する"
    },
    {
      name: "date_format",
      value: "%Y年%m月%d日",
      help: "書式は http://goo.gl/gvJ5u を参考"
    }
  ]
end
