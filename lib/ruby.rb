# -*- Encoding: UTF-8 -*-
#
# Copyright 2012 whiteleaf. All rights reserved.
#

# ルビふりスクリプト

require_relative "mecab"

=begin
訂正画面イメージ
┌─────────────────────────────────┐
│...シャルティアの｜妾である吸血鬼の花嫁《ヴァンパイア・ブライド》 │
│                 ＾                                               │
│ルビ開始位置の確認 (Yes/Skip/Forward*/Backward*):ffff             │
└─────────────────────────────────┘
↓
┌─────────────────────────────────┐
│...シャルティアの妾である｜吸血鬼の花嫁《ヴァンパイア・ブライド》 │
│                         ＾                                       │
│ルビ開始位置の確認 (Yes/Skip/Forward*/Backward*):y                │
└─────────────────────────────────┘
=end

def make_text(prev_text, name, ruby)
  "#{prev_text}｜#{name}《#{ruby}》"
end

def output_input_message
  print "ルビ開始位置の確認 (Yes/Skip/Forward*/Backward*): "
end

def output_interface(prev_text, name, ruby)
  is_omit = prev_text.length > 7
  omit_text = (is_omit ? "‥‥" : "") + prev_text[(is_omit ? -7 : 0)..-1]
  puts make_text(omit_text, name, ruby)
  puts "　" * omit_text.length + "＾"
  output_input_message
end

def wait_user_input(prev_text, name, ruby)
  output_interface(prev_text, name, ruby)
  while input = STDIN.gets
    case input[0].downcase
    when "y"
      return make_text(prev_text, name, ruby)
    when "s"
      return nil
    when "f"
      count = input.match(/(f+)/i)[1].length
      prev_text += name[0...count]
      _name = name[count..-1]
      name = (_name ? _name : "")
      output_interface(prev_text, name, ruby)
    when "b"
      count = input.match(/(b+)/i)[1].length
      _prev_text = prev_text[-count..-1]
      name = (_prev_text ? _prev_text : prev_text) + name
      prev_text = (_prev_text ? prev_text[0...-count] : "")
      output_interface(prev_text, name, ruby)
    else
      output_input_message
    end
  end
end

#
# ルビっぽい文字列かどうか判定
#
# ひらがな、カタカナ、アルファベット、数字、・ のみで構成された文字列かどうか
# 漢数字が含まれていた場合、全角アラビア数字に直す
#
def is_ruby_strings?(str)
  str =~ /^[ぁ-んァ-ヴーゞ・A-Za-zＡ-Ｚａ-ｚ]+$/
end

Mecab = MecabLib::Mecab.new("")

def extract_ruby(line)
  line.gsub(/(.+?)[<＜〈(（](.+?)[>＞〉)）]/) do
    match_name_message = $1
    match_ruby = $2
    match_all = $&
    next match_all unless is_ruby_strings?(match_ruby)
    node = Mecab.sparse_tonode(match_name_message.force_encoding("Windows-31J").encode("UTF-8"))
    nodes = []
    while node.hasNext
      node = node.next
      break if node.surface == "EOS"
      nodes << {
        surface: node.surface.force_encoding("Windows-31J").encode("UTF-8")),
        pos: node.pos.force_encoding("Windows-31J").encode("UTF-8"),
        root: node.root.force_encoding("Windows-31J").encode("UTF-8"),
        reading: node.reading.force_encoding("Windows-31J").encode("UTF-8"),
        pronunciation: node.pronunciation.force_encoding("Windows-31J").encode("UTF-8")
      }
    end
    name = ""
    prev_text = ""
    is_before_word_alphabet = false
    detected = false
    nodes.reverse.each do |node|
      unless detected
        sujou = node[:pos].split(",")
        if ["接頭詞", "名詞", "助詞", "助動詞", "形容詞"].include?(sujou[0])
          if (sujou[0] == "助詞" && sujou[1] != "連体化") ||
             (sujou[0] == "助動詞" && sujou[5] != "体言接続")
            detected = true
          else
            if node[:surface] =~ /^[a-zA-Z]+$/
              if is_before_word_alphabet
                name = " " + name
              end
              is_before_word_alphabet = true
            else
              is_before_word_alphabet = false
            end
            name = node[:surface] + name
            next
          end
        else
          detected = true
        end
      end
      prev_text = node[:surface] + prev_text
    end
    result = wait_user_input(prev_text, name, match_ruby)
    result ? result : match_all
  end
end

if ARGV.count == 0
  puts "ファイル名を指定して下さい"
  exit
end

ARGV.each do |fname|
  puts "#{fname} の処理を開始します"
  puts "-" * 70
  open(fname) do |read_fp|
    open("[ルビ変換]#{fname}", "w") do |write_fp|
      read_fp.each do |line|
        result = extract_ruby(line)
        write_fp.puts(result)
      end
    end
  end
  puts "-" * 30
  puts "#{fname} の変換が完了しました。"
end

Mecab.destroy
