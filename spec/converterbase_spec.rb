# -*- Encoding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../lib/converterbase"

describe ConverterBase do
  before do
    @converter = ConverterBase.new(nil, nil, nil)
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
end

