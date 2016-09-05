# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "open3"
require "time"
require "systemu"

#
# 雑多なお助けメソッド群
#
module Helper
  module_function

  HOST_OS = RbConfig::CONFIG["host_os"]
  FILENAME_LENGTH_LIMIT = 50

  def os_windows?
    @@os_is_windows ||= HOST_OS =~ /mswin(?!ce)|mingw|bccwin/i
  end

  def os_mac?
    @@os_is_mac ||= HOST_OS =~ /darwin/i
  end

  def os_cygwin?
    @@os_is_cygwin ||= HOST_OS =~ /cygwin/i
  end

  def determine_os
    case
    when os_windows?
      :windows
    when os_mac?
      :mac
    when os_cygwin?
      :cygwin
    else
      :other
    end
  end

  def engine_jruby?
    @@engine_is_jruby ||= RUBY_ENGINE == "jruby"
  end
  
  if engine_jruby? && os_windows?
    require_relative "extensions/windows"
    def $stdin.getch
      WinAPI._getch.chr
    end
  else
    require "io/console"
  end

  def open_browser_linux(address, error_message)
    %w(xdg-open firefox w3m).each do |browser|
      system(%!#{browser} "#{address}"!)
      return if $?.success?
    end
    error error_message
  end

  def open_directory(path, confirm_message = nil)
    if confirm_message
      return unless Narou::Input.confirm(confirm_message, false, false)
    end
    case determine_os
    when :windows
      system(%!explorer "file:///#{path.encode(Encoding::Windows_31J)}"!)
    when :cygwin
      system(%!cygstart "#{path}"!)
    when :mac
      system(%!open "#{path}"!)
    else
      open_browser_linux(path, "フォルダが開けませんでした")
    end
  end

  def open_browser(url)
    case determine_os
    when :windows
      escaped_url = url.gsub("%", "%^").gsub("&", "^&")
      # MEMO: start の引数を "" で囲むと動かない
      system(%!start #{escaped_url}!)
    when :cygwin
      system(%!cygstart #{url}!)
    when :mac
      system(%!open "#{url}"!)
    else
      open_browser_linux(url, "ブラウザが見つかりませんでした")
    end
  end

  def print_horizontal_rule
    puts "―" * 35
  end

  def replace_filename_special_chars(str, invalid_replace = false)
    result = str.tr("/:*?\"<>|.", "／：＊？”〈〉｜．").gsub("\\", "￥").gsub("\t", "").gsub("\n", "")
    if invalid_replace
      org_encoding = result.encoding
      result = result.encode(Encoding::Windows_31J, invalid: :replace, undef: :replace, replace: "_")
                     .encode(org_encoding)
    end
    result
  end

  #
  # ダウンロードした文字列をエンコード及び不正な文字列除去、改行コード統一
  #
  def pretreatment_source(src, encoding = Encoding::UTF_8)
    encoding_class = Encoding.find(encoding)
    src.force_encoding(encoding)
       .tap do |this|
         if encoding_class != Encoding::UTF_8
           this.encode!(Encoding::UTF_8, invalid: :replace, undef: :replace)
         end
       end
       .scrub("?")
       .gsub("\r", "")
  end

  ENTITIES = { quot: '"', amp: "&", nbsp: " ", lt: "<", gt: ">", copy: "(c)", "#39" => "'" }
  #
  # エンティティ復号
  #
  def restor_entity(str)
    result = str.dup
    ENTITIES.each do |key, value|
      result.gsub!("&#{key};", value)
    end
    result
  end

  #
  # CYGWINのパスからwindowsのパスへと変換(cygpathを呼び出すだけ)
  #
  def convert_to_windows_path(path)
    `cygpath -aw \"#{path}\"`.strip
  end

  #
  # アンパサンドをエンティティに変換
  #
  def ampersand_to_entity(str)
    str.gsub(/&(?!amp;)/mi, "&amp;")
  end

  #
  # 文章の中から挿絵注記を分離する
  #
  def extract_illust_chuki(str)
    illust_chuki_array = []
    extracted_str = str.gsub(/[ 　\t]*?(［＃挿絵（.+?）入る］)\n?/) do
      illust_chuki_array << $1
      ""
    end
    [extracted_str, illust_chuki_array]
  end

  class InvalidVariableType < StandardError
    def initialize(type)
      super("値が #{Helper.variable_type_to_description(type).rstrip} ではありません")
    end
  end

  class UnknownVariableType < StandardError
    def initialize(type)
      super("unknwon variable type (:#{type})")
    end
  end

  class InvalidVariableName < StandardError; end

  #
  # 与えられた型情報の意味文字列を取得
  #
  def variable_type_to_description(type)
    case type
    when :boolean
      "true/false  "
    when :integer
      "整数        "
    when :float
      "小数点数    "
    when :string, :select
      "文字列      "
    when :multiple
      "文字列(複数)"
    when :directory
      "フォルダパス"
    when :file
      "ファイルパス"
    else
      raise UnknownVariableType, type
    end
  end

  #
  # 文字列データを指定された型にキャストする
  #
  def string_cast_to_type(value, type)
    result = nil
    case type
    when :boolean
      case value.strip.downcase
      when "true"
        result = true
      when "false"
        result = false
      else
        raise InvalidVariableType, type
      end
    when :integer
      begin
        result = Integer(value)
      rescue
        raise InvalidVariableType, type
      end
    when :float
      begin
        result = Float(value)
      rescue
        raise InvalidVariableType, type
      end
    when :directory, :file
      if File.method("#{type}?").call(value)
        result = File.expand_path(value)
      else
        raise InvalidVariableType, type
      end
    when :string, :select, :multiple
      result = value
    else
      raise UnknownVariableType, type
    end
    result
  end

  TYPE_OF_VALUE = {
    TrueClass => :boolean, FalseClass => :boolean, Fixnum => :integer,
    Float => :float, String => :string
  }

  #
  # Rubyの変数がなんの型かシンボルで取得
  #
  def type_of_value(value)
    TYPE_OF_VALUE[value.class]
  end

  #
  # ファイルを指定したディレクトリにまとめてコピーする
  # 指定したディレクトリが存在しなければ作成する
  #
  # from: ファイルパスをまとめた Array
  # dest_dir: コピー先のディレクトリ
  #
  def copy_files(from, dest_dir)
    from.each do |path|
      basename = File.basename(path)
      dirname = File.basename(File.dirname(path))
      save_dir = File.join(dest_dir, dirname)
      unless File.directory?(save_dir)
        FileUtils.mkdir_p(save_dir)
      end
      FileUtils.copy(path, File.join(save_dir, basename))
    end
  end

  #
  # 日付形式の文字列をTime型に変換する
  #
  def date_string_to_time(date)
    date ? Time.parse(date.sub(/[\(（].+?[\)）]/, "").tr("年月日時分秒@;", "///::: :")) : nil
  end

  #
  # 指定のファイルが前回のチェック時より新しいかどうか
  #
  # 初回チェック時は無条件で新しいと判定
  #
  def file_latest?(path)
    @@file_mtime_list ||= {}
    fullpath = File.expand_path(path)
    last_mtime = @@file_mtime_list[fullpath]
    mtime = File.mtime(fullpath)
    if mtime == last_mtime
      result = false
    else
      result = true
      @@file_mtime_list[fullpath] = mtime
    end
    result
  end

  #
  # 伏せ字にする
  #
  # 数字やスペース、句読点、感嘆符はそのままにする
  #
  def to_unprintable_words(string, mask = "●")
    result = ""
    string.each_char do |char|
      result += case char
                when /[0-9０-９ 　、。!?！？]/
                  char
                else
                  mask
                end
    end
    result
  end

  #
  # 長過ぎるファイルパスを詰める
  # ファイル名部分のみを詰める。拡張子は維持する
  #
  def truncate_path(path, limit = FILENAME_LENGTH_LIMIT)
    dirname = File.dirname(path)
    extname = File.extname(path)
    basename = File.basename(path, extname)
    if basename.length > limit
      basename = basename[0...limit]
      dirname = nil if dirname == "."
      [dirname, "#{basename}#{extname}"].compact.join("/")
    else
      path
    end
  end

  #
  # 外部コマンド実行中の待機ループの処理を書けるクラス
  #
  # 返り値：[標準出力のキャプチャ, 標準エラーのキャプチャ, Process::Status]
  #
  # response = Helper::AsyncCommand.exec("処理に時間がかかる外部コマンド") do
  #   print "*"
  # end
  # if response[2].success?
  #   puts "成功しました"
  # end
  #
  class AsyncCommand
    def self.exec(command, sleep_time = 0.5, &block)
      looper = nil
      _pid = nil
      status, stdout, stderr = systemu(command) do |pid|
        _pid = pid
        looper = Thread.new(pid) do |pid|
          loop do
            block.call if block
            sleep(sleep_time)
            if Narou::Worker.canceled?
              Process.kill("KILL", pid)
              Process.detach(pid)
              break
            end
          end
        end
        looper.join
        looper = nil
      end
      stdout.force_encoding(Encoding::UTF_8)
      stderr.force_encoding(Encoding::UTF_8)
      return [stdout, stderr, status]
    rescue Interrupt
      if _pid
        begin
          Process.kill("KILL", _pid)
          Process.detach(_pid)    # 死亡確認しないとゾンビ化する
        rescue
        end
      end
      raise
    ensure
      looper.kill if looper
    end
  end

  #
  # 更新時刻を考慮したファイルのローダー
  #
  module CacheLoader
    module_function

    @@mutex = Mutex.new
    @@caches = {}
    @@result_caches = {}

    DEFAULT_OPTIONS = { mode: "r:BOM|UTF-8" }

    #
    # ファイルの更新時刻を考慮してファイルのデータを取得する。
    # 前回取得した時からファイルが変更されていない場合は、キャッシュを返す
    #
    # options にはファイルを読み込む時に File.read に渡すオプションを指定できる
    #
    def load(path, options = DEFAULT_OPTIONS)
      @@mutex.synchronize do
        fullpath = File.expand_path(path)
        cache_data = @@caches[fullpath]
        if Helper.file_latest?(fullpath) || !cache_data
          body = File.read(fullpath, options)
          @@caches[fullpath] = body
          return body
        else
          return cache_data
        end
      end
    end

    #
    # ファイルを処理するブロックの結果をキャッシュ化する
    #
    # CacheLoader.load がファイルの中身だけをキャッシュ化するのに対して
    # これはブロックの結果をキャッシュする。ファイルが更新されない限り、
    # ブロックの結果は変わらない
    #
    # ex.)
    # Helper::CacheLoader.memo("filepath") do |data|
    #   # data に関する処理
    #   result  # ここで nil を返すと次回も再度読み込まれる
    # end
    #
    def memo(path, options = DEFAULT_OPTIONS, &block)
      @@mutex.synchronize do
        fail ArgumentError, "need a block" unless block
        fullpath = File.expand_path(path)
        key = generate_key(fullpath, block)
        cache = @@result_caches[key]
        if Helper.file_latest?(fullpath) || !cache
          data = File.read(fullpath, options)
          @@result_caches[key] = result = block.call(data)
          return result
        else
          return cache
        end
      end
    end

    #
    # キャッシュを格納する際に必要なキーを生成する
    #
    # ブロックはその場所が実行されるたびに違うprocオブジェクトが生成されるため、
    # 同一性判定のために「どのソース」の「何行目」かで判定を行う
    #
    def generate_key(fullpath, block)
      src, line = block.source_location
      "#{fullpath}:#{src}:#{line}"
    end

    #
    # 指定したファイルのキャッシュを削除する
    #
    # path を指定しなかった場合、全てのキャッシュを削除する
    #
    def clear(path = nil)
      @@mutex.synchronize do
        if path
          fullpath = File.expand_path(path)
          @@cache.delete(fullpath)
          @@result_caches.delete(fullpath)
        else
          @@cache.clear
          @@result_caches.clear
        end
      end
    end
  end
end

