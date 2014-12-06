# -*- Encoding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "stringio"
require_relative "../lib/input"

describe Narou::Input do
  before :all do
    $stdout = StringIO.new
  end

  after :all do
    $stdout = STDOUT
  end

  describe ".confirm" do
    it "y の時 true を返すべき" do
      $stdin = double("$stdin yes", getch: "y", tty?: true)
      expect(Narou::Input.confirm("")).to eq true
    end

    it "Y の時 true を返すべき" do
      $stdin = double("$stdin yes", getch: "Y", tty?: true)
      expect(Narou::Input.confirm("")).to eq true
    end

    it "n の時 false を返すべき" do
      $stdin = double("$stdin no", getch: "n", tty?: true)
      expect(Narou::Input.confirm("")).to eq false
    end

    it "N の時 fale を返すべき" do
      $stdin = double("$stdin no", getch: "N", tty?: true)
      expect(Narou::Input.confirm("")).to eq false
    end

    it "enter をおした時 false を返すべき" do
      $stdin = double("$stdin enter", getch: "\n", tty?: true)
      expect(Narou::Input.confirm("")).to eq false
    end

    it "pipe で接続された時 true を返すべき" do
      $stdin = double("$stdin nontty", tty?: false)
      expect(Narou::Input.confirm("")).to eq true
    end
  end

  describe ".choose" do
    before do
      @choices = { "japanese" => "日本語", "english" => "English", default: "japanese" }
    end

    it "japanese を入力された時 japanese を返すべき" do
      $stdin = double("$stdin japanese", gets: "japanese\n", tty?: true)
      expect(Narou::Input.choose("", @choices)).to eq "japanese"
    end

    it "JAPANESE を入力された時 japanese を返すべき" do
      $stdin = double("$stdin JAPANESE", gets: "JAPANESE\n", tty?: true)
      expect(Narou::Input.choose("", @choices)).to eq "japanese"
    end

    it "English を入力された時 english を返すべき" do
      $stdin = double("$stdin English", gets: "English\n", tty?: true)
      expect(Narou::Input.choose("", @choices)).to eq "english"
    end

    it "pipe で接続された時 japanese を返すべき" do
      $stdin = double("$stdin nontty", tty?: false)
      expect(Narou::Input.choose("", @choices)).to eq "japanese"
    end
  end
end

