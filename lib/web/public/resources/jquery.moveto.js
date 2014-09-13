/* -*- coding: utf-8 -*-
 *
 * jquery.moveto.js
 * Copyright 2014 whiteleaf. All rights reserved.
 *
 * Usage:
 *   $.moveTo({
 *     duration: 500
 *   });
 *
 *   in your html:
 *   <a href="#section2" data-move-to="#section2">Jump</a>
 *   ==/snip/==
 *   <h2 id="section2">Section #2</h2>
 */

(function($) {
  "use strict";
  // default options
  var options = {
    duration: "fast"
  };
  var touchable_device = "ontouchstart" in window;
  var toggle_event_name = (touchable_device ? "touchstart" : "click");
  var moveTo = {
    initialize: function() {
      var self = this;
      return $("[data-move-to]").on(toggle_event_name, function(e) {
        e.preventDefault();
        e.stopPropagation();
        var target = $(this).data("moveTo");
        var target_y = 0;
        if (target !== "top") target_y = $(target).offset().top;
        $("body").animate({ scrollTop: target_y }, options.duration);
      });
    },
  };
  $.moveTo = function(opts) {
    $.extend(options, opts);
    return moveTo.initialize();
  };
}(jQuery));

