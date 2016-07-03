# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../lib/logger"

describe Narou::Logger do
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

    context "多段 capture" do
      it "quiet 中の出力は外側では取得できない" do
        expect($stdout.capture {
          print "foo"
          expect($stdout.capture { print "bar" }).to eq "bar"
        }).to eq "foo"
      end

      it "quiet: false なら外側でも取得できる" do
        expect($stdout.capture {
          print "foo"
          expect($stdout.capture(quiet: false) { print "bar" }).to eq "bar"
        }).to eq "foobar"
      end
    end

    context "現在の状態を取得" do
      it "キャプチャ中でなければ偽" do
        expect($stdout.capturing).to eq false
      end

      it "キャプチャ中なら真" do
        $stdout.capture { expect($stdout.capturing).to eq true }
      end

      it "多段中でも真" do
        $stdout.capture do
          expect($stdout.capturing).to be_truthy
          $stdout.capture do
            expect($stdout.capturing).to be_truthy
          end
          expect($stdout.capturing).to be_truthy
        end
        expect($stdout.capturing).to be_falsey
      end
    end

    context "キャプチャ中に exit された場合" do
      it "exit 直前までの出力はキャプチャ出来る" do
        dummy = proc do
          print "hello"
          exit 1
        end
        dummy_caller = proc do
          begin
            dummy.call
          rescue SystemExit => e
            e.status
          end
        end
        expect($stdout.capture { dummy_caller.call }).to eq "hello"
      end
    end
  end
end
