# -*- Encoding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../lib/commandline"
require_relative "../lib/logger"

describe "exit code" do
  before do
    $stdout.silent = true
    $stderr.silent = true
  end

  describe "download command" do
    describe "return mistook count" do
      context "when novel is nothing" do
        it { expect(CommandLine.run!(%w(download foo))).to eq 1 }
        it { expect(CommandLine.run!(%w(download foo bar))).to eq 2 }
        it { expect(CommandLine.run!(%w(download foo bar baz))).to eq 3 }
      end

      context "when novel is alrady existed" do
        before do
          # 事前に最低３つは凍結している小説を用意しておく
          @ids = `narou l -f nonfrozen`.split
        end

        it "got 3" do
          expect(CommandLine.run!(["download"] + @ids[0,3])).to eq 3
        end
      end

      context "when novel is alrady frozen" do
        before do
          # 事前に最低２つは凍結している小説を用意しておく
          @ids = `narou l -f frozen`.split
        end

        it "got 2" do
          expect(CommandLine.run!(["download"] + @ids[0,2])).to eq 2
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
        before do
          @ids = `narou l -f frozen`.split
        end

        it "got 2" do
          expect(CommandLine.run!(["update"] + @ids[0,2])).to eq 2
        end
      end
    end
  end
end

