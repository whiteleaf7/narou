# frozen_string_literal: true

#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "diff/lcs"

#
# 指定されたソースの差分を作成する
#
# 書式はなんちゃってunified contextなので、パッチ作成には使えません
#
class DiffViewer
  class InvalidSourceType < StandardError; end

  def initialize(old, new, source = :file)
    case source
    when :file
      old_strings = File.read(old, :encoding => Encoding::UTF_8)
      new_strings = File.read(new, :encoding => Encoding::UTF_8)
    when :string
      old_strings = old
      new_strings = new
    else
      raise InvalidSourceType, "source supported options are ':file' and ':string'"
    end
    old_strings.gsub!("\r", "")
    new_strings.gsub!("\r", "")
    @builded_buffer = +""
    @events = Diff::LCS.sdiff(old_strings.split("\n"), new_strings.split("\n"))
    build
  end

  def to_s
    @builded_buffer
  end

  def view
    puts @builded_buffer
  end

  private

  def build
    @buffer = {}
    pos = 0
    events_size = @events.size
    while pos < events_size
      pos = output_differing_line_and_before_and_behind(pos)
    end
    before_index = -1000
    @builded_buffer = @buffer.sort_by { |index|
      # buffer の格納順はバラバラなのでソートしておく
      index
    }.map { |(index, (event, str))|
      # index が途切れたら、ポジション情報を付与する
      result = +""
      if index - before_index >= 2
        result += "<bold><cyan>@@ -#{event.old_position+1}, " \
                  "+#{event.new_position+1} @@</cyan></bold>\n".termcolor
      end
      result += str
      before_index = index
      result
    }.join("\n")
  end

  #
  # 指定ラインが編集・追加・削除されていた行だったら前後３行をバッファに出力
  #
  def output_differing_line_and_before_and_behind(index, force = false)
    last = index + 1
    return last if @buffer[index] || index < 0
    event = @events[index] or return last
    if %w(! + -).include?(event.action)
      @buffer[index] = [event, decorate_event(event)]
      ((index - 3)..(index + 3)).each do |i|
        output_differing_line_and_before_and_behind(i, true)
      end
      last = index + 3 + 1
    elsif force
      @buffer[index] = [event, " #{event.old_element}"]
    end
    last
  end

  #
  # レーベンシュタイン距離を計算する
  #
  # differ には Diff::LCS.sdiff で処理したものをそのまま渡す
  #
  def calc_levenshtein_distance(differ)
    differ.reject { |e| e.unchanged? }.size
  end

  #
  # event.action を見てラインを装飾
  #
  def decorate_event(event)
    result = +""
    old_element = event.old_element
    new_element = event.new_element
    case event.action
    when "!"
      old_str = +""
      new_str = +""
      line_events = Diff::LCS.sdiff(old_element, new_element)
      distance = calc_levenshtein_distance(line_events)
      # レーベンシュタイン距離を正規化する
      size = [old_element.length, new_element.length].max
      normalized_distance = distance / size.to_f
      if normalized_distance > 0.7
        # 双方の文字列があまりにも似ていない場合、編集部分をカラー化すると
        # 非常に見づらい表示になってしまうので、単純に削除・追加のみ装飾する
        old_str = TermColorLight.escape(old_element)
        new_str = TermColorLight.escape(new_element)
      else
        line_events.each do |e|
          os = TermColorLight.escape(e.old_element) rescue ""
          ns = TermColorLight.escape(e.new_element) rescue ""
          case e.action
          when "="
            old_str += os
            new_str += ns
          when "!"
            os = "<underline>#{os}</underline>" if os == " " || os == "　"
            ns = "<underline>#{ns}</underline>" if ns == " " || os == "　"
            old_str += "<reverse><on_black><yellow>#{os}</yellow></on_black></reverse>"
            new_str += "<reverse><on_black><yellow>#{ns}</yellow></on_black></reverse>"
          when "-"
            old_str += "<reverse>#{os}</reverse>"
          when "+"
            new_str += "<reverse>#{ns}</reverse>"
          end
        end
      end
      result = "<bold><red>-#{old_str}</red></bold>\n" \
               "<bold><green>+#{new_str}</green></bold>"
    when "-"
      result = "<bold><red>-#{TermColorLight.escape(old_element)}</red></bold>"
    when "+"
      result = "<bold><green>+#{TermColorLight.escape(new_element)}</green></bold>"
    end
    result.termcolor
  end
end
