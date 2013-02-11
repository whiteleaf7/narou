# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

#
# 小説の状態を監視・検査する
#
class Inspector
  ERROR_LOG_NAME = "エラーログ.txt"
  LINE_LENGTH_THRESHOLD = 400
  BRACKETS_RETURN_COUNT_THRESHOLD = 7
  END_TOUTEN_COUNT_THRESHOLD = 50

  ERROR = 1
  WARNING = 2
  INFO = 4
  ALL = ERROR | WARNING | INFO

  KLASS_TAG = { ERROR => "エラー", WARNING =>  "警告", INFO => "INFO" }

  def initialize(setting)
    @setting = setting
    @messages = []
    @error = false
    @warning = false
    @info = false
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
    }.compact.join("\n" * 2)
  end

  def save(path = nil)
    path = File.join(@setting.archive_path, ERROR_LOG_NAME) if path.nil?
    open(path, "w") do |fp|
      fp.puts "--- エラーログ出力 #{Time.now} ---"
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
    "該当箇所: " + strings[0...70].gsub("\n", "\\n") + " ..."
  end

  #
  # 連結具合の異常を検出
  #
  def validate_singular_auto_join_brackets(raw_strings, joined_strings, bracket)
    error_result = false
    # カギ括弧の開き・閉じの数が合わない
    if joined_strings.count(bracket[0]) != joined_strings.count(bracket[1])
      warning("auto_join_in_brackets: カギ括弧(#{bracket[0]}、#{bracket[1]})の開き・閉じの数が合わないので" + \
            "連結を中止しました。カギ括弧が閉じていない、もしくは同じ種類のカギ括弧が二重に使われている" + \
            "可能性があります。\n" + \
            omit_message(raw_strings))
      error_result = true
    # 連結前の文章の改行具合を調べて、改行が閾値を超えた場合意図的な改行とみなす
    elsif raw_strings.count("\n") >= BRACKETS_RETURN_COUNT_THRESHOLD
      warning("auto_join_in_brackets: 改行が規定の回数を超えて検出されました。" + \
              "作者による意図的な改行とみなし、連結を中止しました。\n" + \
              omit_message(raw_strings))
      error_result = true
    # 連結した文章があまりにも長い場合、連結ミスをしている可能性が高い
    elsif joined_strings.length >= LINE_LENGTH_THRESHOLD
      warning("auto_join_in_brackets: 連結結果が長過ぎます。連結を中止しました。" + \
              "特殊な用途（手紙形式）等でカギ括弧が使われている可能性があります。\n" + \
            omit_message(raw_strings))
      error_result = true
    end
    error_result
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
    brackets_num_over_1 = 0
    total = 0
    max_sentence = ""
    ConverterBase::BRACKETS.each do |bracket|
      data.scan(/#{bracket[0]}(.+?)#{bracket[1]}/m) do |match|
        cnt = match[0].count("\n")
        brackets_num += 1
        next if cnt == 0
        brackets_num_over_1 += 1
        total += cnt
        if cnt > max
          max = cnt
          max_sentence = bracket[0] + match[0] + bracket[1]
        end
      end
    end
    if brackets_num_over_1 > 0
      info("カギ括弧内の改行状況:\n" + \
           "検出したカギ括弧数: #{brackets_num}、そのうち1個以上改行を含む数: #{brackets_num_over_1} \n" + \
           "1つのカギ括弧内で最大の改行数: #{max}、全カギ括弧内での改行合計: #{total}")
    end
  end
end
