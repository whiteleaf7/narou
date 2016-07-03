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
        # 確実にWorkerスレッドが実行されるように
        Thread.pass
        sleep 0.001
        expect(@result1).to be true
        expect(@result2).to be true
      end
    end

    it "canceling" do
      @worker.stop
      expect(@worker.canceled?).to be_falsey
      _execute = false
      expect(@worker.size).to be 0
      @worker.push(&->{ _execute = true })
      expect(@worker.size).to be 1
      @worker.cancel
      expect(@worker.canceled?).to be_truthy
      @worker.start
      Thread.pass
      sleep 0.001
      expect(@worker.running?).to be_truthy
      expect(@worker.canceled?).to be_falsey
      expect(_execute).to be false
      expect(@worker.size).to be 0
    end

    it "stoping" do
      @worker.stop
      expect(@worker.running?).to be false
    end
  end
end

