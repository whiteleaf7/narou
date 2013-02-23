# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

#
# 小説の状態を監視・検査する
#
class Inspector
  INSPECT_LOG_NAME = "調査ログ.txt"
  LINE_LENGTH_THRESHOLD = 400
  BRACKETS_RETURN_COUNT_THRESHOLD = 7
  END_TOUTEN_COUNT_THRESHOLD = 50

  ERROR = 1
  WARNING = 2
  INFO = 4
  ALL = ERROR | WARNING | INFO

  KLASS_TAG = { ERROR => "エラー", WARNING =>  "警告", INFO => "INFO" }

  IGNORE_INDENT_CHAR = "　(（［「『〈《≪【〔―・※"
  AUTO_INDENT_THRESHOLD_RATIO = 0.6   # 全行のうちこの割合以上字下げされてなければ強制字下げする

  attr_writer :messages, :subtitle

  def self.read_messages(setting)
    inspect_log = File.join(setting.archive_path, INSPECT_LOG_NAME)
    if File.exists?(inspect_log)
      File.read(inspect_log)
    else
      nil
    end
  end

  def initialize(setting)
    @setting = setting
    @messages = []
    @error = false
    @warning = false
    @info = false
    @subtitle = ""
  end

  def empty?
    @messages.empty?
  end

  def error?
    @error
  end

  def warning?
    @warning
  end

  def info?
    @info
  end

  def display(klass = ALL, target = $stderr)
    target.puts @messages.map { |msg|
      if msg =~ /^\[(.+)\]/
        key = KLASS_TAG.key($1)
        if key && (klass & key) != 0
          next msg
        end
      end
      nil
    }.compact.join("\n\n")
  end

  def save(path = nil)
    path = File.join(@setting.archive_path, INSPECT_LOG_NAME) if path.nil?
    open(path, "w") do |fp|
      fp.puts "--- ログ出力 #{Time.now} ---"
      display(ALL, fp)
    end
  end

  def log(message)
    @messages << message
  end

  def info(message)
    log("[#{KLASS_TAG[INFO]}] #{message}")
    @info = true
  end

  def warning(message)
    log("[#{KLASS_TAG[WARNING]}] #{message}")
    @warning = true
  end

  def error(message)
    log("[#{KLASS_TAG[ERROR]}] #{message}")
    @error = true
  end

  def omit_message(strings)
    navigation = "in #{@subtitle}" if @subtitle.to_s.length > 0
    "≫≫≫ 該当箇所 #{navigation}\n..." + strings[0...36].gsub("\n", "\\n") + "..."
  end

  #
  # 連結した鍵カッコが正常かどうか
  #
  def validate_joined_inner_brackets(raw_strings, joined_strings, brackets)
    error_result = false
    case
    # 連結前の文章の改行具合を調べて、改行が閾値を超えた場合意図的な改行とみなす
    when raw_strings.count("\n") >= BRACKETS_RETURN_COUNT_THRESHOLD
      warning("改行が規定の回数を超えて検出されました。" +
              "作者による意図的な改行とみなし、連結を中止しました。\n" +
              omit_message(raw_strings))
      error_result = true
    # 連結した文章があまりにも長い場合、特殊な用途で使われている可能性がある
    when joined_strings.length >= LINE_LENGTH_THRESHOLD
      warning("連結結果が長過ぎます。連結を中止しました。" +
              "特殊な用途(手紙形式)等で鍵カッコが使われている可能性があります。\n" +
            omit_message(raw_strings))
      error_result = true
    end
    error_result
  end

  #
  # 鍵カッコのとじ開きの異常部分を調査
  #
  def inspect_invalid_openclose_brackets(data, brackets, stack)
    brackets.each do |bracket|
      buffer = data.dup
      while buffer =~ /#{bracket}/
        match_before = $`.dup
        match_after = $'.dup
        before = ConverterBase.rebuild_brackets(match_before, stack)
        after = ConverterBase.rebuild_brackets(match_after, stack)
        error("鍵カッコ(#{bracket})が正しく閉じていません。\n" +
              omit_message((before[-15..-1] || before) + bracket + after))
        buffer = match_before
      end
    end
  end

  #
  # 行末読点の状況を調べる
  #
  def inspect_end_touten_conditions(data)
    return if @setting.enable_auto_join_line
    num = 0
    data.scan(/、\n　/) do
      num += 1
    end
    if num > 0
      msg = "#{num}個の行末読点を発見しました。"
      if num >= END_TOUTEN_COUNT_THRESHOLD
        msg << "作者による手動改行により改行が多くなっています。" + \
               "setting.ini の enable_auto_join_line を true にすることをお薦めします。"
      end
      info(msg)
    end
  end

  #
  # カギ括弧内の改行状況を調べる
  #
  def countup_return_in_brackets(data)
    return if @setting.enable_auto_join_in_brackets
    max = 0
    brackets_num = 0
    brackets_num_over_threshould = 0
    total = 0
    ConverterBase::OPENCLOSE_REGEXPS.each do |openclose|
      data.scan(openclose) do |match|
        cnt = match[0].count("\n")
        brackets_num += 1
        total += cnt
        next if cnt < BRACKETS_RETURN_COUNT_THRESHOLD
        brackets_num_over_threshould += 1
        if cnt > max
          max = cnt
        end
      end
    end
    info("カギ括弧内の改行状況:\n" +
         "検出したカギ括弧数: #{brackets_num}、そのうち#{BRACKETS_RETURN_COUNT_THRESHOLD}個以上改行を含む数: #{brackets_num_over_threshould}\n" + 
         "1つのカギ括弧内で最大の改行数: #{max}、全カギ括弧内での改行合計: #{total}")
  end

  #
  # 行頭字下げをするべきか調べる
  #
  def inspect_indent(data)
    dont_indent_line_count = data.scan(/^[^#{IGNORE_INDENT_CHAR}]/).count
    line_count = data.lines.count
    ratio = dont_indent_line_count / line_count.to_f
    return ratio > AUTO_INDENT_THRESHOLD_RATIO
  end
end
