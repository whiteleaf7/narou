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
        expect($stdout.capture(false) { puts "\e[31mhello\e[0m" }).to eq "\e[31mhello\e[0m\n"
      end
    end
  end
end
