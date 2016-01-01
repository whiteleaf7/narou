# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "json"
require "singleton"
require_relative "web-socket-ruby/lib/web_socket"
require_relative "../eventable"

module Narou
  class PushServer
    include Singleton
    include Eventable

    HISTORY_SAVED_COUNT = 30   # 保存する履歴の数

    attr_accessor :port, :host
    attr_reader :accepted_domains, :connections

    def accepted_domains=(domains)
      @accepted_domains = Array(domains)
    end

    def initialize
      @accepted_domains = ["*"]
      @port = 31000
      @connections = []
      clear_history
    end

    def run
      @server = WebSocketServer.new({
        accepted_domains: @accepted_domains,
        port: @port,
        host: @host
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
              begin
                JSON.parse(data).each do |name, value|
                  trigger(name, value, ws)
                end
              rescue JSON::ParserError => e
                ws.send(JSON.generate(echo: e.message))
              end
            end
          rescue Errno::ECONNRESET => e
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

    def clear_history
      @history = [nil] * HISTORY_SAVED_COUNT
      # Sinatra で get "/" { clear_history } とかやった場合に [nil,nil...] な配列データが
      # 渡されないようにするため（配列は Sinatra にとって特別なデータ）
      true
    end

    #
    # 接続している全てのクライアントに対してメッセージを送信
    #
    def send_all(data)
      if data.kind_of?(Symbol)
        # send_all(:"events.name") としてイベント名だけで送りたい場合の対応
        data = { data => true }
      end
      json = JSON.generate(data)
      @connections.each do |queue_of_connection|
        queue_of_connection.push(json)
      end
      # echo 以外のイベントは履歴に保存しない
      message = data[:echo]
      if message
        stack_to_history(message)
      end
    rescue JSON::GeneratorError => e
      STDERR.puts $@.shift + ": #{e.message} (#{e.class})"
    end

    def stack_to_history(message)
      if message == "." && @history[-1] =~ /\A\.+\z/
        # 進行中を表す .... の出力でヒストリーが消費されるのを防ぐため、
        # 連続した . は一つにまとめる
        @history[-1] << "."
      else
        @history.push(message)
        @history.shift
      end
    end

  end
end

