# -*- Encoding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "tmpdir"
require_relative "../lib/inventory"
require_relative "../lib/novelsetting"

describe NovelSetting do
  context "setting.ini 書き出し関係" do
    before do
      @tmpdir = Dir.mktmpdir
      @novel_setting = NovelSetting.new(@tmpdir, true)
      @inipath = File.join(@tmpdir, NovelSetting::INI_NAME)
    end

    after do
      FileUtils.remove_entry_secure @tmpdir
    end

    it "読み込んだ設定を setting.ini に書き出せるか" do
      @novel_setting.save_settings
      expect(File.exist?(@inipath)).to be_truthy
    end

    it "オリジナル設定も setting.ini に書きだされるか" do
      @novel_setting["original"] = "hoge"
      @novel_setting.save_settings
      lines = File.read(@inipath).split("\n")
      expect(lines.last).to eq "original = hoge"
    end
  end
end

