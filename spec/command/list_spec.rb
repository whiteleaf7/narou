# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "time"
require "timecop"
require "commandline"

describe Command::List do
  let(:novels) { Database.instance.get_object.values }
  let(:list) do
    Command::List.new.tap do |this|
      this.instance_variable_set(:@options, options)
    end
  end
  let(:options) { {} }
  let(:max) { novels.size }

  define :be_size_of do |expected|
    match do |actual|
      actual.size == expected
    end
  end

  describe "#output_list" do
    def expect_receive_output_lines_with_be_size_of(size)
      expect(list).to receive(:output_lines).with(be_size_of size)
    end

    it do
      expect_receive_output_lines_with_be_size_of 5
      list.output_list(novels, 5)
    end

    it do
      expect_receive_output_lines_with_be_size_of max
      list.output_list(novels, max)
    end

    it do
      expect_receive_output_lines_with_be_size_of max
      list.output_list(novels, max + 1)
    end

    context "--filter" do
      context "series" do
        let(:options) { { "filters" => %w(series) } }
        it do
          expect_receive_output_lines_with_be_size_of 9
          list.output_list(novels, max)
        end
      end

      context "ss" do
        let(:options) { { "filters" => %w(ss) } }
        it do
          expect_receive_output_lines_with_be_size_of 1
          list.output_list(novels, max)
        end
      end

      context "frozen" do
        let(:options) { { "filters" => %w(frozen) } }
        it do
          expect_receive_output_lines_with_be_size_of 3
          list.output_list(novels, max)
        end
      end

      context "nonfrozen" do
        let(:options) { { "filters" => %w(nonfrozen) } }
        it do
          expect_receive_output_lines_with_be_size_of 7
          list.output_list(novels, max)
        end
      end

      context "series nonfrozen" do
        let(:options) { { "filters" => %w(series nonfrozen) } }
        it do
          expect_receive_output_lines_with_be_size_of 6
          list.output_list(novels, max)
        end
      end
    end
  end
end
