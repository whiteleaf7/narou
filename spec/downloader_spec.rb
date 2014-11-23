# -*- Encoding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../lib/downloader"

describe Downloader do
  describe ".create_subdirecotry_name" do
    context "小説家になろうのタイトルが渡された場合" do
      it do
        expect(Downloader.create_subdirecotry_name("n9669bk 無職転生　- 異世界行ったら本気だす -")).to eq "96"
      end

      it do
        expect(Downloader.create_subdirecotry_name("n8725k ログ・ホライズン")).to eq "87"
      end
    end

    context "なろう以外のタイトルが渡された場合" do
      it do
        expect(Downloader.create_subdirecotry_name("15041 とある能力の代償")).to eq "15"
      end

      it do
        expect(Downloader.create_subdirecotry_name("40151 異界渡りの魔法使い")).to eq "40"
      end
    end

    context "１文字のタイトルが渡された場合" do
      it { expect(Downloader.create_subdirecotry_name("n")).to eq "" }
      it { expect(Downloader.create_subdirecotry_name("1")).to eq "1" }
      it { expect(Downloader.create_subdirecotry_name("a")).to eq "a" }
    end
  end
end

