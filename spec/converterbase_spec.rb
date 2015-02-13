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
    @converter.instance_variable_set(:@text_type, "textfile")
  end

  context "#erase_comments_block" do
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
        expect(@converter.modify_kana_ni_to_kanji_ni("イチニサン")). to eq "イチニサン"
        expect(@converter.modify_kana_ni_to_kanji_ni("ニーサン")). to eq "ニーサン"
      end
    end

    describe "ニ(カタカナ)の前後１文字がカタカナではなく、さらにその前後がカタカナの場合" do
      it "カタカナのまま" do
        expect(@converter.modify_kana_ni_to_kanji_ni("イチ、ニ、サン")). to eq "イチ、ニ、サン"
        expect(@converter.modify_kana_ni_to_kanji_ni("『ニ、ニンゲンの――』")). to eq "『ニ、ニンゲンの――』"
        expect(@converter.modify_kana_ni_to_kanji_ni("ニ、ニンゲン")). to eq "ニ、ニンゲン"
      end
    end

    describe "ニ(カタカナ)の前後１文字がカタカナではなく、さらにその前後がカタカナではない場合" do
      it "漢字の二に修正する" do
        expect(@converter.modify_kana_ni_to_kanji_ni("価格はニ千万円")). to eq "価格は二千万円"
      end
    end
  end
end

