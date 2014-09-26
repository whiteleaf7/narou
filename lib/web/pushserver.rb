# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "json"
require_relative "web-socket-ruby/lib/web_socket"

class Narou::PushServer
  include Singleton

  HISTORY_SAVED_COUNT = 30   # 保存する履歴の数

  attr_accessor :port
  attr_reader :accepted_domains, :connections

  def accepted_domains=(domains)
    @accepted_domains = domains.kind_of?(Array) ? domains : [domains]
  end

  def initialize
    @accepted_domains = "localhost"
    @port = 31000
    @connections = []
    @history = [nil] * HISTORY_SAVED_COUNT
  end

  def run
    @server = WebSocketServer.new({
      accepted_domains: @accepted_domains,
      port: @port
    })
    Thread.new do
      @server.run do |ws|
        begin
          ws.handshake
          que = Queue.new
          @connections.push(que)

          @history.compact.each do |message|
            ws.send(JSON.generate(echo: message))
          end

          thread = Thread.new do
            while true
              data = que.pop
              ws.send(data)
            end
          end

          while data = ws.receive
            send_all(data)
          end

        ensure
          @connections.delete(que)
          thread.terminate if thread
        end
      end
    end
  end

  #
  # PushServer を停止させる
  #
  def quit
    @server.quit
  end

  #
  # 接続している全てのクライアントに対してメッセージを送信
  #
  def send_all(data)
    json = JSON.generate(data)
    @connections.each do |queue_of_connection|
      queue_of_connection.push(json)
    end
    # echo 以外のイベントは履歴に保存しない
    message = data[:echo]
    if message
      @history.push(message)
      @history.shift
    end
  end
end

