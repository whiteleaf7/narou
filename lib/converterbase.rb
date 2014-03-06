# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "stringio"
require "date"
require "uri"
require "nkf"
require_relative "progressbar"
require_relative "inspector"

class ConverterBase
  KANJI_NUM = "〇一二三四五六七八九"

  attr_reader :use_dakuten_font

  def before(io, text_type)
    data = io.string
    convert_page_break(data) if @text_type == "body"
    if @text_type != "story"
      data.gsub!("\n\n", "\n")
      data.gsub!("\n\n\n", "\n\n")
    end
    io
  end

  def after(io, text_type)
    io
  end

  def initialize(setting, inspector, illustration)
    @setting = setting
    @inspector = inspector
    @illustration = illustration
    @use_dakuten_font = false
    initialize_member_values
  end

  def initialize_member_values
    @request_insert_blank_next_line = false
    @request_skip_output_line = false
    @before_line = ""
    @delay_outputs_buffer = ""
    @in_comment_block = false
    @english_sentences = []
    @url_list = []
    @illust_chuki_list = []
    @kanji_num_list = {}
    @num_and_comma_list = {}
    @in_author_comment_block = nil
  end

  def outputs(data = "", force = false)
    if !@request_skip_output_line || force
      @write_fp.puts(data)
    end
  end

  def delay_outputs(data = "")
    unless @request_skip_output_line
      @delay_outputs_buffer << data + "\n"
    end
  end

  #
  # すべての行の行末空白を削除
  #
  def rstrip_all_lines(data)
    data.gsub(/[ 　\t]+$/m, "")
  end

  #
  # 数字の変換
  #
  def convert_numbers(data)
    # 小数点を・に
    data.gsub!(/([\d０-９#{KANJI_NUM}]+?)[\.．]([\d０-９#{KANJI_NUM}]+?)/, "\\1・\\2")
    if @setting.enable_convert_num_to_kanji &&
       @text_type != "subtitle" && @text_type != "chapter" && @text_type != "story"
      num_to_kanji(data)
    else
      hankaku_num_to_zenkaku_num(data)
    end
    data
  end

  #
  # アラビア数字を漢数字に
  #
  # カンマ区切りの数字はアラビア数字のままにしておく
  # もともと漢数字なのは他の変換を受けないように退避させておく
  #
  def num_to_kanji(data)
    stash_kanji_num(data)
    data.gsub!(/[\d０-９,，]+/) do |match|
      if match =~ /[,，]/
        if match =~ /[\d]/
          stash_hankaku_num_and_comma(match.tr("，", ","))
        else
          match
        end
      else
        zenkaku_num_to_kanji(match.tr("0-9", KANJI_NUM))
      end
    end
    data
  end

  def stash_hankaku_num_and_comma(num)
    @@num_and_comma_list_counter ||= 0
    @@num_and_comma_list_counter += 1
    @num_and_comma_list[@@num_and_comma_list_counter] = num
    "［＃半角数字＝#{@@num_and_comma_list_counter}］"
  end

  def rebuild_hankaku_num_and_comma(data)
    data.gsub!(/［＃半角数字＝(.+?)］/) do
      @num_and_comma_list[$1.to_i]
    end
  end

  def stash_kanji_num(data)
    data.gsub!(/[#{KANJI_NUM}十百千万億兆京]+/).with_index do |match, i|
      if "#{$`[-1]}#{$'[0]}" =~ /[\d０-９]/
        next match
      end
      @kanji_num_list[convert_numbers(i.to_s)] = match
      "［＃漢数字＝#{i}］"
    end
  end

  def rebuild_kanji_num(data)
    data.gsub!(/［＃漢数字＝(.+?)］/) do
      @kanji_num_list[$1]
    end
  end

  #
  # 全角アラビア数字を漢数字に
  #
  def zenkaku_num_to_kanji(str)
    str.tr("０-９", KANJI_NUM)
  end

  KANJI_NUM_UNITS = %w(万 億 兆 京).unshift("")
  KANJI_KURAI = %w(十 百 千).unshift("")
  KANJI_NUM_UNITS_DIGIT = {
    "十" => 1, "百" => 2, "千" => 3, "万" => 4, "億" => 8, "兆" => 12, "京" => 16
  }

  def __calc_sum_unit(units)
    units.each_char.inject(0) do |sum, c|
      sum + ("1" + "0" * KANJI_NUM_UNITS_DIGIT[c]).to_i
    end
  end

  def __calc_kanji_num_with_unit(string)
    total = 0
    string.scan(/([#{KANJI_NUM}]*)([十百千]*)/) do |num, units|
      break if num + units == ""
      num = "1" if num.empty?
      num_tr = num.tr(KANJI_NUM, "0-9")
      if units.empty?
        total += num_tr.to_i
      else
        total += (num_tr + __calc_sum_unit(units).to_s[1, 99]).to_i
      end
    end
    total
  end

  def kanji_num_to_integer(string)
    total = 0
    string.scan(/([#{KANJI_NUM}十百千]+)([万億兆京]*)/) do |num, units|
      total += (__calc_kanji_num_with_unit(num).to_s + units.each_char.map { |c| "0" * KANJI_NUM_UNITS_DIGIT[c] }.join).to_i
    end
    total
  end

  #
  # 漢数字を単位を使った表現に変換
  #
  # ８００万１０００ といったような表現は、内部一度で 8001000 に変換する。
  # lower_digit_zero はこの最後の 000 に適用される
  #
  def convert_kanji_num_with_unit(data, lower_digit_zero = 0)
    data.gsub!(/([#{KANJI_NUM}十百千万億兆京]+)/) do |match|
      total = kanji_num_to_integer($1)
      m1 = total.to_s.tr("0-9", KANJI_NUM)
      if m1 =~ /〇{#{lower_digit_zero},}$/
        digits = m1.reverse.scan(/.{1,4}/).map(&:reverse).reverse   # 下の桁から4桁ずつ区切った配列を作成
        keta = digits.count - 1
        digits.map.with_index { |nums, keta_i|
          four_digit_num = nums.scan(/./).map.with_index { |d, di|
            next "" if d == "〇"
            kurai = KANJI_KURAI[nums.length - di - 1]
            if d == "一"
              # 4桁の千の前は一は必須ではなく、5桁以上の場合の千の前には一をつける
              # 1100 → 千百、11100 → 一万一千百
              if kurai != "" && !(keta > 0 && kurai == "千")
                d = ""
              end
            end
            d + kurai
          }.join
          if four_digit_num.length > 0
            four_digit_num + KANJI_NUM_UNITS[keta - keta_i]
          else
            ""
          end
        }.join
      else
        match
      end
    end
  end

  RECONVERT_KANJI_TO_NUM_PATTERN_UNIT = "％㎜㎝㎞㎎㎏㏄㎡㎥"

  #
  # アラビア数字を使うべきところはアラビア数字に戻す
  #
  def exception_reconvert_kanji_to_num(data)
    return unless @setting.enable_convert_num_to_kanji
    data.gsub!(/([Ａ-Ｚａ-ｚ])([#{KANJI_NUM}・～]+)/) do   # ｖｅｒ１・０１ のようなパターンも許容する
      $1 + $2.tr(KANJI_NUM, "０-９")
    end
    data.gsub!(/([#{KANJI_NUM}・～]+)([Ａ-Ｚａ-ｚ#{RECONVERT_KANJI_TO_NUM_PATTERN_UNIT}])/) do
      $1.tr(KANJI_NUM, "０-９") + $2
    end
  end

  #
  # 分数表記を○分の○表記に変更、及び日付表記を検出
  #
  # スラッシュで区切られた数字が２個なら分数、３個なら日付と定義
  #
  def convert_fraction_and_date(data)
    if !@setting.enable_transform_fraction && !@setting.enable_transform_date
      return
    end
    target_num = "\d０-９#{KANJI_NUM}十百千万億兆京垓"
    data.gsub!(/[#{target_num}\/／]+/) do |match|
      numerics = match.split(/[\/／]/)
      case numerics.count
      when 2
        # 分数
        if @setting.enable_transform_fraction
          "#{zenkaku_num_to_kanji(numerics[1])}分の#{zenkaku_num_to_kanji(numerics[0])}"
        else
          match
        end
      when 3
        # 日付
        if @setting.enable_transform_date
          begin
            date = Date.new(*numerics.map { |s|
              s.tr!("0-9０-９#{KANJI_NUM}", "0-90-90-9")
              s.to_i
            })
          rescue ArgumentError
            match
          else
            convert_numbers(date.strftime(@setting.date_format))
          end
        end
      else
        match
      end
    end
  end

  #
  # 特定の記号の直後は全角アキを挿入する
  #
  def insert_separate_space(data)
    data.gsub!(/([!?！？]+)([^!?！？])/) do
      m1, m2 = $1, $2
      m2 = "　" if m2 == " "
      if m2 =~ /[^」］\]』】〉》〕＞>≫)）"”’〟　☆★♪［―]/
        "#{m1}　#{m2}"
      else
        "#{m1}#{m2}"
      end
    end
  end

  #
  # 小説家になろう専用タグを置換
  #
  def replace_narou_tag(data)
    data.gsub!("【改ページ】", "")
    data.gsub!(/<KBR>/i, "\n")
    data.gsub!(/<PBR>/i, "\n")
  end

  ROME_NUM_ALPHABET = %w(II III IV VI VII VIII IX ii iii iv vi vii viii ix)
  ROME_NUM = %w(Ⅱ Ⅲ Ⅳ Ⅵ Ⅶ Ⅷ Ⅸ ⅱ ⅲ ⅳ ⅵ ⅶ ⅷ ⅸ)
  #
  # ローマ数字っぽいアルファベットをローマ数字に変換
  #
  # ※alphabet_to_zenkaku の前に実行する必要あり
  #
  def convert_rome_numeric(data)
    ROME_NUM_ALPHABET.each_with_index do |rome, i|
      data.gsub!(/([^a-zA-Z])#{rome}([^a-zA-Z])/, "\\1#{ROME_NUM[i]}\\2")
    end
  end

  #
  # 特定の表現・記号を変換していく
  #
  def convert_special_characters(data)
    convert_aozora_special_charactoers(data)
    symbols_to_zenkaku(data)
    convert_tatechuyoko(data)
    convert_novel_rule(data)
    convert_arrow(data)
  end

  #
  # 半角カナと ｢｣｡､･ 等を全角に変換
  #
  def hankakukana_to_zenkakukana(data)
    data.replace(NKF.nkf("-w -X", data))
  end

  #
  # 半角記号を全角に変換
  #
  def symbols_to_zenkaku(data)
    data.tr!("“”‘’〝〟", %!""''""!)
    data.gsub!(/"([^"\n]+)"/, "〝\\1〟")
    data.gsub!(/'([^'\n]+)'/, "〝\\1〟")   # MEMO: シングルミュート(ノノカギ)を表示出来るフォントはほとんど無い
    data.tr!("-=+/*《》'\"%$#&!?<>＜＞()|‐,._;:[]",
             "－＝＋／＊≪≫’”％＄＃＆！？〈〉〈〉（）｜－，．＿；：［］")
    data.gsub!("\\", "￥")
  end

  #
  # 縦中横注記取得
  #
  def tcy(str)
    "［＃縦中横］#{str}［＃縦中横終わり］"
  end

  #
  # 縦中横にすべき表現を変換
  #
  def convert_tatechuyoko(data)
    # 感嘆符及び疑問符の縦中横化
    # AozoraEPUB3の縦中横設定を使えば明示的に注記を使う必要はないが、
    # 見出しの中では自動で縦中横にはならないため、明示的指定をしておく
    # 事前に !? は全角にしておく
    data.gsub!(/！+/) do |match|
      if "#{$`[-1]}#{$'[0]}".include?("？")
        next match
      end
      len = match.length
      if len == 3
        tcy("!!!")
      elsif len >= 4
        # 4個以上なら偶数になるように調整（奇数だった場合増やす方向（+1））して2個ずつ縦中横
        len += 1 if len.odd?
        tcy("!!") * (len / 2)
      else
        match
      end
    end
    data.gsub!(/[！？]+/) do |match|
      case match.length
      when 2
        tcy(match.tr("！？", "!?"))
      when 3
        # 見た目的にこのパターンだけ縦中横化を許容する
        if %w(！！？ ？！！).find { |v| v == match }
          tcy(match.tr("！？", "!?"))
        else
          match
        end
      else
        match
      end
    end
  end

  #
  # おかしくなりやすい矢印文字の変換
  # 
  def convert_arrow(data)
    @@device ||= Narou.get_device
    # Kindle PW でしか確認してないのでとりあえず device=kindle の場合のみ変換
    if @@device && @@device.kindle?
      data.tr!("⇒⇐", "→←")
    end
  end

  #
  # 特殊な記号を外字注記に変換
  #
  def convert_aozora_special_charactoers(data)
    data.gsub!("※", "※※")   # 外字注記表記だと border_symbol? 等で困るのであとで外字注記化する
    data.gsub!("≪", "※［＃始め二重山括弧］")
    data.gsub!("≫", "※［＃終わり二重山括弧］")
  end

  #
  # ※の外字注記化
  #
  # convert_aozora_special_charactoers で2つにしておいた※を外字注記化する
  #
  def rebuild_kome_to_gaiji(data)
    data.gsub!("※※", "※［＃米印、1-2-8］")
  end

  #
  # 濁点のついてない文字に濁点をつける表現を対応
  #
  # 濁点つきフォントに部分的に切り替える
  #
  def convert_dakuten_char_to_font(data)
    data.gsub!(/(.)[゛ﾞ]/) do
      m1 = $1
      if m1 =~ /[ぁ-んァ-ヶι]/ && @setting.enable_dakuten_font
        @use_dakuten_font = true
        "［＃濁点］#{m1}［＃濁点終わり］"
      else
        tcy(m1 + "゛")
      end
    end
  end

  #
  # 小説のルールに沿うように変換
  #
  def convert_novel_rule(data)
    # 括弧の閉じの直前の句点を消す
    data.gsub!(/。([」』）])/, "\\1")
    # 原則偶数個を１セットで使うべき文字を偶数個に補正
    # MEMO:（―も偶数個セットにするべきだが、記号的な意味で使われる場合もあるので無視）
    %w(… ‥).each do |target|
      data.gsub!(/#{target}+/) do |match|
        len = match.length
        len += 1 if len.odd?
        target * len
      end
    end
    # たまに見かける誤字対策
    data.gsub!(/。　/, "。")
    data.gsub!(/([？！])。/, "\\1")
  end

  #
  # 半角アルファベットを全角に変換する
  #
  # force : 強制的に全アルファベットを全角にするか？
  #         false の場合、英文章（半角スペースで区切られた2単語以上）を半角のままにする
  #
  def alphabet_to_zenkaku(data, force = false)
    if force
      data.gsub!(/[a-zA-Z]+/) do |match|
        match.tr("a-zA-Z", "ａ-ｚＡ-Ｚ")
      end
    else
     data.gsub!(/[\w.,!?' ]+/) do |match|
        if match.split(" ").count > 1
          @english_sentences << match
          "［＃英文＝#{@english_sentences.count - 1}］"
        else
          match.tr("a-zA-Z", "ａ-ｚＡ-Ｚ")
        end
      end
    end
  end

  #
  # 英文を再構成する
  #
  def rebuild_english_sentences(data)
    @english_sentences.each_with_index do |sentence, id|
      data.sub!("［＃英文＝#{convert_numbers(id.to_s)}］", sentence)
    end
  end

  #
  # コメントブロックを検出する
  #
  # コメントブロックの定義は - のみが50回以上連続された行に囲まれている間
  #
  def comments_block?(line)
    if line =~ /^-{50,}$/
      @in_comment_block ^= 1
      return true
    end
    @in_comment_block
  end

  #
  # コメントブロックを削除する
  #
  def erase_comments_block(data)
    data.gsub!(/^-{50,}\n.*^-{50,}\n/m, "")
  end

  #
  # 全角数字を半角アラビア数字に
  #
  def zenkaku_num_to_hankaku_num(num)
    num.tr("０-９#{KANJI_NUM}", "0-90-9")
  end

  #
  # 半角アラビア数字の全角化
  #
  # 1桁、3桁以上：全角化
  # 2桁：縦中横化
  #
  def hankaku_num_to_zenkaku_num(data)
    data.gsub!(/\d+/) do |num|
      if num.length == 2
        tcy(num)
      elsif num.length == 3 && @text_type == "subtitle" && $`.empty?
        tcy(num)
      else
        num.tr("0-9", "０-９")
      end
    end
    data
  end
  
  HALF_INDENT_TARGET = /^[ 　\t]*([〔「『(（【〈《≪〝])/
  FULL_INDENT_TARGET = /^[ 　\t]*(――)/
  AUTO_INDENT_IGNORE_INDENT_CHAR = Inspector::IGNORE_INDENT_CHAR.sub("・", "")
  #
  # 行頭かぎ括弧(等)に二分アキを追加する
  #
  # 「や（などの前にカスタム注記（［＃二分アキ］）を追加し、半文字分字下げする(二分アキ)。
  # kindle paperwhite で鍵括弧のインデントがおかしいことへの対応
  #
  def half_indent_bracket(data)
    data.gsub!(HALF_INDENT_TARGET, "［＃二分アキ］\\1") if @setting.enable_half_indent_bracket
  end

  #
  # 行頭字下げ
  #
  # 必ず下げなければいけないところは強制的に字下げ
  # 他の部分は全体的に判断して字下げ
  #
  def auto_indent(data)
    data.gsub!(FULL_INDENT_TARGET, "　\\1")
    if @setting.enable_auto_indent && @inspector.inspect_indent(data)
      data.gsub!(/^([^#{AUTO_INDENT_IGNORE_INDENT_CHAR}])/) do
        # 行頭に三点リーダーの代わりに連続中黒（・・・）が来た場合の対策
        # https://github.com/whiteleaf7/narou/issues/35
        # 行頭に中黒１個だけの場合はよくある表現なので字下げしない
        if $1 == "・" && $'[0] != "・"
          "・"
        else
          $1 == " " || $1 == "　" ? "　" : "　#{$1}"
        end
      end
    end
  end

  #
  # 章見出しっぽい文字列を字下げして前後に空行を入れる
  #
  # TODO: 半角数字の縦中横注記をいれた影響で、2桁の半角数字が認識されてないのをどうにかする
  #
  def force_indent_special_chapter(line)
    line.sub!(/^(?:[ 　\t]|［＃二分アキ］)*([－―<＜〈-]*)([0-9０-９#{KANJI_NUM}]+)([－―>＞〉-]*)$/) do
      @request_insert_blank_next_line = true
      top, chapter, bottom = $1, $2, $3
      if top != "" && "―－-".include?(top)
        top = "― "
        bottom = " ―"
      end
      (blank_line?(@before_line) ? "" : "\n") + "　　　［＃ゴシック体］" + \
      top + hankaku_num_to_zenkaku_num(zenkaku_num_to_hankaku_num(chapter)) + bottom + "［＃ゴシック体終わり］"
    end
  end

  #
  # 行頭空白を考慮した字下げ
  #
  def jisage(line, num)
    line.sub!(/^[ 　\t]*/, "　" * num)
  end

  def border_symbol?(line)
    @@symbols ||= open(File.join(Narou.get_preset_dir, "bordersymbols.txt"), "r:BOM|UTF-8") { |fp|
      fp.read.strip
    }
    line =~ /^[ 　\t]*[#{@@symbols}]+$/
  end

  def blank_line?(line)
    line =~ /\A[ 　\t]*$/
  end

  #
  # ■などの区切りの前後には空行が必ず存在するようにする
  #
  def insert_blank_line_to_border_symbol(line)
    result = ""
    if border_symbol?(line)
      unless blank_line?(@before_line)
        result << "\n"
      end
      @request_insert_blank_next_line = true
      jisage(line, 4)
    end
    line.sub!(/\A/, result)
  end

  #
  # 改ページある？
  #
  def page_break?(line)
    line =~ /［＃改ページ］/
  end

  #
  # 前書き・後書きの検出及び処理 ==============================
  #

  AUTHOR_INTRODUCTION_SPLITTER = /^　*[\*＊]{44}$/
  AUTHOR_POSTSCRIPT_SPLITTER = /^　*[\*＊]{48}$/
  AUTHOR_COMMENT_CHUKI = {
    introduction: {
      open: "［＃ここから前書き］", close: "［＃ここで前書き終わり］"
    },
    postscript: {
      open: "［＃ここから後書き］", close: "［＃ここで後書き終わり］"
    }
  }

  def process_author_comment(line)
    if @setting.enable_author_comments
      if @in_author_comment_block
        if leave_author_comment_block?(line)
          outputs(AUTHOR_COMMENT_CHUKI[@in_author_comment_block][:close])
          if @in_author_comment_block == :introduction
            @request_skip_output_line = true
            line.clear
            @in_author_comment_block = nil
          elsif @in_author_comment_block == :postscript
            @in_author_comment_block = nil
            # ［＃改ページ］（前書きの開始位置）を検出したため、
            # 改めて前書きの検出をする
            process_author_comment(line)
          end
        end
      else
        if inclusion_author_comment_block?(line)
          # outputs を使うと改ページより前に注記が入ってしまうため、
          # delay_outputs を使って出力を line 出力の後に遅らせる
          delay_outputs(AUTHOR_COMMENT_CHUKI[@in_author_comment_block][:open]) 
          if @in_author_comment_block == :postscript
            @request_skip_output_line = true
            line.clear
          end
        end
      end
    end
  end

  # 前書きの検出
  def find_introduction?
    pos = @read_fp.pos
    result = false
    @read_fp.each do |line|
      break if page_break?(line)
      if line =~ AUTHOR_INTRODUCTION_SPLITTER
        result = true
        break
      end
    end
    @read_fp.pos = pos
    result
  end

  def inclusion_author_comment_block?(line)
    result = false
    if page_break?(line)
      if find_introduction?
        @in_author_comment_block = :introduction
        result = true
      end
    elsif line =~ AUTHOR_POSTSCRIPT_SPLITTER
      @in_author_comment_block = :postscript
      result = true
    end
    result
  end

  def leave_author_comment_block?(line)
    result = false
    case @in_author_comment_block
    when :introduction
      if line =~ AUTHOR_INTRODUCTION_SPLITTER
        result = true
      end
    when :postscript
      if page_break?(line)
        result = true
      end
    end
    result
  end

  def author_comment_force_close
    if @in_author_comment_block
      outputs(AUTHOR_COMMENT_CHUKI[@in_author_comment_block][:close])
    end
  end

  # ==================================================

  BRACKETS = [%w(「 」), %w(『 』)]

  # ネストに対応したかぎ括弧の正規表現
  OPENCLOSE_REGEXPS = BRACKETS.map { |bracket|
    bo, bc = bracket
    /(?<oc>#{bo}[^#{bo+bc}]*(?:\g<oc>[^#{bo+bc}]*)*#{bc})/m
  }

  #
  # 改行を連結した文章を作る
  #
  # 改行がひとつもなかった場合は nil を返す
  #
  def join_inner_bracket(str)
    joined_str = str.dup
    return nil if str.count("\n") == 0
    joined_str.gsub!(/([…―])\n/, "\\1。\n")
    joined_str = joined_str.split("\n").map { |s|
      s.sub(/^　+/, "")
    }.join
    joined_str
  end

  #
  # かぎ括弧内自動連結
  #
  def auto_join_in_brackets(data)
    if !@setting.enable_auto_join_in_brackets && !@setting.enable_inspect_invalid_openclose_brackets
      return
    end
    OPENCLOSE_REGEXPS.each_with_index do |openclose, i|
      stack = {}
      data.gsub!(openclose).with_index do |match, j|
        joined_str = join_inner_bracket(match)
        if @setting.enable_auto_join_in_brackets && joined_str
          error = @inspector.validate_joined_inner_brackets(match, joined_str, BRACKETS[i])
          stack[j] = error ? match : joined_str
        else
          stack[j] = match
        end
        "［＃かぎ括弧＝#{j}］"
      end
      if @setting.enable_inspect_invalid_openclose_brackets
        # 正しく閉じてないかぎ括弧だけが data に残ってる
        @inspector.inspect_invalid_openclose_brackets(data, BRACKETS[i], stack)
      end
      data.replace(ConverterBase.rebuild_brackets(data, stack))
    end
  end

  def self.rebuild_brackets(data, stack)
    data.gsub(/［＃かぎ括弧＝(\d+)］/) do
      stack[$1.to_i]
    end
  end

  #
  # 手動折り返しの自動連結
  #
  def auto_join_line(data)
    # 次の行の冒頭が開き記号だったら意図的な改行だと判断して連結しない
    data.gsub!(/([^、])、\n　([^「『(（【<＜〈《≪…‥―])/, "\\1、\\2")
  end

  #
  # 小説家になろうのルビ対策
  #
  def narou_ruby(data)
    if @text_type != "subtitle" && @text_type != "chapter"
      # 《》なルビの対処
      data.gsub!(/(.+?)≪(.+?)≫/) do |match|
        to_ruby(match, $1, $2, ["≪", "≫"])
      end
      # （）なルビの対処
      data.gsub!(/(.+?)（([ぁ-んァ-ヶーゝゞ・Ａ-Ｚａ-ｚA-Za-z　]{,20})）/) do |match|
        to_ruby(match, $1, $2, ["（", "）"])
      end
    end
    data.replace(replace_tatesen(data))
    data.gsub!("［＃ルビ用縦線］", "｜")
  end

  CHARACTER_OF_RUBY = "一-龠Ａ-Ｚａ-ｚA-Za-z"

  def object_of_ruby?(char)
    char =~ /[#{CHARACTER_OF_RUBY}]/
  end

  def is_sesame?(str, ten, last_char)
    ten =~ /^[・、]+$/ && (str.include?("｜") || object_of_ruby?(last_char))
  end

  def sesame(str, ten)
    if str.include?("｜")
      str.sub("｜", "［＃傍点］") + "［＃傍点終わり］"
    else
      str.sub(/([#{CHARACTER_OF_RUBY}　]+)$/) {
        match_target = $1
        if match_target =~ /^(　+)/
          "#{$1}［＃傍点］#{match_target[$1.length..-1]}"
        else
          "［＃傍点］#{match_target}"
        end
      } + "［＃傍点終わり］"
    end
  end

  def replace_tatesen(str)
    str.gsub("｜", "※［＃縦線］")
  end

  def to_ruby(match, m1, m2, openclose_symbols)
    last_char = m1[-1]
    case
    when last_char == "｜"
      # 直前に｜がある場合ルビ化は抑制される
      "#{m1[0...-1]}#{openclose_symbols[0]}#{m2}#{openclose_symbols[1]}"
    when is_sesame?(m1, m2, last_char)
      sesame(m1, m2)
    when m1.include?("｜")
      "#{m1.sub(/｜([^｜]*)$/, "［＃ルビ用縦線］\\1")}《#{m2}》"
    when object_of_ruby?(last_char)
      # なろうのルビ対象文字を辿って｜を挿入する（青空文庫となろうのルビ仕様の差異吸収のため）
      m1.sub(/([#{CHARACTER_OF_RUBY}　]+)$/) {
        match_target = $1
        if match_target =~ /^(　+)/
          "#{$1}［＃ルビ用縦線］#{match_target[$1.length..-1]}"
        else
          "［＃ルビ用縦線］#{match_target}"
        end
      } + "《#{m2}》"
    else
      match
    end
  end

  #
  # 全角版 String#rstrip!
  #
  def zenkaku_rstrip(line)
    line.gsub!(/[　\s]+\z/, "")
  end

  #
  # URL っぽい文字列を一旦別のIDに置き換えてあとで復元することで、変換処理の影響を受けさせない
  #
  def replace_url(data)
    data.gsub!(URI.regexp) do |match|
      @url_list << match
      "［＃ＵＲＬ＝#{@url_list.count - 1}］"
    end
  end

  def rebuild_url(data)
    @url_list.each_with_index do |url, id|
      data.sub!("［＃ＵＲＬ＝#{convert_numbers(id.to_s)}］",
                "<a href=\"#{url}\">#{url}</a>")
    end
  end

  #
  # 挿絵タグやimgタグ等を挿絵注釈に変換
  # 挿絵画像が存在しなければダウンロードして保存する
  #
  def replace_illust_tag(data)
    @illustration.scanner(data) do |chuki|
      next "" unless @setting.enable_illust
      @illust_chuki_list << chuki
      "［＃挿絵＝#{@illust_chuki_list.count - 1}］\n"
    end
  end

  def rebuild_illust(data)
    @illust_chuki_list.each_with_index do |chuki, id|
      data.sub!("［＃挿絵＝#{convert_numbers(id.to_s)}］", chuki)
    end
  end

  #
  # 中黒(・)や句読点を並べて三点リーダーもどきにしているのを三点リーダーに変換
  #
  def convert_horizontal_ellipsis(data)
    return if !@setting.enable_convert_horizontal_ellipsis || @text_type == "subtitle" || @text_type == "chapter"
    %w(・ 。 、).each do |char|
      data.gsub!(/#{char}{3,}/) do |match|
        pre_char, post_char = $`[-1], $'[0]
        if pre_char == "―" || post_char == "―"
          match
        else
          "…" * ((match.length / 3.0 / 2).ceil * 2)
        end
      end
    end
    data.gsub!("。。", "。")
    data.gsub!("、、", "、")
  end

  #
  # 漢字の二じゃなくて間違えてカタカナのニを使ってるのを校正する
  #
  def modify_kana_ni_to_kanji_ni(data)
    data.gsub!(/([^ァ-ヶー])ニ([^ァ-ヶー])/, "\\1二\\2")
  end

  #
  # ［＃改ページ］直後の行を見出しに設定する
  #
  def enchant_midashi(data)
    def midashi(str)
      midashi_title = str.gsub("［＃半字下げ］", "").gsub(/^[　\s]+/, "").gsub(/[　\s]+$/, "")
      @inspector.subtitle = midashi_title
      "［＃３字下げ］［＃ここから中見出し］#{midashi_title}［＃ここで中見出し終わり］"
    end

    data.gsub!(/［＃改ページ］\n(.+?)\n/) do |match|
      m1 = $1
      rest = $'
      if $1 =~ /#{AUTHOR_COMMENT_CHUKI[:introduction][:open]}/
        match
      else
        # 見出しの次の行が空行ではない場合空行を追加する
        add_tail = rest =~ /\A$/ ? "" : "\n\n"
        "［＃改ページ］\n#{midashi(m1)}\n#{add_tail}"
      end
    end
    data.gsub!(/(［＃改ページ］\n)(#{AUTHOR_COMMENT_CHUKI[:introduction][:open]}.+?#{AUTHOR_COMMENT_CHUKI[:introduction][:close]}\n)(.+?\n)/m) do
      m1, m2, m3 = $1, $2, $3
      add_tail = $' =~ /\A$/ ? "" : "\n"
      "#{m1 + midashi(m3) + m2}#{add_tail}"   # 前書き→見出しの順番を見出し→前書きに入れ替えて置換
    end
  end

  #
  # 前書きを削除する
  #
  def erase_introduction(data)
    del_count = 0
    data.gsub!(/(［＃改ページ］)\n#{AUTHOR_COMMENT_CHUKI[:introduction][:open]}.+?#{AUTHOR_COMMENT_CHUKI[:introduction][:close]}/m) do
      del_count += 1
      $1
    end
    if del_count > 0
      @inspector.info("前書きをすべて削除しました。削除した数は#{del_count}個です。")
    end
  end

  #
  # 後書きを削除する
  #
  def erase_postscript(data)
    del_count = 0
    data.gsub!(/#{AUTHOR_COMMENT_CHUKI[:postscript][:open]}.+?#{AUTHOR_COMMENT_CHUKI[:postscript][:close]}\n(［＃改ページ］|\z)/m) do
      del_count += 1
      $1
    end
    if del_count > 0
      @inspector.info("後書きをすべて削除しました。削除した数は#{del_count}個です。")
    end
  end

  #
  # 一定以上の連続する空行を改ページに変換
  #
  def convert_page_break(data)
    if @setting.enable_convert_page_break
      threshold = @setting.to_page_break_threshold + 1
      # `改ページ' を使うと見出し付与等で混乱するので自動生成したものは区別する
      data.gsub!(/\n{#{threshold},}/, "\n［＃改頁］\n")
    end
  end

  #
  # 小説データ全体に対して施す変換
  #
  def convert_for_all_data(data)
    hankakukana_to_zenkakukana(data)
    auto_join_in_brackets(data)
    auto_join_line(data) if @setting.enable_auto_join_line
    erase_comments_block(data)
    replace_illust_tag(data)
    replace_url(data)
    replace_narou_tag(data)
    convert_rome_numeric(data)
    alphabet_to_zenkaku(data, @setting.enable_alphabet_force_zenkaku)
    convert_numbers(data)
    exception_reconvert_kanji_to_num(data)
    if @setting.enable_convert_num_to_kanji && @text_type != "subtitle" && @text_type != "chapter" \
       && @setting.enable_kanji_num_with_units
      convert_kanji_num_with_unit(data, @setting.kanji_num_with_units_lower_digit_zero)
    end
    rebuild_kanji_num(data)
    insert_separate_space(data)
    convert_special_characters(data)
    convert_fraction_and_date(data)
    modify_kana_ni_to_kanji_ni(data)
    if @text_type == "body" || @text_type == "textfile"
      half_indent_bracket(data)
      auto_indent(data)
    end
    convert_dakuten_char_to_font(data)
  end

  def before_convert(io)
    before(io, @text_type)
  end

  def after_convert(io)
    after(io, @text_type)
  end

  def convert(text, text_type)
    return "" if text == ""
    @text_type = text_type
    io = StringIO.new(rstrip_all_lines(text))
    (io = before_convert(io)).rewind
    (io = convert_main(io)).rewind
    (io = after_convert(io)).rewind
    return io.read
  end

  #
  # 変換処理本体
  #
  # @text_type: 渡されるテキストの種類。
  #             subtitle, introduction, body, postscript, textfile, chapter, story
  #
  def convert_main(io)
    @write_fp = StringIO.new
    case @text_type
    when "introduction"
      return @write_fp if @setting.enable_erase_introduction
    when "postscript"
      return @write_fp if @setting.enable_erase_postscript
    end
    if @text_type == "textfile"
      @write_fp.puts(io.gets + io.gets)   # タイトル・著者名スキップ
      data = io.read
    else
      data = io.read
    end
    initialize_member_values
    convert_for_all_data(data)
    if @text_type == "textfile"
      # convert_for_all_data -> replace_narou_tag
      # で改行化を行わないと正確な改行数は分からない
      progressbar = ProgressBar.new(data.count("\n") + 1)
      progressbar.output(0)
    end
    @read_fp = StringIO.new(data)
    if @text_type == "subtitle"
      @write_fp.write(data)
    else
      @read_fp.each_with_index do |line, i|
        progressbar.output(i) if @text_type == "textfile"
        @request_skip_output_line = false
        zenkaku_rstrip(line)
        if @request_insert_blank_next_line
          outputs unless blank_line?(line)
          @request_insert_blank_next_line = false
        end
        process_author_comment(line) if @text_type == "textfile"
        insert_blank_line_to_border_symbol(line)
        force_indent_special_chapter(line)

        outputs(line)
        unless @delay_outputs_buffer.empty?
          @write_fp.write(@delay_outputs_buffer)
          @before_line = @delay_outputs_buffer
          @delay_outputs_buffer = ""
        else
          @before_line = line
        end
      end
      author_comment_force_close if @text_type == "textfile"
    end

    @write_fp.rewind
    data = @write_fp.string
    if @text_type == "textfile"
      if @setting.enable_author_comments
        erase_introduction(data) if @setting.enable_erase_introduction
        erase_postscript(data) if @setting.enable_erase_postscript
      end
      if @setting.enable_enchant_midashi
        enchant_midashi(data)
      end
    end
    rebuild_illust(data)
    rebuild_url(data)
    rebuild_english_sentences(data)
    rebuild_hankaku_num_and_comma(data)
    rebuild_kome_to_gaiji(data)
    # 再構築された文章にルビがふられる可能性を考慮して、
    # この位置でルビの処理を行う
    narou_ruby(data) if @setting.enable_ruby
    # 三点リーダーの変換は、ルビで圏点として・・・を使っている場合を考慮して、ルビ処理後にする
    convert_horizontal_ellipsis(data)
    data.strip!
    progressbar.clear if @text_type == "textfile"
    @write_fp
  end

  #
  # replace.txt により単純置換
  #
  def replace_by_replace_txt(text)
    @setting.replace_pattern.each do |pattern|
      src, dst = pattern
      text.gsub!(src, dst)
    end
  end
end
