/* -*- coding: utf-8 -*-
 *
 * Copyright 2013 whiteleaf. All rights reserved.
 */

var Narou = (function() {
  "use strict";

  var Narou = {};
  var storage_cache = null;
  var storage = null;

  /*************************************************************************
   * ローカルストレージ
   *************************************************************************/
  var Storage = Narou.Storage = function() {
    this.initialize();
  };

  $.extend(Storage.prototype, {
    storage_name: "Narou.rb_WEB_UI_saved",
    initialize: function() {
      this.objects = storage_cache ? storage_cache : this.load();
    },

    load: function() {
      var objects = localStorage.getItem(this.storage_name);
      return objects ? JSON.parse(objects) : {};
    },

    save: function() {
      localStorage.setItem(this.storage_name, JSON.stringify(this.objects));
    },

    get: function(key) {
      return this.objects[key];
    },

    set: function(key, value) {
      this.objects[key] = value;
      return this;
    },
  });

  storage = new Storage();

  /*************************************************************************
   * アクション
   *************************************************************************/
  var Action = Narou.Action = function(table) {
    this.table = table;
    this.initialize();
  };

  $.extend(Action.prototype, {
    initialize: function() {
    },

    selectAll: function() {
      this.table.$("tr").addClass("selected");
      this.table.fireChangeSelect();
    },

    selectView: function() {
      $("#novel-list tbody tr").addClass("selected");
      this.table.fireChangeSelect();
    },

    selectClear: function() {
      this.table.$("tr.selected").removeClass("selected");
      this.table.fireChangeSelect();
    },
  });

  /*************************************************************************
   * コントロールパネル
   *************************************************************************/
  var ControlPanel = Narou.ControlPanel = function(table) {
    this.table = table;
    this.initialize();
  };

  $.extend(ControlPanel.prototype, {
    initialize: function() {
      this.init_buttons();
    },

    init_buttons: function() {
    },
  });

  /*************************************************************************
   * Push 通知管理
   *************************************************************************/
  var Notification = Narou.Notification = function() {
    this.initialize();
  };

  $.extend(Notification.prototype, {
    initialize: function() {
      var self = this;
      var connection = this.connection = new WebSocket(this.create_ws_uri());
      this.connected = false;
      this.events = {};

      connection.onopen = function() {
        self.connected = true;
      };

      connection.onerror = function(error) {
        console.log('WebSocket Error ' + error);
      };

      connection.onmessage = function(e) {
        self.onmessage(JSON.parse(e.data));
      };
    },

    create_ws_uri: function() {
      var host = location.hostname,
          port = location.port;
      return "ws://" + host + ":" + (parseInt(port) + 1) + "/";
    },

    onmessage: function(data) {
      var self = this;
      $.each(data, function(event, value) {
        self.trigger(event, value);
      });
    },

    on: function(event, block) {
      if (typeof block !== "function") {
        $.error("need a function");
      }
      var stack = this.events[event] || [];
      stack.push(block);
      this.events[event] = stack;
    },

    trigger: function(event, data) {
      var self = this;
      var stack = this.events[event] || [];
      $.each(stack, function() {
        this.call(self, data);
      });
    },
  });

  /*************************************************************************
   * コンソール
   *************************************************************************/
  var Console = Narou.Console = function(notification) {
    this.initialize(notification);
  };

  $.extend(Console.prototype, {
    animate_duration: 200,

    initialize: function(notification) {
      var self = this;
      this.notification = notification;
      this.last_char_was_return = true;
      this.console = $("#console");
      this.console.perfectScrollbar({
        wheelspeed: 80,
        suppressScrollX: true,
        minScrollbarLength: 20,
      });
      this.original_height = this.console.height();
      this.init_buttons();
      this.init_events();
      this.init_notification();
      this.restore_console_shape();
    },

    init_buttons: function() {
      var self = this;
      this.console.css("min-height", this.original_height);
      $("#console-expand").on("click", function(e) {
        self.expand_console();
      });
      $("#console-refresh").on("click", function(e) {
        self.refresh_console();
      });
    },

    init_events: function() {
      this.manage_resize_event();
      var self = this;
      this.console.on("resize", function() {
        var data = {
          height: self.console.height(),
          expanded: self.console.hasClass("expanded")
        };
        storage.set("console", data);
        storage.save();
      });
    },

    init_notification: function() {
      var self = this;
      this.notification.on("echo", function(message) {
        self.print(message);
      });
    },

    manage_resize_event: function() {
      /*
      var con = this.console;
      con.data('x', con.outerWidth());
      con.data('y', con.outerHeight());
      $(document).on("mouseup", function () {
        if (con.outerWidth() != con.data('x') || con.outerHeight() != con.data('y')) {
          con.trigger("resize");
        }
        con.data('x', con.outerWidth());
        con.data('y', con.outerHeight());
      });
      */
    },

    restore_console_shape: function() {
      var data = storage.get("console");
      if (data) {
        this.console.height(data.height);
        if (data.expanded) this.toggle_expanded();
      }
    },

    scroll_to_bottom: function() {
      var con = this.console;
      con.scrollTop(con[0].scrollHeight - con.height());
    },

    position_is_bottom: function() {
      var con = this.console;
      return (con.scrollTop() === con.prop('scrollHeight') - con.outerHeight());
    },

    print: function(str) {
      var self = this;
      var con = this.console;
      var last_char = str[str.length - 1];
      var lines = str.split("\n");
      var was_bottom = this.position_is_bottom();
      var last_char_is_return = last_char === "\n";
      if (last_char_is_return) {
        lines = lines.slice(0, -1);
      }
      if (!this.last_char_was_return) {
        var last = con.find("div.console-line:last-child");
        var char = lines.pop();
        if (char) last.append(char);
      }
      $.each(lines, function() {
        con.append("<div class=console-line>" + this);
      });
      con.perfectScrollbar("update");
      // 表示する段階で最下部までスクロールしてあった場合はスクロールする
      if (was_bottom) this.scroll_to_bottom();
      this.last_char_was_return = last_char_is_return;
    },

    puts: function(str) {
      if (str[str.length - 1] !== "\n") {
        this.print(str.concat("\n"));
      }
      else {
        this.print(str);
      }
    },

    expand_console: function() {
      var self = this;
      var calced_height;
      if (this.console.hasClass("expanded")) {
        calced_height = this.original_height;
      }
      else {
        var top = this.console.offset().top;
        calced_height = ($(window).height() - top) * 0.8;
      }
      var was_bottom = this.position_is_bottom();
      this.console.stop().animate({ height: calced_height }, this.animate_duration,
          // after do
          function() {
            if (was_bottom) self.scroll_to_bottom();
            self.console.trigger("resize");
          });
      this.toggle_expanded();
    },

    toggle_expanded: function() {
      this.console.toggleClass("expanded");
      $("#console-expand > span").toggleClass("hide");
    },

    refresh_console: function() {
    },
  });

  return Narou;
})();

