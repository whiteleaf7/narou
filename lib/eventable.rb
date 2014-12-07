# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

module Narou::Eventable
  EVENTS_CONTAINER = {}

  def self.included(base)
    base.extend(ClassMethods)
    EVENTS_CONTAINER[base] = {}
  end

  class NonBlockError < StandardError; end

  module ClassMethods
    def add_event_listener(event_name, &block)
      raise NonBlockError unless block_given?
      stack = EVENTS_CONTAINER[self][event_name] ||= []
      stack.push(block)
    end

    def trigger_event(event_name, *argv)
      stack = EVENTS_CONTAINER[self][event_name]
      return unless stack
      stack.each do |block|
        block.call(*argv)
      end
    end
  end

  def add_event_listener(event_name, once = false, &block)
    raise NonBlockError unless block_given?
    @__events_container ||= {}
    stack = @__events_container[event_name] ||= []
    stack.push([block, once])
  end

  def remove_event_listener(event_name, &block)
    @__events_container ||= {}
    if block_given?
      events = @__events_container[event_name]
      if events
        events.reject! do |values|
          values[0] == block
        end
      end
    else
      @__events_container.delete(event_name)
    end
  end

  def trigger_event(event_name, *argv)
    @__events_container ||= {}
    stack = @__events_container[event_name]
    return unless stack
    stack.reject! do |block, once|
      block.call(*argv)
      once
    end
  end

  alias :on :add_event_listener
  alias :off :remove_event_listener
  alias :trigger :trigger_event

  def one(event_name, &block)
    add_event_listener(event_name, true, &block)
  end
end

