/* -*- coding: utf-8 -*-
 *
 * jquery.slideNavbar.js
 * Copyright 2014 whiteleaf. All rights reserved.
 *
 * Usage:
 *   var slideNavbar = $(".navbar-collapse").slideNavbar();
 *   slideNavbar.slide();   // slide nav manually
 *   slideNavbar.slide(true);   // no animation
 *
 *   in your css:
 *   @media (max-width:767px) {
 *     .navbar-collapse {
 *       position: absolute;
 *       right: -270px;
 *       width: 270px;
 *     }
 *   }
 *
 * Require:
 *   Bootstrap v3.2.0 or higher
 */

(function($) {
  "use strict";
  // default options
  var options = {
    hiding_class: "slide-hiding-collapse",
    width: 270,
    duration: 250
  };
  var touchable_device = "ontouchstart" in window;
  var toggle_event_name = (touchable_device ? "touchstart" : "click");
  var slideNavbar = {
    initialize: function(i, obj) {
      var collapse = $(obj);
      var self = this;
      this.hiding_class = options.hiding_class;
      this.collapse = collapse;
      collapse.css({
        "max-height": $(window).height() * 0.9,
      });
      $(".navbar-toggle").off("click");
      $(".navbar-toggle").on(toggle_event_name, function(e) {
        e.preventDefault();
        e.stopPropagation();
        self.slide();
      });
      collapse.addClass(self.hiding_class);
      collapse.addClass("in");   // enable visible collpase nav
    },
    slide: function(force_close) {
      var duration_org = options.duration;
      if (this.collapse.hasClass(this.hiding_class) && !force_close) {
        this.slideOpen();
        this.collapse.removeClass(this.hiding_class);
      }
      else {
        this.slideClose();
        this.collapse.addClass(this.hiding_class);
      }
    },
    slideOpen: function() {
      this.collapse.stop().animate({right: "0"}, options.duration);
    },
    slideClose: function() {
      this.collapse.stop().animate({
        right: "-" + options.width + "px"
      }, options.duration);
    },
  };
  var Api = function() {};
  Api.prototype.slide = function(force_close) {
    if ($(".navbar-toggle").is(":visible")) {
      slideNavbar.slide(force_close);
    }
  };
  Api.prototype.close = function() {
    slideNavbar.slide(true);
  };
  $.fn.slideNavbar = function(opts) {
    $.extend(options, opts);
    this.each(function(i, obj) {
      slideNavbar.initialize(i, obj);
    });
    return new Api();
  };
}(jQuery));

