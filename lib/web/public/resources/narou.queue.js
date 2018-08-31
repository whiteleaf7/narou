/* -*- coding: utf-8 -*-
 *
 * Copyright 2013 whiteleaf. All rights reserved.
 */

/*
 * キュー関係のコード
 */
$(function() {
  "use strict";

  /*
   * キューに積まれた数を表示
   */
  var notification = Narou.Notification.instance();
  var $queue = $(".queue");
  var $queueSizes = $(".queue__sizes");
  var $queueSizeDefault = $(".queue__size--default");
  var $queueSizeConvert = $(".queue__size--convert");

  function highlightQueuBoxIcon(sizes) {
    if (sizes[0] || sizes[1]) {
      $queue.addClass("active");
    }
    else {
      $queue.removeClass("active");
    }
  }

  function setQueueSizesText(sizes) {
    $queueSizeDefault.text(sizes[0]);
    if (Narou.concurrencyIsEnabled()) {
      $queueSizeConvert.text(sizes[1]);
    }
    highlightQueuBoxIcon(sizes);
  }

  notification.on("notification.queue", function(sizes) {
    setQueueSizesText(sizes);
  });

  $.get("/api/get_queue_size", function(sizes) {
    setQueueSizesText(sizes);
  });
});
