# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "fileutils"
require_relative "ini"
require_relative "downloader"

class NovelSetting
  INI_NAME = "setting.ini"
  INI_ERB_BINARY_VERSION = 1.2
  REPLACE_NAME = "replace.txt"

  attr_accessor :id, :author, :title, :archive_path, :replace_pattern, :settings

  #
  # データベースに登録されている小説の設定を取得する
  #
  def self.load(target, ignore_force, ignore_default)
    setting = create(target, ignore_force, ignore_default)
    data = Downloader.get_data_by_target(target)
    setting.id = data["id"]
    setting.author = data["author"]
    setting.title = data["title"]
    setting
  end

  #
  # 小説設定オブジェクトを作成する
  #
  # target には小説ID等の他、小説保存フォルダを指定できる。
  # テキストファイル変換時はデータベースに登録されていないので load ではなくこちらを使用する
  #
  def self.create(target, ignore_force, ignore_default)
    setting = new(target, ignore_force, ignore_default)
    setting.load_settings
    setting.set_attribute
    setting.load_replace_pattern
    setting
  end

  def initialize(target, ignore_force, ignore_default)
    if File.directory?(target.to_s)
      archive_path = target
    else
      archive_path = Downloader.get_novel_data_dir_by_target(target).to_s
    end
    @archive_path = File.expand_path(archive_path)
    @ignore_force = ignore_force
    @ignore_default = ignore_default
    @replace_pattern = []
    @settings = {}
  end

  def ini_path
    File.join(@archive_path, INI_NAME)
  end

  def load_setting_ini
    Ini.load_file(ini_path) rescue Ini.load("")
  end

  #
  # 小説変換時の設定値読込
  #
  # 設定値の優先順位は
  # 1. narou setting コマンドで設定した force.*
  # 2. setting.ini
  # 3. narou setting コマンドで設定した default.*
  # 4. ORIGINAL_SETTINGS
  #
  def load_settings
    @settings.clear
    ini = load_setting_ini
    force_settings = @ignore_force ? {} : NovelSetting.load_force_settings
    default_settings = @ignore_default ? {} : NovelSetting.load_default_settings
    ORIGINAL_SETTINGS.each do |element|
      name, value, type = element[:name], element[:value], element[:type]
      if force_settings.include?(name)
        @settings[name] = force_settings[name]
      elsif ini["global"].include?(name) && type_eq_value(type, ini["global"][name])
        @settings[name] = ini["global"][name]
      elsif default_settings.include?(name)
        @settings[name] = default_settings[name]
      else
        @settings[name] = value
      end
    end
    # デフォルト設定以外を読み込む
    ini["global"].each do |key, value|
      unless @settings.include?(key)
        @settings[key] = value
      end
    end
  end

  #
  # local_settings から group.name 形式のデータを取得
  #
  # { name: value, ... } 形式のハッシュとして返す
  #
  def self.load_settings_by_pattern(pattern)
    res = Inventory.load("local_setting", :local).map { |name, value|
      if name =~ /^#{pattern}\.(.+)$/
        [$1, value]
      else
        nil
      end
    }.compact.flatten
    Hash[*res]
  end

  #
  # force.* 設定を取得
  #
  def self.load_force_settings
    load_settings_by_pattern("force")
  end

  #
  # default.* 設定を取得
  #
  def self.load_default_settings
    load_settings_by_pattern("default")
  end

  def get_value_by_original(name)
    index = ORIGINAL_SETTINGS_KEY_INDEXES[name]
    index ? ORIGINAL_SETTINGS[index] : nil
  end

  #
  # 設定を保存
  #
  def save_settings
    original_settings = NovelSetting.get_original_settings
    default_settings = NovelSetting.load_default_settings
    novel_setting = self
    Template.write(INI_NAME, @archive_path, binding, INI_ERB_BINARY_VERSION, Template::OVERWRITE)
  end

  def type_eq_value(type, value)
    type_of_value = Helper.type_of_value(value)
    case type
    when :string, :select, :multiple
      :string == type_of_value
    else
      type == type_of_value
    end
  end

  #
  # 指定された設定の型チェック
  #
  def check_value_of_type(name, value)
    original = get_value_by_original(name)
    return unless original
    unless type_eq_value(original[:type], value)
      raise Helper::InvalidVariableType, original[:type]
    end
  end

  #
  # 設定データ用アクセサ定義
  #
  def set_attribute
    @settings.each_key do |key|
      instance_eval <<-EOS
        def #{key}
          @settings["#{key}"]
        end

        def #{key}=(value)
          check_value_of_type("#{key}", value)
          @settings["#{key}"] = value
        end
      EOS
    end
  end

  #
  # 配列風のアクセサ定義
  #
  def [](name)
    @settings[name]
  end

  def []=(name, value)
    unless value.nil?
      check_value_of_type(name, value)
    end
    @settings[name] = value
  end

  #
  # replace.txt による置換定義を読み込む
  #
  def load_replace_pattern
    @replace_pattern.clear
    replace_txt_path = File.join(@archive_path, REPLACE_NAME)
    if File.exist?(replace_txt_path)
      @replace_pattern = Narou.parse_replace_txt(File.read(replace_txt_path, mode: "r:BOM|UTF-8"))
    end
    @replace_pattern
  end

  #
  # replace.txt に設定を書き戻す
  #
  def save_replace_pattern
    replace_txt_path = File.join(@archive_path, REPLACE_NAME)
    Narou.write_replace_txt(replace_txt_path, @replace_pattern)
  end

  def self.get_original_settings
    ORIGINAL_SETTINGS
  end

  ORIGINAL_SETTINGS = [
    # name: 変数名
    # type: 変数の型
    # value: 初期値
    # help: 説明(setting.ini に書き出される)
    {
      name: "enable_convert_num_to_kanji",
      type: :boolean,
      value: true,
      help: "数字の漢数字変換を有効に"
    },
    {
      name: "enable_kanji_num_with_units",
      type: :boolean,
      value: true,
      help: "漢数字変換した場合、千・万などに変換するか"
    },
    {
      name: "kanji_num_with_units_lower_digit_zero",
      type: :integer,
      value: 3,
      help: "〇(ゼロ)が最低この数字以上付いてないと千・万などをつける対象にしない"
    },
    {
      name: "enable_alphabet_force_zenkaku",
      type: :boolean,
      value: false,
      help: "アルファベットを強制的に全角にする。falseの場合英文は半角、それ以外は全角になる"
    },
    {
      name: "enable_half_indent_bracket",
      type: :boolean,
      value: true,
      help: "行頭かぎ括弧に二分アキを挿入する"
    },
    {
      name: "enable_auto_indent",
      type: :boolean,
      value: true,
      help: "自動行頭字下げ機能。行頭字下げが行われているかを判断し、適切に行頭字下げをする"
    },
    {
      name: "enable_force_indent",
      type: :boolean,
      value: false,
      help: "行頭字下げを必ず行う。enable_auto_indent の設定は無視される"
    },
    {
      name: "enable_auto_join_in_brackets",
      type: :boolean,
      value: true,
      help: "かぎ括弧内自動連結を有効に\n例)\n「～～～！\n　＊＊＊？」  → 「～～～！　＊＊＊？」"
    },
    {
      name: "enable_inspect_invalid_openclose_brackets",
      type: :boolean,
      value: false,
      help: "かぎ括弧内のとじ開きが正しくされているかどうか調査する"
    },
    {
      name: "enable_auto_join_line",
      type: :boolean,
      value: true,
      help: "行末が読点で終わっている部分を出来るだけ連結する"
    },
    {
      name: "enable_enchant_midashi",
      type: :boolean,
      value: true,
      help: "［＃改ページ］直後の行に中見出しを付与する（テキストファイルを直接変換する場合のみの設定）"
    },
    {
      name: "enable_author_comments",
      type: :boolean,
      value: true,
      help: "作者コメントを検出するか（テキストファイルを直接変換する場合のみの設定）"
    },
    {
      name: "enable_erase_introduction",
      type: :boolean,
      value: false,
      help: "前書きを削除するか"
    },
    {
      name: "enable_erase_postscript",
      type: :boolean,
      value: false,
      help: "後書きを削除するか"
    },
    {
      name: "enable_ruby",
      type: :boolean,
      value: true,
      help: "ルビ処理を有効に"
    },
    {
      name: "enable_illust",
      type: :boolean,
      value: true,
      help: "挿絵タグを有効にする（false なら削除）"
    },
    {
      name: "enable_transform_fraction",
      type: :boolean,
      value: false,
      help: "○／×表記を×分の○表記に変換する。日付表記(10/23)と誤爆しやすいので注意"
    },
    {
      name: "enable_transform_date",
      type: :boolean,
      value: false,
      help: "日付表記(20yy/mm/dd)を任意の形式(date_formatで指定)に変換する"
    },
    {
      name: "date_format",
      type: :string,
      value: "%Y年%m月%d日",
      help: "書式は http://bit.ly/1m5e3w7 を参考"
    },
    {
      name: "enable_convert_horizontal_ellipsis",
      type: :boolean,
      value: true,
      help: "中黒(・)を並べて三点リーダーもどきにしているのを三点リーダーに変換する"
    },
    {
      name: "enable_convert_page_break",
      type: :boolean,
      value: false,
      help: "`to_page_break_threshold` で設定した個数以上連続する空行を改ページに変換する"
    },
    {
      name: "to_page_break_threshold",
      type: :integer,
      value: 10,
      help: "ここで設定した値が `enable_convert_page_break` に反映される"
    },
    {
      name: "enable_dakuten_font",
      type: :boolean,
      value: true,
      help: "濁点フォントを使用するか。false の場合は縦中横による擬似表現を使用する"
    },
    {
      name: "enable_display_end_of_book",
      type: :boolean,
      value: true,
      help: "小説の最後に本を読み終わった表示をするかどうか"
    },
    {
      name: "enable_add_date_to_title",
      type: :boolean,
      value: false,
      help: "変換後の小説のタイトルに更新日の日付を付加するかどうか"
    },
    {
      name: "title_date_format",
      type: :string,
      value: "(%-m/%-d)",
      help: "enable_add_date_to_title で付与する日付のフォーマット。書式は http://bit.ly/1m5e3w7 を参照"
    },
    {
      name: "title_date_align",
      type: :select,
      value: "right",
      help: "enable_add_date_to_title で付与する日付の位置。left(タイトルの前) か right(タイトルの後)",
      select_keys: %w(left right),
      select_summaries: %w(タイトルの前 タイトルの後)
    },
    {
      name: "enable_ruby_youon_to_big",
      type: :boolean,
      value: false,
      help: "ルビの拗音(ぁ、ぃ等)を商業書籍のように大きくするかどうか"
    },
    {
      name: "enable_pack_blank_line",
      type: :boolean,
      value: true,
      help: "縦書きで読みやすいように空行を減らすかどうか"
    },
    {
      name: "enable_kana_ni_to_kanji_ni",
      type: :boolean,
      value: true,
      help: "漢字の二と間違えてカタカナのニを使っていそうなのを、漢字に直すかどうか"
    },
    {
      name: "enable_insert_word_separator",
      type: :boolean,
      value: false,
      help: "単語選択がしやすいように単語単位の区切りデータを挿入する（Kindle専用）"
    },
    {
      name: "enable_insert_char_separator",
      type: :boolean,
      value: false,
      help: "文字選択がしやすいように１文字ずつ区切りデータを挿入する（Kindle専用。enable_insert_word_separator が有効な場合無この設定は無視される）"
    },
  ]

  ORIGINAL_SETTINGS_KEY_INDEXES = {}.tap { |hash|
    ORIGINAL_SETTINGS.each_with_index do |s, i|
      hash[s[:name]] = i
    end
  }
end
