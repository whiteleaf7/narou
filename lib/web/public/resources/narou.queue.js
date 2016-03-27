/* -*- coding: utf-8 -*-
 *
 * Copyright 2013 whiteleaf. All rights reserved.
 */

/*
 * キュー関係のコード
 */
$(document).ready(function() {
  "use strict";

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
    $("#header-navbar").append($plus);
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

