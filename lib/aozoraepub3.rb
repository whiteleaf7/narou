# frozen_string_literal: true

#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "fileutils"
require_relative "narou"

#
# AozoraEpub3 設定処理
#
module AozoraEpub3
  @prev_use_dakuten_font = nil

  def self.setup(global_setting)
    aozora_dir_path = global_setting["aozoraepub3dir"]

    # 資材アップデーターの取得
    updater = get_resouce_updater(aozora_dir_path)

    # 更新ファイル名のクリア
    updater.clear_log

    # iniファイルのコピー
    updater.copy_ini_file

    # chuki_tag.txt の書き換え
    updater.replace_chuki_tag_file

    yokogaki = false # dummy
    use_dakuten_font = false # dummy
    line_height = global_setting["line-height"]
    # カスタムCSSファイルのコピー
    # MEMO:
    # 変換の時に毎回更新しているので本当はここでやる必要はない
    # ただ、ここで行えば更新ファイル名をログに出せる
    updater.copy_css_files(yokogaki, use_dakuten_font, line_height)

    # 内容が同じだと書き換えを行わない場合もあるので、更新日時をアップデート
    updater.updated_file_paths.each { |path| FileUtils.touch(path) }

    yield(updater.copied_file_paths, updater.updated_file_paths) if block_given?
  end
  public_class_method :setup

  #
  # Aozoraの資材更新
  #
  # MEMO:
  # 資材更新が必要かどうかは作品ごとに異なる。
  # たとえば濁点フォント機能を有効にしている場合、濁点文字を使ってる作品なら、
  # 濁点フォントやCSSをコピーする必要があるし、そうでなければ濁点の資材を取り除かなければならない
  def self.update_resources(yokogaki, use_dakuten_font)
    return if @prev_use_dakuten_font == use_dakuten_font

    line_height = Narou.line_height

    # 資材アップデーターの取得
    updater = get_resouce_updater

    # ファイル更新情報のクリア
    updater.clear_log

    # CSSファイルのコピー
    updater.copy_css_files(yokogaki, use_dakuten_font, line_height)

    if use_dakuten_font
      # 濁点フォントファイルのコピー
      updater.copy_dakuten_font
    else
      # 濁点フォントファイルの削除
      updater.remove_dakuten_font
    end

    # 設定値の保存
    @prev_use_dakuten_font = use_dakuten_font
  end
  public_class_method :update_resources

  #
  # Aozora資材アップデーターの取得
  #
  def self.get_resouce_updater(aozora_dir_path = nil)
    aozora_dir_path ||= File.dirname(Narou.aozoraepub3_path)
    if denshokyo_version?(aozora_dir_path)
      AozoraResourceUpdaterDen.new(aozora_dir_path)
    else
      AozoraResourceUpdater.new(aozora_dir_path)
    end
  end
  private_class_method :get_resouce_updater

  #
  # Aozora出力形式の判定
  #
  def self.denshokyo_version?(aozora_dir_path)
    # template/item ディレクトリがあれば電書協対応版 (改造版v1.1.1以降) とみなす
    Dir.exist?(File.join(aozora_dir_path, "template", "item"))
  end
  private_class_method :denshokyo_version?

  #
  # Aozora資材アップデーター
  #
  class AozoraResourceUpdater
    VERTICAL_CSS   = "vertical_font.css"
    DAKUTEN_FONT   = "DMincho.ttf"

    def initialize(aozora_dir_path = nil)
      @format_type = "honke"
      @aozora_dir_path     = aozora_dir_path || File.dirname(Narou.aozoraepub3_path)
      aozora_ops_dir       = File.join(@aozora_dir_path, "template", "OPS")
      @aozora_naroubak_dir = File.join(@aozora_dir_path, "template", "narou_bak")
      @aozora_css_dir      = File.join(aozora_ops_dir, "css")
      @aozora_font_dir     = File.join(aozora_ops_dir, "fonts")

      @aozora_chuki_path   = File.join(@aozora_dir_path, "chuki_tag.txt")
      @narou_rb_chuki_path = File.join(Narou.preset_dir, "custom_chuki_tag.txt")

      clear_log
    end

    def clear_log
      @updated_file_paths = []
      @copied_file_paths = []
    end
    attr_reader :updated_file_paths, :copied_file_paths

    def self.get_custom_file_path(file_path, should_create_directory)
      dir_path = File.dirname(file_path) + "_custom" 
      if should_create_directory
        FileUtils.mkdir_p(dir_path)
      end
      File.join(dir_path, File.basename(file_path))
    end

    # iniファイルのコピー
    def copy_ini_file
      src = File.join(Narou.preset_dir, "AozoraEpub3.ini")
      dst = File.join(@aozora_dir_path, "AozoraEpub3.ini")
      FileUtils.copy(src, dst)
      @copied_file_paths << dst
    end

    # 注記ファイルのコピー
    def replace_chuki_tag_file
      narou_rb_chuki = File.read(@narou_rb_chuki_path, mode: "r:BOM|UTF-8")
      aozora_chuki   = File.read(@aozora_chuki_path,   mode: "r:BOM|UTF-8")
      embedded_mark = "### Narou.rb embedded custom chuki ###"
      if aozora_chuki =~ /#{embedded_mark}/
        # MEMO:
        # 再実行時、ファイル末尾に余計な改行を増やさないよう置換文字列を strip する
        aozora_chuki.gsub!(/#{embedded_mark}.+#{embedded_mark}/m, narou_rb_chuki.strip)
      else
        aozora_chuki << "\n" << narou_rb_chuki
      end
      File.write(@aozora_chuki_path, aozora_chuki)
      @updated_file_paths << @aozora_chuki_path
    end

    # CSSファイルのコピー
    def copy_css_files(yokogaki, use_dakuten_font, line_height)
      css_template_path = File.join(Narou.preset_dir, VERTICAL_CSS)
      aozora_vrtl_css_path = File.join(@aozora_css_dir, VERTICAL_CSS)
      css = create_css_text(css_template_path, yokogaki, use_dakuten_font, line_height)
      create_custom_css_file(aozora_vrtl_css_path, css)
    end

    # テンプレートファイルをもとにCSS(文字列)を作成
    def create_css_text(template_file_path, yokogaki, use_dakuten_font, line_height)
      tategaki = !yokogaki
      format_type = @format_type
      template = File.read(template_file_path, mode: "rb:BOM|UTF-8")
      # yokogaki, tategaki, line_height, use_dakuten_font, format_type などの変数を binding でテンプレートに渡す
      ERB.new(template, trim_mode: "-").result(binding)
    end

    # AozoraEpub3 と Narou.rb の CSS をもとに カスタムCSSを作成する
    def create_css_text2(original_css_path, css_template_path, yokogaki, use_dakuten_font, line_height)
      # オリジナルCSSファイルを読み込み、内容をバッファに追加
      lines = File.read(original_css_path, mode: "rb:BOM|UTF-8")
      # 改行コードを取得
      eol = lines.include?("\r\n") ? "\r\n" : "\n"

      lines << eol
      lines << "/*** [START] Narou.rb embedded custom style ***/" << eol

      css = create_css_text(css_template_path, yokogaki, use_dakuten_font, line_height)
      css.each_line do |line|
        unless line.match?(/^\s*@(?:charset|namespace)/)
          # 内容をバッファに追加
          lines << line.chomp! << eol
        end
      end

      lines << eol
      lines << "/*** [END]  Narou.rb embedded custom style ***/" << eol
      lines
    end

    # カスタムCSSファイルの配置
    def create_custom_css_file(dst_css_file_path, css)
      custom_css_file_path = AozoraResourceUpdater.get_custom_file_path(dst_css_file_path, true)
      file_write(custom_css_file_path, css)
      @copied_file_paths << custom_css_file_path
    end

    # 濁点フォントパス
    def dst_dakuten_font_path
      File.join(@aozora_font_dir, DAKUTEN_FONT)
    end

    # 濁点フォントファイルのコピー
    def copy_dakuten_font
      unless File.exist?(dst_dakuten_font_path)
        # フォントファイルがない場合、控えのフォントファイルをコピー先に移動する
        move_file_from_backup(DAKUTEN_FONT, dst_dakuten_font_path)
      end
      @copied_file_paths << dst_dakuten_font_path
    end

    # 濁点フォントファイルの削除
    def remove_dakuten_font
      # ファイルをバックアップフォルダに移動する
      move_file_to_backup(dst_dakuten_font_path)
    end

    # バックアップファイルをコピー先に移動する
    # バックアップファイルがない場合、プリセットのファイルをコピー先にコピーする
    def move_file_from_backup(filename, dst_file_path)
      FileUtils.mkdir_p(File.dirname(dst_file_path))
      bak_file_path = File.join(@aozora_naroubak_dir, filename)
      if File.exist?(bak_file_path)
        FileUtils.move(bak_file_path, dst_file_path)
      else
        src_file_path = File.join(Narou.preset_dir, filename)
        FileUtils.copy(src_file_path, dst_file_path)
      end
    end

    # ファイルをバックアップフォルダに移動する
    def move_file_to_backup(dst_file_path)
      return unless File.exist?(dst_file_path)

      FileUtils.mkdir_p(@aozora_naroubak_dir)
      bak_file_path = File.join(@aozora_naroubak_dir, File.basename(dst_file_path))
      FileUtils.move(dst_file_path, bak_file_path)
    end
  end
  private_constant :AozoraResourceUpdater

  #
  # Aozora電書協 資材アップデーター
  #
  class AozoraResourceUpdaterDen < AozoraResourceUpdater
    BOOK_STYLE_CSS = "book-style.css"
    DENSHOKYO_CSS  = "denshokyo.css"

    def initialize(aozora_dir_path = nil)
      super(aozora_dir_path)
      @format_type     = "denshokyo"
      aozora_item_dir  = File.join(@aozora_dir_path, "template", "item")
      @aozora_css_dir  = File.join(aozora_item_dir, "style")
      @aozora_font_dir = File.join(aozora_item_dir, "fonts")
    end

    #
    # カスタムCSSファイルの配置
    #
    def copy_css_files(yokogaki, use_dakuten_font, line_height)
      aozora_css_path = File.join(@aozora_css_dir, BOOK_STYLE_CSS)
      # オリジナルのCSSがなければエラー
      unless File.exist?(aozora_css_path)
        raise Errno::ENOENT, "'#{aozora_css_path}' not found."
      end

      css_template_path = File.join(Narou.preset_dir, DENSHOKYO_CSS)
      css = create_css_text2(aozora_css_path, css_template_path, yokogaki, use_dakuten_font, line_height)
      # CSSカスタムファイルの作成
      create_custom_css_file(aozora_css_path, css)
    end
  end
  private_constant :AozoraResourceUpdaterDen
end

# ファイルの読込み
def try_reading_file(filepath)
  File.exist?(filepath) ? File.read(filepath, mode: "rb:BOM|UTF-8") : nil
end

# ファイルの書込み
# 内容が同じなら書き込まない
def file_write(filepath, content)
  should_write = !File.exist?(filepath) || try_reading_file(filepath) != content
  return unless should_write

  File.open(filepath, mode: "wb:UTF-8") do |f|
    f.write(content)
  end
end
