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
    @ini.cast("100").class.should == Fixnum
  end

  it "return 100" do
    @ini.cast("100").should == 100
  end

  it "return 100" do
    @ini.cast("+100").should == 100
  end

  it "return -100" do
    @ini.cast("-100").should == -100
  end

  it "class type should be Float" do
    @ini.cast("10.5").class.should == Float
  end

  it "return 10.5" do
    @ini.cast("10.5").should == 10.5
  end

  it "return +10.5" do
    @ini.cast("+10.5").should == 10.5
  end

  it "return -10.5" do
    @ini.cast("-10.5").should == -10.5
  end

  it "return true" do
    @ini.cast("true").should == true
  end

  it "return false" do
    @ini.cast("false").should == false
  end

  it "return `string'" do
    @ini.cast("string").should == "string"
  end

  it "return `string'" do
    @ini.cast("'string'").should == "string"
  end

  it "return `string'" do
    @ini.cast('"string"').should == "string"
  end

  it "return nil" do
    @ini.cast("nil").should == nil
  end

  it "return nil" do
    @ini.cast("null").should == nil
  end

  it "empty string cast to nil" do
    @ini.cast("null").should == nil
  end
end

describe "test.ini" do
  before do
    @ini_data = Ini.load_file(data_test_ini_path)
  end

  it "は Hash であること" do
    @ini_data.class.should == Hash
  end

  it "はセクションが２つであること" do
    @ini_data.count.should == 2
  end

  it "はglobalセクションが必ずあること" do
    @ini_data.include?("global").should be_true
  end

  it "はsub_sectionがあること" do
    @ini_data.include?("sub_section").should be_true
  end

  it "は global_string が 文字列 という文字であること" do
    @ini_data["global"]["global_string"].should == "文字列"
  end

  it "は true_value が true であること" do
    @ini_data["sub_section"]["true_value"].should == true
  end

  it "は false_value が false であること" do
    @ini_data["sub_section"]["false_value"].should == false
  end

  it "は nil_value_1 が nil であること" do
    @ini_data["sub_section"]["nil_value_1"].should == nil
  end

  it "は nil_value_2 が nil であること" do
    @ini_data["sub_section"]["nil_value_2"].should == nil
  end

  it "は number が 100 であること" do
    @ini_data["sub_section"]["number"].should == 100
  end

  it 'は quote_string が 囲まれた文字列 であること' do
    @ini_data["sub_section"]["quote_string"].should == '囲まれた文字列'
  end
end
