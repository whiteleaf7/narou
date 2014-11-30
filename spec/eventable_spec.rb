# -*- Encoding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

module Narou end
require_relative "../lib/eventable"

class Dummy
  include Narou::Eventable
end

describe Narou::Eventable do
  context "when an event exist" do
    before do
      @temp1 = 0
      Dummy.add_event_listener(:regist_new_book) do
        @temp1 = 1
      end
    end

    it "should triggered event" do
      Dummy.trigger_event(:regist_new_book)
      expect(@temp1).to eq 1
    end
  end

  context "when multi events exist" do
    before do
      @temp1 = 0
      Dummy.add_event_listener(:temp_add_event) do
        @temp1 += 1
      end
      Dummy.add_event_listener(:temp_add_event) do
        @temp1 += 1
      end
    end

    it "should be @temp1 eq 2" do
      Dummy.trigger_event(:temp_add_event)
      expect(@temp1).to eq 2
    end
  end

  context "when give arguments" do
    it do
      Dummy.add_event_listener(:give_argument) do |arg|
        expect(arg).to eq 0
      end
      Dummy.trigger_event(:give_arguments, 0)
    end

    it do
      Dummy.add_event_listener(:give_arguments) do |arg1, arg2|
        expect(arg1).to eq 1
        expect(arg2).to eq :two
      end
      Dummy.trigger_event(:give_arguments, 1, :two)
    end
  end

  context "without block" do
    it "should be raise error" do
      expect { Dummy.add_event_listener(:test1) }.to raise_error(Narou::Eventable::NonBlockError)
    end
  end

  context "if do not register events yet" do
    it "do nothing" do
      expect { Dummy.trigger_event(:dont_registered_event) }.not_to raise_error
    end
  end

  context "when call #add_event_listener and .add_event_listener" do
    before do
      @anser = nil
      @dummy = Dummy.new
      @dummy.add_event_listener(:instance_or_class) do
        @anser = :instance
      end
      Dummy.add_event_listener(:instance_or_class) do
        @anser = :class
      end
    end

    it "instance method is called" do
      @dummy.trigger_event(:instance_or_class)
      expect(@anser).to eq :instance
    end

    it "class method is called" do
      Dummy.trigger_event(:instance_or_class)
      expect(@anser).to eq :class
    end
  end
end

