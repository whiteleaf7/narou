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
    $plus.css({
      position: "absolute",
      left: $queue.offset().left + $queue.outerWidth() + 1,
      top: $queue.offset().top - 3,
      color: "#5cb85c",
      "font-weight": "bold",
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
});

