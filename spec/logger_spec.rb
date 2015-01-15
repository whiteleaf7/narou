# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../lib/logger"

describe Narou::Logger do
  after :all do
    $stdout = STDOUT
    $stderr = STDERR
  end

  describe "#capture" do
    context "when non block" do
      it "raise error" do
        expect {
          $stdout.capture
        }.to raise_error(StandardError, "#capture block given")
      end
    end

    context "when empty" do
      it do
        expect($stdout.capture {}).to eq ""
      end
    end

    context "when puts one line" do
      it do
        expect($stdout.capture { puts "hello" }).to eq "hello\n"
      end
    end

    context "when puts multi line" do
      it do
        expect($stdout.capture { puts "hello"; puts "world" }).to eq "hello\nworld\n"
      end
    end

    context "when puts binary strings" do
      it do
        expect($stdout.capture { puts "\e[31mhello\e[0m" }).to eq "hello\n"
      end
    end

    context "with ansicolor NON strip option" do
      it do
        expect($stdout.capture(ansicolor_strip: false) { puts "\e[31mhello\e[0m" }).to eq "\e[31mhello\e[0m\n"
      end
    end

    context "インスタンスを作成してキャプチャ" do
      it do
        logger = Narou::Logger.new
        expect(logger.capture { print "world" }).to eq "world"
      end
    end

    context "quiet=falseでもsilenceで囲めば出力されないか" do
      it do
        $stdout.silence do
          expect($stdout.capture(quiet: false) { print "hello world" }).to eq "hello world"
        end
      end
    end
  end
end
