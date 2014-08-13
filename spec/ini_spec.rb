# -*- Encoding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../lib/ini"

data_test_ini_path = File.expand_path(File.dirname(__FILE__) + "/data/test.ini")

describe Ini, "#cast" do
  before do
    @ini = Ini.new
  end

  it "class type should be Fixnum" do
    expect(@ini.cast("100").class).to eq Fixnum
  end

  it "return 100" do
    expect(@ini.cast("100")).to eq 100
  end

  it "return 100" do
    expect(@ini.cast("+100")).to eq 100
  end

  it "return -100" do
    expect(@ini.cast("-100")).to eq -100
  end

  it "class type).to be Float" do
    expect(@ini.cast("10.5").class).to eq Float
  end

  it "return 10.5" do
    expect(@ini.cast("10.5")).to eq 10.5
  end

  it "return +10.5" do
    expect(@ini.cast("+10.5")).to eq 10.5
  end

  it "return -10.5" do
    expect(@ini.cast("-10.5")).to eq -10.5
  end

  it "return true" do
    expect(@ini.cast("true")).to eq true
  end

  it "return false" do
    expect(@ini.cast("false")).to eq false
  end

  it "return `string'" do
    expect(@ini.cast("string")).to eq "string"
  end

  it "return `string'" do
    expect(@ini.cast("'string'")).to eq "string"
  end

  it "return `string'" do
    expect(@ini.cast('"string"')).to eq "string"
  end

  it "return nil" do
    expect(@ini.cast("nil")).to eq nil
  end

  it "return nil" do
    expect(@ini.cast("null")).to eq nil
  end

  it "empty string cast to nil" do
    expect(@ini.cast("null")).to eq nil
  end
end

describe Ini, "を初期化した場合：" do
  describe 'new("") した時' do
    before do
      @ini = Ini.new
    end

    it "は global セクションだけがあること" do
      expect(@ini.object.count).to eq 1
      expect(@ini.object.include?("global")).to be_truthy
    end

    it "の global セクションは空のハッシュだけであること" do
      expect(@ini.object["global"].empty?).to be_truthy
    end
  end
end

describe "test.ini" do
  before do
    @ini_data = Ini.load_file(data_test_ini_path)
  end

  it "は Hash であること" do
    expect(@ini_data.class).to eq Hash
  end

  it "はセクションが２つであること" do
    expect(@ini_data.count).to eq 2
  end

  it "はglobalセクションが必ずあること" do
    expect(@ini_data.include?("global")).to be_truthy
  end

  it "はsub_sectionがあること" do
    expect(@ini_data.include?("sub_section")).to be_truthy
  end

  it "は global_string が 文字列 という文字であること" do
    expect(@ini_data["global"]["global_string"]).to eq "文字列"
  end

  it "は true_value が true であること" do
    expect(@ini_data["sub_section"]["true_value"]).to eq true
  end

  it "は false_value が false であること" do
    expect(@ini_data["sub_section"]["false_value"]).to eq false
  end

  it "は nil_value_1 が nil であること" do
    expect(@ini_data["sub_section"]["nil_value_1"]).to eq nil
  end

  it "は nil_value_2 が nil であること" do
    expect(@ini_data["sub_section"]["nil_value_2"]).to eq nil
  end

  it "は number が 100 であること" do
    expect(@ini_data["sub_section"]["number"]).to eq 100
  end

  it 'は quote_string が 囲まれた文字列 であること' do
    expect(@ini_data["sub_section"]["quote_string"]).to eq '囲まれた文字列'
  end
end
