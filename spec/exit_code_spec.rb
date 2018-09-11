# -*- Encoding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "commandline"
require "narou_logger"
require "database"
require "downloader"

describe "exit code" do
  before do
    $stdout.silent = true
  end

  after do
    $stdout.silent = false
  end

  let(:frozen_ids) do
    Database.instance.get_object.keys.select { |id| Narou.novel_frozen?(id) }
  end

  let(:nonfrozen_ids) do
    Database.instance.get_object.keys.reject { |id| Narou.novel_frozen?(id) }
  end

  describe "download command" do
    describe "return mistook count" do
      context "when novel is nothing" do
        it { expect(CommandLine.run!(%w(download foo))).to eq 1 }
        it { expect(CommandLine.run!(%w(download foo bar))).to eq 2 }
        it { expect(CommandLine.run!(%w(download foo bar baz))).to eq 3 }
      end

      context "when novel is alrady existed" do
        # 事前に凍結されていない小説を３つ用意しておく
        it "got 3" do
          expect(CommandLine.run!(["download"] + nonfrozen_ids[0, 3])).to eq 3
        end
      end

      context "when novel is alrady frozen" do
        # 事前に凍結済み小説を２つ用意しておく
        it "got 2" do
          expect(CommandLine.run!(["download"] + frozen_ids[0, 2])).to eq 2
        end
      end
    end
  end

  describe "update command" do
    describe "return mistook count" do
      context "when novel is nothing" do
        it { expect(CommandLine.run!(%w(update foo))).to eq 1 }
        it { expect(CommandLine.run!(%w(update foo bar))).to eq 2 }
        it { expect(CommandLine.run!(%w(update foo bar baz))).to eq 3 }
      end

      context "when novel is alrady frozen" do
        it "got 2" do
          expect(CommandLine.run!(["update"] + frozen_ids[0, 2])).to eq 2
        end
      end
    end
  end
end

