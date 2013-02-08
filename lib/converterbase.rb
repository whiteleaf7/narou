# -*- coding: UTF-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "stringio"
require "date"
require "uri"
require_relative "progressbar"

class ConverterBase
  KANJI_NUM = "〇一二三四五六七八九"

  def before_convert(io, text_type)
    data = io.read
    data.gsub!("\n\n", "\n")
    data.gsub!("\n\n\n", "\n\n")
    StringIO.new(data)
  end

  def after_convert(io, text_type)
    io
  end

  def initialize(setting, inspector, illustration)
    @setting = setting
    @inspector = inspector
    @illustration = illustration
    @english_sentences = []
    initialize_member_values
  end

  def initialize_member_values
    @request_insert_blank_next_line = false
    @request_skip_output_line = false
    @before_line = ""
    @delay_outputs_buffer = ""
    @in_comment_block = false
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
    data.gsub!(/^[ 　\t]+$/m, "")
  end

  #
  # アラビア数字を漢数字に
  #
  # カンマ区切りの数字はアラビア数字のままにしておく
  #
  def num_to_kanji(data)
    data.gsub!(/([\d０-９#{KANJI_NUM}]+?)[\.．]([\d０-９#{KANJI_NUM}]+?)/, "\\1・\\2")
    return unless @setting.enable_convert_num_to_kanji
    data.gsub!(/[\d０-９,，]+/) do |match|
      if match =~ /[,，]/
        match
      else
        zenkaku_num_to_kanji(match.tr("0-9", KANJI_NUM))
      end
    end
  end

  #
  # 全角アラビア数字を漢数字に
  #
  def zenkaku_num_to_kanji(str)
    str.tr("０-９", KANJI_NUM)
  end

  KANJI_NUM_UNITS = %w(万 億 兆 京 垓).unshift("")
  KANJI_KURAI = %w(十 百 千).unshift("")
  #
  # 漢数字を単位を使った表現に変換
  #
  def convert_kanji_num_with_unit(data, lower_digit_zero = 0)
    data.gsub!(/([#{KANJI_NUM}]+)([十百千万億兆京垓]?)/) do |match|
      next match unless $2.empty?
      m1 = $1
      if m1 =~ /^[一二三四五六七八九]+〇{#{lower_digit_zero},}$/
        digits = m1.reverse.scan(/.{1,4}/).map(&:reverse).reverse   # 下の桁から4桁ずつ区切った配列を作成
        keta = digits.count - 1
        digits.map.with_index { |nums, keta_i|
          nums.scan(/./).map.with_index { |d, di|
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
          }.join + KANJI_NUM_UNITS[keta - keta_i]
        }.join
      else
        match
      end
    end
  end

  #
  # アラビア数字を使うべきところはアラビア数字に戻す
  #
  def exception_reconvert_kanji_to_num(data)
    return unless @setting.enable_convert_num_to_kanji
    data.gsub!(/([Ａ-Ｚａ-ｚ])([#{KANJI_NUM}]+)/) do
      $1 + $2.tr(KANJI_NUM, "０-９")
    end
    data.gsub!(/([#{KANJI_NUM}]+)([Ａ-Ｚａ-ｚ])/) do
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
            num_to_kanji(date.strftime(@setting.date_format))
          end
        end
      else
        match
      end
    end
  end

  #
  # 特定の記号の直後は全角スペースを挿入する
  #
  def insert_separate_space(data)
    data.gsub!(/([!?！？]+)([^!?！？])/) do
      m1, m2 = $1, $2
      m2 = "　" if m2 == " "
      if m2 =~ /[^」］』】〉》〕＞>≫)）"”’　［]/
        "#{m1}　#{m2}"
      else
        "#{m1}#{m2}"
      end
    end
  end

  #
  # 小説家になろうの携帯用タグの削除
  #
  def delete_narou_mobile_tag(data)
    data.gsub!("【改ページ】", "")
    data.gsub!("<KBR>", "")
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
    symbols_to_zenkaku(data)
    convert_tatechuyoko(data)
    convert_novel_rule(data)
  end

  #
  # 記号を全角に変換
  #
  def symbols_to_zenkaku(data)
    data.tr!("“”‘’", %!""''!)
    data.gsub!(/"([^"]+)"/, "“\\1”")
    data.gsub!(/'([^']+)'/, "‘\\1’")
    data.tr!("-=+/*《》'\"%$#&!?､<>＜＞()|‐,._;:",
             "－＝＋／＊≪≫’”％＄＃＆！？、〈〉〈〉（）｜－，．＿；：")
    data.gsub!("\\", "￥")
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
      len = match.length
      if len >= 4
        # 4個以上なら偶数になるように調整（奇数だった場合増やす方向（+1））して2個ずつ縦中横
        len += 1 if len.odd?
        "［＃縦中横］!!［＃縦中横終わり］" * (len / 2)
      else
        match
      end
    end
    %w(！！？ ！？！ ？？？ ？！？ ？？ ？！？ ？？！ ！！！ ！！ ！？ ？！).each do |target|
      dest = "［＃縦中横］" + target.tr("！？", "!?") + "［＃縦中横終わり］"
      data.gsub!(target) do
        dest
      end
    end
  end

  #
  # 濁点のついてない文字に濁点をつける表現を対応
  #
  # 濁点つきフォントに部分的に切り替える
  #
  def replace_dakuten_font(data)
    data.gsub!(/(.)[゛ﾞ]/) do
      "［＃濁点］#{$1}［＃濁点終わり］"
    end
    #data.gsub!(/(.)[゛ﾞ]/, "\\1ﾞ［＃「\\1ﾞ」は縦中横］")
    #data.gsub!(/(.)[゜ﾟ]/, "\\1ﾟ［＃「\\1ﾟ」は縦中横］")
  end

  #
  # 小説のルールに沿うように変換
  #
  def convert_novel_rule(data)
    # 括弧の閉じの直前の句点を消す
    data.gsub!(/。([」』）])/, "\\1")
    # 原則偶数個を１セットで使うべき文字を偶数個に補正
    # （―も偶数個セットにするべきだが、記号的な意味で使われる場合もあるので無視）
    %w(…).each do |target|
      data.gsub!(/#{target}{3,}/) do |match|
        len = match.length
        len += 1 if len.odd?
        target * len
      end
    end
    # たまに見かける誤字対策
    data.gsub!(/。+/, "。")
    data.gsub!(/、+/, "、")
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
      data.sub!("［＃英文＝#{num_to_kanji(id.to_s)}］", sentence)
    end
  end

  #
  # コメントブロックを検出する
  #
  # コメントブロックの定義は - のみがが50回以上連続された行に囲まれている間
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
  # 行頭字下げ
  #
  # 「や（などの前に空白を追加し、若干字下げさせる
  #
  def force_indent_special_character(data)
    half_indent_target = /^[ 　\t]*([「『(（【〈《≪])/
    full_indent_target = /^[ 　\t]*(――)/
    data.gsub!(half_indent_target, "［＃半字下げ］\\1") if @setting.enable_hanji_sage
    data.gsub!(full_indent_target, "　\\1")
  end

  #
  # 章見出しっぽい文字列を字下げして前後に空行を入れる
  #
  def force_indent_special_chapter(line)
    line.sub!(/^[ 　\t]*([－―<＜〈-])([0-9０-９#{KANJI_NUM}]+)([－―>＞〉-])$/) do
      @request_insert_blank_next_line = true
      top, chapter, bottom = $1, $2, $3
      if "―－-".include?(top)
        top = "― "
        bottom = " ―"
      end
      (blank_line?(@before_line) ? "" : "\n") + "　　　［＃ゴシック体］" + \
      top + zenkaku_num_to_hankaku_num(chapter) + bottom + "［＃ゴシック体終わり］"
    end
  end

  #
  # 行頭空白を考慮した字下げ
  #
  def jisage(line, num)
    line.sub!(/^[ 　\t]+/, "　" * num)
  end

  def border_symbol?(line)
    line =~ /^[ 　\t]*[■□◆◇○◎●★☆\*＊※　 ]+$/
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
      jisage(line, 3)
    end
    line.sub!(/\A/, result)
  end

  #
  # 改ページある？
  #
  def kai_page?(line)
    line =~ /［＃(?:改ページ|改丁|改頁|改段)］/
  end

  #
  # 前書き・後書きの検出及び処理 ==============================
  #

  AUTHOR_INTRODUCTION_SPLITTER = /^[\*＊]{44}$/
  AUTHOR_POSTSCRIPT_SPLITTER = /^[\*＊]{48}$/
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
      unless @in_author_comment_block
        if inclusion_author_comment_block?(line)
          # outputs を使うと改ページより前に注記が入ってしまうため、
          # delay_outputs を使って出力を line 出力の後に遅らせる
          delay_outputs(AUTHOR_COMMENT_CHUKI[@in_author_comment_block][:open]) 
          if @in_author_comment_block == :postscript
            @request_skip_output_line = true
            line.clear
          end
        end
      else
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
      end
    end
  end

  # 前書きの検出
  def find_introduction?
    pos = @read_fp.pos
    result = false
    @read_fp.each do |line|
      break if kai_page?(line)
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
    if kai_page?(line)
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
      if kai_page?(line)
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
  #
  # カギ括弧内自動連結
  #
  def auto_join_in_brackets(data)
    BRACKETS.each do |bracket|
      data.gsub!(/#{bracket[0]}(.+?)#{bracket[1]}/m) do |match|
        joined_str = match.dup
        joined_str.gsub!(/([…―])\n/, "\\1。\n")
        joined_str = joined_str.split("\n").map { |s|
          s.sub(/^　/, "")
        }.join
        error = @inspector.check_auto_join_brackets(match, joined_str, bracket)
        if error
          # 連結した文章を検査した結果、異常を検知したため連結を中止する
          match
        else
          joined_str
        end
      end
    end
  end

  #
  # 手動折り返しの自動連結
  #
  def auto_join_line(data)
    # 次の行の冒頭が開き記号だったら意図的な改行だと判断して連結しない
    data.gsub!(/、\n　([^「『(（【<＜〈《≪])/, "、\\1")
    # TODO: 文章の途中で不自然に改行しているところを連結
    #       不自然な改行の検出方法が不明
    #data.gsub!(/[^。…―－\-」』)）>＞］\]〉》】〕｝\}0-9０-９]/
  end

  def object_of_ruby?(char)
    char =~ /[一-龠Ａ-Ｚａ-ｚA-Za-z]/
  end

  def bouten(str, ten)
    if str.include?("｜")
      str.sub("｜", "［＃傍点］") + "［＃傍点終わり］"
    else
      str.insert(-(ten.length + 1), "［＃傍点］") + "［＃傍点終わり］"
    end
  end

  #
  # 小説家になろうのルビ対策
  #
  def narou_ruby(data)
    # 《》なルビの対処
    data.tr!("≪≫", "《》")
    data.gsub!(/(.+?)《(.+?)》/) do |match|
      m1, m2 = $1, $2
      case
      when m2 =~ /^・+$/
        # ルビが・だけの場合、傍点と判断
        bouten(m1, m2)
      when m1.include?("｜")
        match
      when object_of_ruby?(m1[-1])
        match
      else
        "#{m1}≪#{m2}≫"
      end
    end
    # （）なルビの対処
    data.gsub!(/(.+?)（([ぁ-んァ-ヴーゞ・Ａ-Ｚａ-ｚA-Za-z]{,10})）/) do |match|
      m1, m2 = $1, $2
      last_char = m1[-1]
      case
      when last_char == "｜"
        # （の直前に｜がある場合ルビ化は抑制される
        "#{m1[0...-1]}（#{m2}）"
      when m2 =~ /^・+$/
        # ルビが・だけの場合、傍点と判断
        bouten(m1, m2)
      when object_of_ruby?(last_char)
        "#{m1}《#{m2}》"
      else
        match
      end
    end
  end

  #
  # 全角版 String#rstrip!
  #
  def zenkaku_rstrip(line)
    line.gsub!(/[　\s]*$/, "")
  end

  #
  # URL っぽい文字列を一旦別のIDに置き換えてあとで復元することで、変換処理の影響を受けさせない
  #
  def replace_url(data)
    @_url_list ||= []
    data.gsub!(URI.regexp) do |match|
      @_url_list << match
      "［＃ＵＲＬ＝#{@_url_list.count - 1}］"
    end
  end

  def rebuild_url(data)
    @_url_list.each_with_index do |url, id|
      data.sub!("［＃ＵＲＬ＝#{num_to_kanji(id.to_s)}］", url)
    end
  end

  #
  # なろうの挿絵タグを挿絵注釈に変換
  # 挿絵画像が存在しなければダウンロードして保存する
  #
  def replace_illust_tag(data)
    @_illust_chuki_list ||= []
    data.gsub!(/^(<i[0-9]+\|[0-9]+>)\n?/m) do
      next "" unless @setting.enable_narou_illust
      chuki = @illustration.get($1)
      if chuki
        @_illust_chuki_list << chuki
        "［＃挿絵＝#{@_illust_chuki_list.count - 1}］\n"
      else
        ""
      end
    end
  end

  def rebuild_illust(data)
    @_illust_chuki_list.each_with_index do |chuki, id|
      data.sub!("［＃挿絵＝#{num_to_kanji(id.to_s)}］", chuki)
    end
  end

  #
  # ［＃改ページ］直後の行を見出しに設定する
  #
  def enchant_midashi(data)
    def midashi(str)
      midashi_title = str.gsub("［＃半字下げ］", "")
      "［＃１字下げ］［＃ここから中見出し］#{midashi_title}［＃ここで中見出し終わり］"
    end

    data.gsub!(/［＃改ページ］\n(.+?)\n/) do |match|
      m1 = $1
      rest = $'
      if $1 =~ /#{AUTHOR_COMMENT_CHUKI[:introduction][:open]}/
        match
      else
        # 見出しの次の行が空行ではない場合空行を追加する
        add_tail = rest =~ /\A$/ ? "" : "\n"
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
  # 小説データ全体に対して施す変換
  #
  def convert_for_all_data(data)
    auto_join_in_brackets(data) if @setting.enable_auto_join_in_brackets
    auto_join_line(data) if @setting.enable_auto_join_line
    erase_comments_block(data)
    replace_illust_tag(data)
    replace_url(data)
    delete_narou_mobile_tag(data)
    convert_rome_numeric(data)
    alphabet_to_zenkaku(data, @setting.enable_alphabet_force_zenkaku)
    num_to_kanji(data)
    exception_reconvert_kanji_to_num(data)
    if @setting.enable_kanji_num_with_units
      convert_kanji_num_with_unit(data, @setting.kanji_num_with_units_lower_digit_zero)
    end
    insert_separate_space(data)
    convert_special_characters(data)
    convert_fraction_and_date(data)
    force_indent_special_character(data)
    replace_dakuten_font(data)
  end

  #
  # 変換処理本体
  #
  # text_type: 渡されるテキストの種類。subtitle, introduction, body, postscript のどれか
  #
  def convert(io, text_type)
    @write_fp = StringIO.new
    case text_type
    when "introduction"
      return @write_fp if @setting.enable_erase_introduction
    when "postscript"
      return @write_fp if @setting.enable_erase_postscript
    end
    data = io.read
    convert_for_all_data(data)
    if text_type == "textfile"
      progressbar = ProgressBar.new(data.count("\n") + 1)
      progressbar.output(0)
    end
    @read_fp = StringIO.new(data)
    initialize_member_values
    @read_fp.each_with_index do |line, i|
      progressbar.output(i) if text_type == "textfile"
      @request_skip_output_line = false
      zenkaku_rstrip(line)
      if !comments_block?(line)
        if @request_insert_blank_next_line
          outputs unless blank_line?(line)
          @request_insert_blank_next_line = false
        end
        process_author_comment(line) if text_type == "textfile"
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
    end
    author_comment_force_close if text_type == "textfile"

    @write_fp.rewind
    data = @write_fp.string
    if text_type == "textfile"
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
    # rebuild_english_sentences で再構築された英文にルビがふられる可能性を考慮して、
    # この位置でルビの処理を行う
    narou_ruby(data) if @setting.enable_narou_ruby
    data.sub!(/\n\z/, "")
    progressbar.clear if text_type == "textfile"
    @write_fp
  end
end
