# -*- Encoding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "tmpdir"
require "tempfile"
require_relative "../lib/helper"

describe Helper do
  describe ".string_cast_to_type" do
    context "boolean" do
      it { expect(Helper.string_cast_to_type("true", :boolean)).to eq true }
      it { expect(Helper.string_cast_to_type("TRUE", :boolean)).to eq true }
      it { expect(Helper.string_cast_to_type("false", :boolean)).to eq false }
      it { expect(Helper.string_cast_to_type("FALSE", :boolean)).to eq false }
      it "should be error" do
        expect { Helper.string_cast_to_type("1", :boolean) }.to raise_error
        expect { Helper.string_cast_to_type("abc", :boolean) }.to raise_error
        expect { Helper.string_cast_to_type("TrueClass", :boolean) }.to raise_error
      end
    end

    context "integer" do
      it { expect(Helper.string_cast_to_type("100", :integer)).to eq 100 }
      it { expect(Helper.string_cast_to_type("+100", :integer)).to eq 100 }
      it { expect(Helper.string_cast_to_type("-100", :integer)).to eq -100 }
      it { expect(Helper.string_cast_to_type("+10_00", :integer)).to eq +1000 }
      it "should be error" do
        expect { Helper.string_cast_to_type("10.0", :integer) }.to raise_error
        expect { Helper.string_cast_to_type("abc", :integer) }.to raise_error
      end
    end

    context "float" do
      it { expect(Helper.string_cast_to_type("100", :float)).to eq 100.0 }
      it { expect(Helper.string_cast_to_type("100.1", :float)).to eq 100.1 }
      it { expect(Helper.string_cast_to_type("-100.1", :float)).to eq -100.1 }
      it { expect(Helper.string_cast_to_type("-10.2e3", :float)).to eq -10200.0 }
      it "should be error" do
        expect { Helper.string_cast_to_type("abc", :float) }.to raise_error
      end
    end

    context "directory" do
      it do
        Dir.mktmpdir do |tmpdir|
          expect(Helper.string_cast_to_type(tmpdir, :directory)).to eq File.expand_path(tmpdir)
        end
      end
      it "should be error" do
        expect { Helper.string_cast_to_type("/foobarbazz", :directory) }.to raise_error
      end
    end

    context "file" do
      it do
        Tempfile.open("temp") do |fp|
          fp.puts "test"
          expect(Helper.string_cast_to_type(fp.path, :file)).to eq File.expand_path(fp.path)
        end
      end
      it "should be error" do
        expect { Helper.string_cast_to_type("/foobarbazz.txt", :file) }.to raise_error
      end
    end

    context "string" do
      it { expect(Helper.string_cast_to_type("string", :string)).to eq "string" }
    end
  end

  describe ".date_string_to_time" do
    it do
      expect(Helper.date_string_to_time("2014年03月02日(日) 07:39")).to eq(Time.parse("2014/3/2 07:39"))
    end

    it do
      expect(Helper.date_string_to_time("2012年 11月22日 17時00分")).to eq(Time.parse("2012/11/22 17:00"))
    end
  end
end
