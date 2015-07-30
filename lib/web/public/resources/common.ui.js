/* -*- coding: utf-8 -*-
 *
 * Copyright 2013 whiteleaf. All rights reserved.
 */

/*
 * 全ページ共通のUI関係のコード
 */
$(document).ready(function() {
  "use strict";

  /*
   * bootboxjs 初期設定
   */
  bootbox.setDefaults({
    locale: "ja",
    backdrop: "static",
  });

  /*
   * ページ内リンクをスクロールで移動するための初期化
   * (jquery.moveto.js)
   */
  $.moveTo();

  /*
   * 自然に消える alert
   */
  $("#fadeout-alert").delay(2000).animate({ opacity: "hide" }, 1500);

  /*
   * キューに積まれた数を表示
   */
  var notification = Narou.Notification.instance();
  var $queue = $("#queue");
  function highlightQueuBoxIcon(size) {
    if (size > 0) {
      $("#queue-text").addClass("active");
    }
    else {
      $("#queue-text").removeClass("active");
    }
  }
  notification.on("notification.queue", function(data) {
    var before_size = $queue.text();
    $queue.text(data);
    highlightQueuBoxIcon(data);
    // キューのスタック数の横に +1 が浮かび上がって消えるアニメーション
    var diff = data - before_size;
    if (diff <= 0) return;
    var $plus = $("<span>+" + diff + "</span>");
    $plus.addClass("queue-plus").css({
      position: "absolute",
      left: $queue.offset().left + $queue.outerWidth() + 1 - $(document).scrollLeft(),
      top: $queue.offset().top - 3 - $(document).scrollTop(),
    });
    $(".navbar").append($plus);
    $plus.delay(100).animate({
      top: - $plus.outerHeight(),
      opacity: 0,
    }, 3000, function() {
      $(this).remove();
    });
  });
  $.get("/api/get_queue_size", function(json) {
    $queue.text(json.size);
    highlightQueuBoxIcon(json.size);
  });

  /*************************************************************************
   * Webサーバの方から入力を求められた時にモーダルを表示して返事を返す
   *************************************************************************/
  (function() {
    var notification = Narou.Notification.instance();
    var boxes = {};

    // モーダル生存確認への応答
    var pong = function(id) {
      var hash = {};
      hash["pong.modal." + id] = true
      notification.send(hash);
    };

    // ユーザの選択をサーバに通知する
    var answer = function(id, result) {
      var hash = {};
      hash["answer.modal." + id] = { result: result };
      notification.send(hash);
    };

    notification.on("ping.modal", function(json) {
      if (boxes[json.id]) pong(json.id);
    });

    // キャンセル、OK を確認する confirm モーダル表示
    notification.on("modal.confirm", function(json) {
      var id = json.id;
      boxes[id] = bootbox.confirm(json.message.replace(/\n/g, "<br>"), function(result) {
        answer(id, result);
      });
    });

    // 選択肢を表示する choose モーダル表示
    notification.on("modal.choose", function(json) {
      var id = json.id;
      var message = "<div>" + json.message.replace(/\n/g, "<br>") + "</div>";
      $.each(json.choices, function(key, val) {
        var label_id = "choice-" + key;
        message += "<div class=radio><label for='" + label_id + "'>" +
          "<input type=radio name=choices id='" + label_id + "' value='" + key + "'>" + val +
          "</label></div>";
      });
      boxes[id] = bootbox.dialog({
        title: json.title,
        message: message,
        closeButton: false,
        buttons: {
          main: {
            label: "決定",
            className: "btn-primary",
            callback: function() {
              var result = $("input[name='choices']:checked").val();
              answer(id, result);
            }
          }
        }
      });
    });

    notification.on("hide.modal", function(json) {
      var box = boxes[json.id];
      if (box) {
        box.modal("hide");
        delete boxes[json.id];
      }
    });

    return;
  })();
});

