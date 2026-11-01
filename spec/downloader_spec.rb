# -*- Encoding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../lib/downloader"

describe Downloader do
  describe ".parse_interval_by_domain" do
    it "カンマ区切りのドメイン=秒数を解析する" do
      expect(Downloader.parse_interval_by_domain("ncode.syosetu.com=4.0, novel18.syosetu.com = 3"))
        .to eq({ "ncode.syosetu.com" => 4.0, "novel18.syosetu.com" => 3.0 })
    end

    it "nilや空文字列は空のハッシュになる" do
      expect(Downloader.parse_interval_by_domain(nil)).to eq({})
      expect(Downloader.parse_interval_by_domain("")).to eq({})
    end

    it "不正な書式はArgumentErrorになる" do
      ["ncode.syosetu.com", "ncode.syosetu.com=abc", "=4.0", "ncode.syosetu.com=-1"].each do |value|
        expect { Downloader.parse_interval_by_domain(value) }.to raise_error(ArgumentError)
      end
    end
  end

  describe ".resolve_interval" do
    let(:domain) { "ncode.syosetu.com" }

    it "ドメイン指定があれば最優先される" do
      setting = { "download.interval" => 1.0, "download.interval-by-domain" => "ncode.syosetu.com=4.0" }
      expect(Downloader.resolve_interval(domain, setting)).to eq 4.0
    end

    it "他ドメインの指定は影響せず download.interval が使われる" do
      setting = { "download.interval" => 1.0, "download.interval-by-domain" => "novel18.syosetu.com=4.0" }
      expect(Downloader.resolve_interval(domain, setting)).to eq 1.0
    end

    it "何も設定されていなければデフォルト値になる" do
      expect(Downloader.resolve_interval(domain, {})).to eq Downloader::DEFAULT_INTERVAL_WAIT
    end

    it "設定文字列が壊れていても download.interval にフォールバックする" do
      setting = { "download.interval" => 2.0, "download.interval-by-domain" => "broken" }
      expect(Downloader.resolve_interval(domain, setting)).to eq 2.0
    end

    it "download.interval が負数ならデフォルト値になる" do
      expect(Downloader.resolve_interval(domain, { "download.interval" => -1 })).to eq Downloader::DEFAULT_INTERVAL_WAIT
    end

    it "0 は有効な値として扱われる" do
      expect(Downloader.resolve_interval(domain, { "download.interval" => 0 })).to eq 0
    end
  end

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

    context "1桁のID＋タイトルを渡された場合" do
      it do
        expect(Downloader.create_subdirecotry_name("5 魔王の友を持つ魔王")).to eq "5"
      end

      it do
        expect(Downloader.create_subdirecotry_name("10 ペルソナ4～覚醒のゼロの力～")).to eq "10"
      end
    end

    context "１文字のタイトルが渡された場合" do
      it { expect(Downloader.create_subdirecotry_name("n")).to eq "" }
      it { expect(Downloader.create_subdirecotry_name("1")).to eq "1" }
      it { expect(Downloader.create_subdirecotry_name("a")).to eq "a" }
    end
  end
end

