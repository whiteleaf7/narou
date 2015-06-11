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
               "［＃二分アキ］「注釈内［＃zws］は［＃zws］区切［＃zws］らない［＃zws］」"
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
               "「あいう［＃zws］」、「えお［＃zws］」"
      end

      it "ルビは除外" do
        expect(@converter.insert_word_separator \
               "これは｜漢字《かんじ》です").to eq \
               "これは［＃zws］｜漢字《かんじ》［＃zws］です［＃zws］"
        expect(@converter.insert_word_separator \
               "俺の妹がこんなに｜可愛い《かわいい》わけがない").to eq \
               "俺［＃zws］の［＃zws］妹［＃zws］がこんなに［＃zws］｜可愛い《かわいい》［＃zws］わけがない［＃zws］"
      end

      it "外字注記は連続させる" do
        expect(@converter.insert_word_separator \
               "失われし楽園※［＃始め二重山括弧］パラダイスロスト※［＃終わり二重山括弧］!!").to eq \
               "失［＃zws］われし［＃zws］楽園［＃zws］※［＃始め二重山括弧］［＃zws］パラダイスロスト［＃zws］※［＃終わり二重山括弧］!!"
      end

      # zws があるせいで禁則処理が正常に働かないための対応
      it "開きカッコの直後にzwsは挿入しない" do
        expect(@converter.insert_word_separator \
               "そっちの『鈴』と一緒に入っていた").to eq \
               "そっちの［＃zws］『鈴［＃zws］』［＃zws］と［＃zws］一緒［＃zws］に［＃zws］入［＃zws］っていた［＃zws］"
      end

      it "開きカッコの直後にzwsは挿入しない" do
        expect(@converter.insert_word_separator \
               "（ほげ）『ふが』").to eq \
               "（ほげ［＃zws］）『ふが［＃zws］』"
      end

      it "開きカッコの直後にzwsは挿入しない" do
        expect(@converter.insert_word_separator \
               "［ほげ］").to eq \
               "［ほげ［＃zws］］"
      end

      it "英語はそのまま" do
        expect(@converter.insert_word_separator \
               "トムは言った。「This is a pen」").to eq \
               "トム［＃zws］は［＃zws］言［＃zws］った［＃zws］。「This is a pen［＃zws］」"
      end

      it "タグの中ではzwsは挿入しない" do
        expect(@converter.insert_word_separator \
               "click <a href=\"http://google.com\">link</a>").to eq \
               "click ［＃zws］<a href=\"http://google.com\">link［＃zws］</a>"
      end
    end

    describe "文字単位で区切る" do
      it do
        expect(@converter.insert_char_separator \
               "今日もいい天気").to eq \
               "今［＃zws］日［＃zws］も［＃zws］い［＃zws］い［＃zws］天［＃zws］気［＃zws］"
      end

      it "連続させないとまずいものは連続させる" do
        expect(@converter.insert_char_separator \
               "――何ということでしょう……。").to eq \
               "――［＃zws］何［＃zws］と［＃zws］い［＃zws］う［＃zws］こ［＃zws］と［＃zws］で［＃zws］し［＃zws］ょ［＃zws］う［＃zws］……［＃zws］。［＃zws］"
      end

      it "外字注記は連続させる" do
        expect(@converter.insert_char_separator \
               "失われし楽園※［＃始め二重山括弧］パラダイスロスト※［＃終わり二重山括弧］!!").to eq \
               "失［＃zws］わ［＃zws］れ［＃zws］し［＃zws］楽［＃zws］園［＃zws］※［＃始め二重山括弧］［＃zws］パ［＃zws］ラ［＃zws］ダ［＃zws］イ［＃zws］ス［＃zws］ロ［＃zws］ス［＃zws］ト［＃zws］※［＃終わり二重山括弧］!!"
      end
    end
  end

  describe "#to_ruby" do
    def to_ruby(match, m1, m2, open_close)
      @converter.to_ruby(match, m1, m2, open_close).gsub("［＃ルビ用縦線］", "｜")
    end

    describe "拗音の巨大化チェック" do
      before do
        @converter.instance_variable_get(:@setting).enable_ruby_youon_to_big = true
      end

      it "大きくなるべき" do
        expect(to_ruby( \
               "ここは東京", "ここは東京", "とうきょう", ["（", "）"])).to eq \
               "ここは｜東京《とうきよう》"
      end

      it "大きくなるべき" do
        expect(to_ruby( \
               "ここは｜東京", "ここは｜東京", "とうきょう", ["（", "）"])).to eq \
               "ここは｜東京《とうきよう》"
      end

      it "大きくなるべき" do
        expect(to_ruby( \
               "ここは東京", "ここは東京", "トウキョウ", ["（", "）"])).to eq \
               "ここは｜東京《トウキヨウ》"
      end

      it "大きくなるべき" do
        expect(to_ruby( \
               "ここは｜東京", "ここは｜東京", "トウキョウ", ["（", "）"])).to eq \
               "ここは｜東京《トウキヨウ》"
      end
    end

    describe "半角スペースがある場合の挙動" do
      it "ルビにはならない(先頭スペース1個＋末尾スペース1個)" do
        expect(to_ruby( \
               "追撃をしない俺に振り返り、再度《 パワースラッシュ 》",
               "追撃をしない俺に振り返り、再度", " パワースラッシュ ", ["《", "》"])).to eq \
               "追撃をしない俺に振り返り、再度《 パワースラッシュ 》"
      end
      it "ルビにはならない(先頭スペース1個)" do
        expect(to_ruby( \
               "追撃をしない俺に振り返り、再度《 パワースラッシュ》",
               "追撃をしない俺に振り返り、再度", " パワースラッシュ", ["《", "》"])).to eq \
               "追撃をしない俺に振り返り、再度《 パワースラッシュ》"
      end
      it "ルビにはならない(末尾スペース2個以上)" do
        expect(to_ruby( \
               "追撃をしない俺に振り返り、再度《パワースラッシュ  》",
               "追撃をしない俺に振り返り、再度", "パワースラッシュ  ", ["《", "》"])).to eq \
               "追撃をしない俺に振り返り、再度《パワースラッシュ  》"
      end
      it "ルビにはならない(末尾スペース2個以上)" do
        expect(to_ruby( \
               "追撃をしない俺に振り返り、再度《パワースラッシュ   》",
               "追撃をしない俺に振り返り、再度", "パワースラッシュ   ", ["《", "》"])).to eq \
               "追撃をしない俺に振り返り、再度《パワースラッシュ   》"
      end

      it "ルビになるべき" do
        expect(to_ruby( \
               "追撃をしない俺に振り返り、再度《パワースラッシュ》",
               "追撃をしない俺に振り返り、再度", "パワースラッシュ", ["《", "》"])).to eq \
               "追撃をしない俺に振り返り、｜再度《パワースラッシュ》"
      end
      it "ルビになるべき(末尾スペース1個)" do
        expect(to_ruby( \
               "追撃をしない俺に振り返り、再度《パワースラッシュ 》",
               "追撃をしない俺に振り返り、再度", "パワースラッシュ ", ["《", "》"])).to eq \
               "追撃をしない俺に振り返り、｜再度《パワースラッシュ 》"
      end
    end
  end
end

