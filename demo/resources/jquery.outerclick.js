/* -*- coding: utf-8 -*-
 *
 * jquery.outerclick.js
 * Copyright 2014 whiteleaf. All rights reserved.
 *
 * Usage:
 *   $("#menu").outerClick(function() {
 *     $(this).hide();  // do something
 *   });
 *   $("#menu").outerClickOne(function() {
 *     // once process
 *   });
 *   either
 *   $("#menu").outerClick(function(){}, "one");
 */

(function($) {
  "use strict";
  var outerClick = function(obj, callback, bind_func) {
    var self = this;
    $(document)[bind_func]("click", function(e) {
      var pos = self.getEventPosition(e);
      var element = self.elementFromPoint(pos);
      if (obj !== element) {
        if (!self.searchTargetUpstream(element, obj)) {
          callback.apply(obj);
        }
      }
    });
  };
  $.extend(outerClick.prototype, {
    elementFromPoint : function(pos) {
      var doc = $(document);
      var element = document.elementFromPoint(pos.x - doc.scrollLeft(),
                                              pos.y - doc.scrollTop());
      return element;
    },
    getEventPosition : function(event) {
      return { x: event.pageX, y: event.pageY };
    },
    searchTargetUpstream : function(element, target) {
      var parent = $(element).parent();
      if (parent.length === 0) return null;
      if (parent[0] === target) return parent;
      return this.searchTargetUpstream(parent, target);
    },
  });
  $.fn.outerClick = function(callback, bind_func) {
    if (typeof bind_func === "undefined") bind_func = "on";
    return this.each(function() {
      new outerClick(this, callback, bind_func);
    });
  };
  $.fn.outerClickOne = function(callback) {
    return this.each(function() {
      new outerClick(this, callback, "one");
    });
  }
}(jQuery));

