# -*- Encoding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

module Narou end
require_relative "../lib/web/worker"

describe Narou::Worker do
  before :all do
    @worker = Narou::Worker.instance
  end

  it "instance is a singleton object" do
    expect(@worker).to be Narou::Worker.instance
  end

  context "not running yet" do
    it do
      expect(@worker.running?).to be false
    end
  end

  context "alrady running" do
    before do
      @worker.start
    end

    it do
      expect(@worker.running?).to be true
    end

    context "when pushing blocks" do
      before do
        @result1 = false
        @result2 = false
        block1 = -> { @result1 = true }
        block2 = -> { @result2 = true }
        @worker.push(&block1)
        @worker.push(&block2)
      end

      it do
        Thread.pass   # 確実にWorkerスレッドが実行されるように
        expect(@result1).to be true
        expect(@result2).to be true
      end
    end

    it do
      @worker.stop
      expect(@worker.running?).to be false
    end
  end
end

