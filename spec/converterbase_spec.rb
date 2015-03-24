# -*- Encoding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../lib/inspector"
require_relative "../lib/novelsetting"
require_relative "../lib/converterbase"

describe ConverterBase do
  before do
    novelsetting = NovelSetting.new("", true)
    inspector = Inspector.new(novelsetting)
    @converter = ConverterBase.new(novelsetting, inspector, nil)
  end

  context "#erase_comments_block" do
    before do
      @converter.instance_variable_set(:@text_type, "textfile")
    end

    context "コメントブロックが存在した場合" do
      before do
        @text = <<-EOS
abcdefg
--------------------------------------------------
hijklmn
--------------------------------------------------
opqrstu
        EOS
      end

      it "削除する" do
        expect(@converter.erase_comments_block(@text)).to eq <<-EOS
abcdefg
opqrstu
        EOS
      end

      context "複数のコメントブロックが存在した場合" do
        it "それぞれのブロックの中だけ削除する" do
          text = @text * 2
          expect(@converter.erase_comments_block(text)).to eq <<-EOS
abcdefg
opqrstu
abcdefg
opqrstu
          EOS
        end
      end

      context "@text_file が \"textfile\" ではなかった場合" do
        it "削除しない" do
          @converter.instance_variable_set(:@text_type, "body")
          expect(@converter.erase_comments_block(@text)).to eq @text
        end
      end
    end

    it "コメントじゃなかった場合は削除しない(-が49文字以下)" do
      text = <<-EOS
abcdefg
-------------------------------------------------
hijklmn
-------------------------------------------------
opqrstu
      EOS
      expect(@converter.erase_comments_block(text)).to eq text
    end
  end

  context "#modify_kana_ni_to_kanji_ni" do
    describe "ニ(カタカナ)の前後１文字がカタカナの場合" do
      it "カタカナのまま" do
        expect(@converter.modify_kana_ni_to_kanji_ni("イチニサン")).to eq "イチニサン"
        expect(@converter.modify_kana_ni_to_kanji_ni("ニーサン")).to eq "ニーサン"
      end
    end

    describe "ニ(カタカナ)の前後１文字がカタカナではなく、さらにその前後がカタカナの場合" do
      it "カタカナのまま" do
        expect(@converter.modify_kana_ni_to_kanji_ni("イチ、ニ、サン")).to eq "イチ、ニ、サン"
        expect(@converter.modify_kana_ni_to_kanji_ni("『ニ、ニンゲンの――』")).to eq "『ニ、ニンゲンの――』"
        expect(@converter.modify_kana_ni_to_kanji_ni("ニ、ニンゲン")).to eq "ニ、ニンゲン"
      end
    end

    describe "ニ(カタカナ)の前後１文字がカタカナではなく、さらにその前後がカタカナではない場合" do
      it "漢字の二に修正する" do
        expect(@converter.modify_kana_ni_to_kanji_ni("価格はニ千万円")).to eq "価格は二千万円"
      end
    end
  end

  context "#insert_word_separator" do
    before do
      @converter.instance_variable_set(:@text_type, "body")
      setting = @converter.instance_variable_get(:@setting)
      setting.enable_insert_word_separator = true
    end

    describe "Kindle以外" do before do
        @converter.instance_variable_set(:@device, Narou.get_device("reader"))
      end

      it "何も弄らない" do
        expect(@converter.insert_separator_for_selection("今日もいい天気ですね")).to eq "今日もいい天気ですね"
      end
    end

    describe "単語単位で区切る" do
      it do
        expect(@converter.insert_word_separator \
               "今日もいい天気ですね").to eq \
               "今日［＃zws］もいい［＃zws］天気［＃zws］ですね［＃zws］"
      end

      it do
        expect(@converter.insert_word_separator \
               "合計１５００円です").to eq \
               "合計［＃zws］１５００［＃zws］円［＃zws］です［＃zws］"
      end

      it do
        expect(@converter.insert_word_separator \
               "［＃二分アキ］「注釈内は区切らない」").to eq \
               "［＃二分アキ］「［＃zws］注釈内［＃zws］は［＃zws］区切［＃zws］らない［＃zws］」"
      end

      it do
        expect(@converter.insert_word_separator \
               "あいう・えお").to eq \
               "あいう［＃zws］・［＃zws］えお［＃zws］"
      end

      it do
        expect(@converter.insert_word_separator \
               "アイウ・エオ").to eq \
               "アイウ・エオ［＃zws］"
      end

      it do
        expect(@converter.insert_word_separator \
               "彼は――そう……言った").to eq \
               "彼［＃zws］は［＃zws］――［＃zws］そう［＃zws］……［＃zws］言［＃zws］った［＃zws］"
      end

      it do
        expect(@converter.insert_word_separator \
               "「あいう」、「えお」").to eq \
               "「［＃zws］あいう［＃zws］」、「［＃zws］えお［＃zws］」"
      end
    end

    describe "文字単位で区切る" do
      it do
        expect(@converter.insert_char_separator \
               "今日もいい天気").to eq \
               "今［＃zws］日［＃zws］も［＃zws］い［＃zws］い［＃zws］天［＃zws］気［＃zws］"
      end
    end
  end
end

