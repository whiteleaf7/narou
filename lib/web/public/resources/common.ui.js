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
  notification.on("notification.queue", function(data) {
    $queue.text(data);
  });
  $.get("/api/get_queue_size", function(json) {
    $queue.text(json.size);
  });
});

