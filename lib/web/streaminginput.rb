# frozen_string_literal: true

#
# Copyright 2013 whiteleaf. All rights reserved.
#

module Narou
  #
  # 入力確認機能を WEB UI 用に差し替える
  #
  module Input
    module_function

    TIMEOUT_FOR_PONG = 2 # モーダルの生存確認を送って返答を待つ時間(s)

    @@modal_id = 0
    @@mutex = Mutex.new

    def create_modal_id
      id = nil
      @@mutex.synchronize do
        id = @@modal_id
        @@modal_id += 1
      end
      id
    end

    #
    # クライアント（ブラウザ）にユーザ入力用のモーダルを表示要求する
    #
    # 返事がなかった場合は nil を返す
    #
    def request_show_modal_for_client(modal_name, send_data)
      pushserver = PushServer.instance
      id = create_modal_id
      que = Queue.new
      ponged = true
      pong_event_id = "pong.modal.#{id}"
      answer_event_id = "answer.modal.#{id}"

      answer_handler = ->(value, _connection) do
        if value.is_a?(Hash)
          que.push(value["result"])
        else
          que.push(nil)
        end
      end
      pong_handler = ->(_value, _connection) do
        ponged = true
      end

      pushserver.on(pong_event_id, &pong_handler)
      pushserver.on(answer_event_id, &answer_handler)

      th = Thread.new do
        while ponged
          ponged = false
          # クライアントにpingを飛ばしてモーダルの生存確認をする
          pushserver.send_all("ping.modal" => { id: id })
          # クライアントからの受信確認を待つ
          sleep TIMEOUT_FOR_PONG
        end
        # 応答なし
        que.push(nil)
      end

      send_data[:id] = id
      pushserver.send_all(modal_name => send_data)

      result = que.pop
      th.kill

      pushserver.off(pong_event_id, &pong_handler)
      pushserver.off(answer_event_id, &answer_handler)
      pushserver.send_all("hide.modal" => { id: id })

      result
    end

    def confirm(message, default = false, _nontty_default = true)
      result = request_show_modal_for_client("modal.confirm", message: message + "?")
      if result.nil?
        default
      else
        result
      end
    end

    def choose(title, message, choices)
      result = request_show_modal_for_client("modal.choose", {
        title: title, message: message,
        choices: choices.dup.tap { |h| h.delete(:default) }
      })
      if choices.include?(result)
        result
      else
        choices[:default] || choices.first[0]
      end
    end
  end
end

