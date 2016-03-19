/* -*- coding: utf-8 -*-
 *
 * Copyright 2013 whiteleaf. All rights reserved.
 */

var Narou = (function() {
  "use strict";

  var Narou = {};
  var storage_cache = null;
  var storage = null;

  $.ajaxSetup({
    cache: false   // IE でキャッシュさせないため
  });

  // jQuery はデフォルトだと dataTransfer オブジェクトをコピーしないので
  $.event.props.push("dataTransfer");

  /*************************************************************************
   * ローカルストレージ
   *************************************************************************/
  var Storage = Narou.Storage = function() {
    this.initialize();
  };

  $.extend(Storage.prototype, {
    storage_name: "Narou.rb_WEB_UI_saved",
    initialize: function() {
      if (!storage_cache) {
        storage_cache = this.load();
      }
      this.objects = storage_cache;
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
   * ユーティリティ
   *************************************************************************/
  $.extend(Narou, {
    registerCloseHandler: function(callback) {
      // Chrome, IEですぐにclickイベントをバインドすると、メニュー表示時の
      // クリックに反応してしまう（表示上のズレによって、クリック時のマウス
      // 座標上に対象オブジェクトが存在しないため）ので、イベント作成をほんの
      // 少し遅らせる
      setTimeout(function() {
        // 関係ないところをクリックした時に閉じる
        $(document).one("click", callback);
      }, 100);
    },

    popupMenu: function(menu_id, pos, close_menu_handler) {
      var $menu = $(menu_id);
      var left = $(window).width() < pos.x - $(document).scrollLeft() + $menu.outerWidth() ?
                                     pos.x - $menu.outerWidth() : pos.x;
      var top = $(window).height() < pos.y - $(document).scrollTop() + $menu.outerHeight() ?
                                     pos.y - $menu.outerHeight() : pos.y;
      $menu.show().offset({
        left: left, top: top
      });
      Narou.registerCloseHandler(close_menu_handler);
    },

    // http://qiita.com/osakanafish/items/c64fe8a34e7221e811d0
    formatDate: function(date, format) {
      if (!format) format = 'YYYY-MM-DD hh:mm:ss.SSS';
      format = format.replace(/YYYY/g, date.getFullYear());
      format = format.replace(/MM/g, ('0' + (date.getMonth() + 1)).slice(-2));
      format = format.replace(/DD/g, ('0' + date.getDate()).slice(-2));
      format = format.replace(/hh/g, ('0' + date.getHours()).slice(-2));
      format = format.replace(/mm/g, ('0' + date.getMinutes()).slice(-2));
      format = format.replace(/ss/g, ('0' + date.getSeconds()).slice(-2));
      if (format.match(/S/g)) {
        var milliSeconds = ('00' + date.getMilliseconds()).slice(-3);
        var length = format.match(/S/g).length;
        for (var i = 0; i < length; i++) format = format.replace(/S/, milliSeconds.substring(i, i + 1));
      }
      return format;
    },

    get_event_position: function(e) {
      if (e.type !== "touchstart") {
        return { x: e.pageX, y: e.pageY };
      }
      else {
        return { x: e.originalEvent.touches[0].pageX,
          y: e.originalEvent.touches[0].pageY };
      }
    },

    noScroll: function() {
      $("html, body").css("overflow", "hidden");
    },

    allowScroll: function() {
      $("html, body").css("overflow", "");
    },
  });

  /*************************************************************************
   * Push 通知管理
   *************************************************************************/
  var Notification = Narou.Notification = function() {
    this.initialize();
  };

  Notification.instance = function() {
    if (!this.__instance) {
      this.__instance = new this;
    }
    return this.__instance;
  };

  $.extend(Notification.prototype, {
    RETRY_LIMIT: 5,
    RETRY_WAIT: 2000,

    initialize: function() {
      this.events = {};
      this.retry_count = this.RETRY_LIMIT;
      this.connect();
    },

    connect: function() {
      if (this.connection) return;
      var self = this;
      this.connected = false;
      var connection = window.c = this.connection = new WebSocket(this.create_ws_uri());

      connection.onopen = function() {
        self.connected = true;
        self.trigger("console.clear");
        self.retry_count = self.RETRY_LIMIT;   // 接続出来たらリトライカウント回復
      };

      connection.onclose = function() {
        self.connection = null;
        // PCのスリープ等でコネクションが切れた場合に再接続する
        if (self.retry_count-- > 0) {
          setTimeout(function() {
            self.connected = false;
            self.connect();
          }, self.RETRY_WAIT);
        }
      };

      connection.onmessage = function(e) {
        if (e && e.data) {
          self.onmessage(JSON.parse(e.data));
        }
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

    on: function(event, block, once) {
      if (typeof block !== "function") {
        $.error("need a function");
      }
      var stack = this.events[event] || [];
      stack.push([block, once]);
      this.events[event] = stack;
    },

    one: function(event, block) {
      this.on(event, block, true);
    },

    trigger: function(event, data) {
      var self = this;
      var stack = this.events[event] || [];
      this.events[event] =
        _.reject(stack, function(pair) {
          var block = pair[0], once = pair[1];
          block.call(self, data);
          return once;
        });
    },

    send: function(json) {
      this.connection.send(JSON.stringify(json));
    },
  });

  /*************************************************************************
   * 個別メニュー
   *************************************************************************/
  var ContextMenu = Narou.ContextMenu = function(action, tag) {
    this.action = action;
    this.notification = Notification.instance();
    this.tag = tag;
    this.closed = true;
    this.initializeConsoleDialog();
    this.initializeDiffListEvent();
    this.initializeMenu();
  };

  $.extend(ContextMenu.prototype, {
    open: function(target_id, pos, callback) {
      var self = this;
      this.target_id = target_id;
      if (!this.closed) {
        // メニューを開いた状態で直接ボタンを押した場合に一旦閉じるイベントを起こさせる
        this.close();
      }
      this.closed = false;
      var caller = function() {
        if (typeof callback === "function")
          callback();
      };
      $(document).one("show.bs.dropdown", function() {
        self.object.hide();
        self.closed = true;
        caller();
      });
      Narou.popupMenu(this.object, pos, function() {
        self.object.hide();
        self.closed = true;
        caller();
      });
    },

    close: function() {
      $(document).trigger("click");
      this.closed = true;
    },

    save: function(text) {
      this.text = text;
      storage.set("context_menu_text", text);
      storage.save();
      this.object.remove();
      this.initializeMenuObject(text);
    },

    openConsoleDialog: function(callback) {
      if (typeof callback !== "function") return;
      var $console_dialog = $("#console-dialog");
      $console_dialog.one("shown.bs.modal", callback);
      $(document).one("cancel.narou.remove", function() {
        $console_dialog.modal("hide");
      });
      this.console.clear();
      $console_dialog.modal();
    },

    initializeConsoleDialog: function() {
      this.console = new Narou.Console(this.notification, {
        restore: false, buttons: false,
        id: "#each-console"
      });
    },

    openSelectDiffListDialog: function(target_id) {
      $.get("/api/diff_list", { target: target_id }, function(html) {
        var diff_modal = bootbox.dialog({
          title: "表示したい差分を選択して下さい",
          message: html,
          backdrop: true,
          className: "diff-list-modal",
          buttons: {
            clear: {
              label: "差分を消去",
              className: "btn-danger",
              callback: function() {
                bootbox.confirm("本当に消去してよろしいですか？", function(result) {
                  if (result) {
                    $.post("/api/diff_clean", { target: target_id });
                  }する
                  diff_modal.modal("hide");
                });
                return false;   // 親モーダルはこの時点では閉じさせない
              }
            },
            main: {
              label: "閉じる",
              className: "btn-default"
            },
          }
        });
      });
    },

    initializeDiffListEvent: function() {
      $(document).on("click", ".diff-list-container .list .item", function() {
        var target = $(this).parent().data("diffTarget");
        var number = $(this).data("diffItemNumber");
        $.post("/api/diff", { ids: [ target ], number: number });
        bootbox.hideAll();
      });
    },

    initializeMenu: function() {
      this.initializeMenuObject();
      this.initializeMenuEvent();
    },

    initializeMenuObject: function(text) {
      this.text = text || storage.get("context_menu_text") || this.createDefaultMenuText();
      this.object = this.createMenuObject(this.text);
      $("body").append(this.object);
    },

    createMenuObject: function(text) {
      var object = $('<ul class="context-menu dropdown-menu" role="menu">');
      _.each(text.split("\n"), function(line) {
        var splited = line.split("<>");
        var label = splited[0], command = splited[1];
        var child;
        if (!command) return;
        if (command === "divider")
          child = $('<li class="divider">');
        else
          child = $(sprintf('<li class="context-menu-%s"><a href="#">%s</a>', command, label));
        object.append(child);
      });
      return object;
    },

    _default_commands: [
      "setting", "diff", "edit_tag", "freeze_toggle", "update",
      "send", "remove", "convert", "inspect", "folder", "backup"
    ],

    items: [
      { label: "――――――――(区切り)", command: "divider" },
      { label: "小説の変換設定", command: "setting" },
      { label: "差分を表示", command: "diff" },
      { label: "タグを編集", command: "edit_tag" },
      { label: "凍結 or 解凍", command: "freeze_toggle" },
      { label: "更新", command: "update" },
      { label: "送信", command: "send" },
      { label: "削除", command: "remove" },
      { label: "変換", command: "convert" },
      { label: "調査状況ログを表示", command: "inspect" },
      { label: "保存フォルダを開く", command: "folder" },
      { label: "バックアップを作成", command: "backup" },
      { label: "再ダウンロード", command: "download_force" },
      { label: "凍結済みでも更新", command: "update_force" },
    ],

    events: {
      setting: function() {
        var setting_page_path = "/novels/" + this.target_id + "/setting";
        if (storage.get("open_new_tab_setting_pages")) {
          window.open(setting_page_path);
        }
        else {
          location.href = setting_page_path;
        }
      },

      update: function() {
        this.openConsoleDialog(function() {
          this.action.update(this.target_id);
        }.bind(this));
      },

      update_force: function() {
        this.openConsoleDialog(function() {
          this.action.updateForce(this.target_id);
        }.bind(this));
      },

      send: function() {
        this.openConsoleDialog(function() {
          this.action.send(this.target_id);
        }.bind(this));
      },

      freeze_toggle: function() {
        e.preventDefault();
        this.action.freeze(this.target_id);
      },

      remove: function() {
        this.openConsoleDialog(function() {
          this.action.remove(this.target_id);
        }.bind(this));
      },

      edit_tag: function() {
        this.tag.openEditor(this.target_id);
      },

      convert: function() {
        this.openConsoleDialog(function() {
          this.action.convert(this.target_id);
        }.bind(this));
      },

      diff: function() {
        this.openSelectDiffListDialog(this.target_id);
      },

      inspect: function() {
        this.openConsoleDialog(function() {
          this.action.inspect(this.target_id);
        }.bind(this));
      },

      folder: function() {
        this.action.folder(this.target_id);
      },

      backup: function() {
        this.openConsoleDialog(function() {
          this.action.backup(this.target_id);
        }.bind(this));
      },

      download_force: function() {
        this.openConsoleDialog(function() {
          this.action.downloadForce(this.target_id);
        }.bind(this));
      },
    },

    initializeMenuEvent: function() {
      var object = this.object;
      var self = this;
      _.each(this.events, function(fn, command) {
        object.find(".context-menu-" + command).on("click", function(e) {
          e.preventDefault();
          fn.call(self);
        });
      });
    },

    findItem: function(command) {
      return this.items.find(function(item) {
        return item.command === command;
      });
    },

    createDefaultMenuText: function() {
      var self = this;
      var menu_text_lines = [];
      _.each(this._default_commands, function(command) {
        var item = self.findItem(command);
        if (!item)
          $.error("invalid command(" + command + ")");
        menu_text_lines.push(item.label + "<>" + command);
      });
      return menu_text_lines.join("\n");
    },
  });

  /*************************************************************************
   * アクション
   *************************************************************************/
  var Action = Narou.Action = function(table) {
    this.table = table;
  };

  $.extend(Action.prototype, {
    _getSelectedIds: function(args) {
      if (typeof args !== "undefined" && args.length > 0) {
        return Array.prototype.slice.call(args);
      }
      var ids = [];
      $.each(this.table.rows(".selected").data(), function(i, val) {
        ids.push(val.id);
      });
      return ids;
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

    download: function() {
      var urls = [];
      if (typeof arguments !== "undefined" && arguments.length > 0) {
        urls = Array.prototype.slice.call(arguments);
      }
      if (urls.length == 0) {
        $.get("/partial/download_form")
          .done(function(html) {
            var download_modal = bootbox.dialog({
              title: "ダウンロードする小説のURL、もしくはNコードを入力(複数可)",
              message: html,
              backdrop: true,
              buttons: {
                cancel: {
                  label: "キャンセル",
                  className: "btn-default"
                },
                main: {
                  label: "ダウンロード",
                  className: "btn-primary",
                  callback: function() {
                    $("#download-link-submit").click();
                  }
                }
              }
            });
            download_modal.one("shown.bs.modal", function () {
              $("#download-input").focus();
            });
          });
      }
      else {
        $.post("/api/download", { targets: urls });
      }
    },

    downloadForce: function() {
      var ids = this._getSelectedIds(arguments);
      if (ids.length === 0) return;
      $.post("/api/download_force", { "ids": ids });
    },

    update: function() {
      var ids = this._getSelectedIds(arguments);
      $.post("/api/update", { "ids": ids });
    },

    updateView: function() {
      var self = this;
      var ids = [];
      $("#novel-list tbody tr").each(function(i, tr) {
        var data = self.table.row(tr).data();
        if (data) {
          ids.push(data.id);
        }
      });
      if (ids.length > 0) {
        $.post("/api/update", { "ids": ids });
      }
    },

    updateGeneralLastup: function() {
      bootbox.dialog({
        title: "最新話掲載日の更新",
        message: "凍結済みを除く各小説の最新話掲載日のみを更新して反映させます。<br>" +
                 "最新話掲載日は通常時のUpdateでも更新されるので、手動で更新する必要は基本的にはありません。<br>" +
                 "掲載日だけを調べて、選択的にUpdateをかけるなど、用途を理解した上で小説サイトのサーバーに負荷をかけない範囲でご利用下さい。",
        backdrop: true,
        buttons: {
          cancel: {
            label: "キャンセル",
            className: "btn-default",
          },
          main: {
            label: "更新する",
            className: "btn-primary",
            callback: function() {
              $.post("/api/update_general_lastup");
            }
          },
        }
      });
    },

    updateForce: function() {
      var ids = this._getSelectedIds(arguments);
      $.post("/api/update", { ids: ids, force: true });
    },

    send: function() {
      var ids = this._getSelectedIds(arguments);
      $.post("/api/send", { "ids": ids });
    },

    freeze: function() {
      var ids = this._getSelectedIds(arguments);
      if (ids.length === 0) return;
      $.post("/api/freeze", { "ids": ids });
    },

    freezeOn: function() {
      var ids = this._getSelectedIds(arguments);
      if (ids.length === 0) return;
      $.post("/api/freeze_on", { "ids": ids });
    },

    freezeOff: function() {
      var ids = this._getSelectedIds(arguments);
      if (ids.length === 0) return;
      $.post("/api/freeze_off", { "ids": ids });
    },

    _removeConfirmDialog: function(title, ids, callback) {
      var message = "";
      this.table.rows().data().each(function(data, idx) {
        if (ids.indexOf(data.id + "") !== -1) {
          message += "<li>" + data.title + "</li>";
        }
      });
      message = '<div style="max-height:300px;overflow:auto"><ul>' + message + '</ul></div>' +
                '<div class="checkbox pull-right"><label><input type="checkbox" id="check-remove-with-file">' +
                '保存フォルダ・ファイルも一緒に削除する</label></div><div class="clearfix"></div>';
      bootbox.dialog({
        title: title,
        message: message,
        buttons: {
          danger: {
            label: "削除する",
            className: "btn-danger",
            callback: function() {
              callback(true, $("#check-remove-with-file").prop("checked"));
              $(document).trigger("ok.narou.remove");
            }
          },
          main: {
            label: "キャンセル",
            className: "btn-default",
            callback: function() {
              callback(false, false);
              $(document).trigger("cancel.narou.remove");
            }
          }
        }
      });
    },

    remove: function() {
      var ids = this._getSelectedIds(arguments);
      if (ids.length === 0) return;
      this._removeConfirmDialog("選択した小説を削除しますか？", ids, function(result, with_file) {
        if (!result) return;
        $.post("/api/remove", { ids: ids, with_file: with_file });
      });
    },

    convert: function() {
      var ids = this._getSelectedIds(arguments);
      if (ids.length === 0) return;
      $.post("/api/convert", { "ids": ids });
    },

    diff: function() {
      var ids = this._getSelectedIds(arguments);
      if (ids.length === 0) return;
      $.post("/api/diff", { "ids": ids });
    },

    inspect: function() {
      var ids = this._getSelectedIds(arguments);
      if (ids.length === 0) return;
      $.post("/api/inspect", { "ids": ids });
    },

    folder: function() {
      var ids = this._getSelectedIds(arguments);
      if (ids.length === 0) return;
      $.post("/api/folder", { "ids": ids });
    },

    backup: function() {
      var ids = this._getSelectedIds(arguments);
      if (ids.length === 0) return;
      $.post("/api/backup", { "ids": ids });
    },

    settingBurn: function() {
      var ids = this._getSelectedIds(arguments);
      if (ids.length === 0) return;
      $.post("/api/setting_burn", { "ids": ids });
    },

    csvImport: function() {
      $.get("/partial/csv_import", function(html) {
        var box = bootbox.dialog({
          title: "CSVファイルからのインポート",
          message: html,
          buttons: {
            cancel: {
              label: "キャンセル",
              className: "btn-default",
            },
            main: {
              label: "インポート",
              className: "btn-primary",
              callback: function() {
                $("#csv-import-files").click();
              }
            }
          }
        });
      });
    },

    rebootDialog: function() {
      var self = this;
      bootbox.dialog({
        title: '<span class="glyphicon glyphicon-refresh"></span> 再起動',
        message: "<p>Narou.rb WEB UI サーバを再起動します。<br>" +
                 "バージョンを更新してある場合は最新バージョンで立ち上がります。</p>" +
                 "<p class=text-danger>アップデート中や変換中の小説がある場合は中断されます。<br>" +
                 "終わったかどうか確認しましょう。</p>",
        backdrop: true,
        buttons: {
          danger: {
            label: "再起動",
            className: "btn-danger",
            callback: function() {
              self.reboot();
            }
          },
          main: {
            label: "キャンセル",
            className: "btn-default",
          }
        }
      });
    },

    reboot: function() {
      $.post("/reboot", function(data) {
        bootbox.hideAll();
        bootbox.dialog({
          title: "",
          closeButton: false,
          message: data
        });
      });
    },

    checkUpdatedSystem: function(funcs) {
      $.post("/check_already_update_system", function(data) {
        if (data.result) {
          $.post("/gem_update_last_log", function(log) {
            funcs.already_updated(log);
          });
        }
        else {
          funcs.not_updated();
        }
      });
    },

    updateSystem: function(callback) {
      var notification = Notification.instance();
      notification.one("server.update.success", function(log) {
        callback("success", log);
      });
      notification.one("server.update.nothing", function(log) {
        callback("nothing", log);
      });
      notification.one("server.update.failure", function(log) {
        callback("failure", log);
      });
      $.post("/update_system");
    },

  });

  /*************************************************************************
   * コンソール
   *************************************************************************/
  var Console = Narou.Console = function(notification, options) {
    this.options = $.extend({
      restore: true,   // コンソールの大きさを復元・保存するか
      buttons: true,   // 拡大縮小等のコントロールボタンを使用するか
      id: "#console",  // コンソールのID名
      buttons_id: "#console-buttons"   // コントロールボタンを格納している要素のID名
    }, options);
    this.initialize(notification);
  };

  $.extend(Console.prototype, {
    animate_duration: 200,

    initialize: function(notification) {
      this.notification = notification;
      this.last_char_was_return = true;
      this.console = $(this.options.id);
      this.init_scrollbar();
      if (this.options.buttons) this.init_buttons();
      this.init_events();
      this.init_notification();
      if (this.options.restore) this.restore_console_shape();
    },

    init_scrollbar: function() {
      this.console.perfectScrollbar({
        wheelspeed: 80,
        suppressScrollX: true,
        minScrollbarLength: 20,
      });
      this.original_height = this.console.height();
    },

    init_buttons: function() {
      var self = this;
      this.console.css("min-height", this.original_height);
      $(this.options.buttons_id + " .console-expand").on("click", function(e) {
        self.expand_console();
      });
      $(this.options.buttons_id + " .console-trash").on("click", function(e) {
        self.trash_console();
      });
      $(this.options.buttons_id + " .queue-cancel").on("click", function(e) {
        $.post("/api/cancel");
      });
    },

    init_events: function() {
      this.manage_resize_event();
      var self = this;
      this.console.on("resize", function() {
        if (!self.options.restore) return;
        var data = {
          height: self.console.height(),
          expanded: self.console.hasClass("expanded")
        };
        storage.set("console", data);
        storage.save();
      });
      this.init_events_progressbar();
      this.notification.on("console.clear", function() {
        self.clear();
      });
    },

    init_events_progressbar: function() {
      var self = this;
      var $progress = null;
      var createProgressHtml = function(percent) {
        return '<div class="progress"><div class="progress-bar progress-bar-success progress-bar-striped active" role="progressbar" style="width:' + percent + '%"></div></div>';
      };
      var initializeProgressbar = function(percent) {
        self.puts(createProgressHtml(percent));
        $progress = self.console.find(".progress > div");
      };
      var setProgressValue = function(step) {
        $progress.width(step + "%");
      };
      this.notification.on("progressbar.init", function() {
        initializeProgressbar(0);
      });
      this.notification.on("progressbar.step", function(value) {
        if ($progress) {
          setProgressValue(value);
        }
        else {
          initializeProgressbar(value);
        }
      });
      this.notification.on("progressbar.clear", function() {
        if (!$progress) return;
        $progress = null;
        $(".progress").parent("div").remove();
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
      con.scrollTop(con.prop("scrollHeight"));
    },

    position_is_bottom: function() {
      var con = this.console;
      return (con.scrollTop() >= con.prop("scrollHeight") - con.outerHeight() - 10);
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
      if (was_bottom) {
        this.scroll_to_bottom();
      }
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
            self.console.perfectScrollbar("update");
          });
      this.toggle_expanded();
    },

    toggle_expanded: function() {
      this.console.toggleClass("expanded");
      $(".console-expand > span").toggleClass("hide");
    },

    // コンソールのログを削除すると同時に、サーバの履歴も削除する
    trash_console: function() {
      this.clear();
      $.post("/api/clear_history");
    },

    // コンソールの内容をクリア
    clear: function() {
      this.console.find("div.console-line").remove();
    }
  });

  /*************************************************************************
   * タグ機能
   *************************************************************************/
  var Tag = Narou.Tag = (function(table) {
    this.table = table;
    this.registerEvents($("#tag-list-canvas"));
    this.updateCanvas();
  });

  $.extend(Tag.prototype, {
    updateCanvas: function() {
      var $canvas = $("#tag-list-canvas");
      $.get("/api/tag_list", function(source) {
        $canvas.html(source);
      });
    },

    registerEvents: function($target, stop_bubbling) {
      var self = this;
      if (typeof stop_bubbling === "undefined") stop_bubbling = true;
      var args = { stop_bubbling: stop_bubbling };
      $target.on("click", ".tag", args, function(e) {
        if (e.data.stop_bubbling) e.stopPropagation();
        var tag_name = $(this).data("tag");
        $("#tag-search").val(tag_name);
        storage.set("tag_search", tag_name);
        storage.save();
        self.table.draw();
        self.table.$("[data-toggle=tooltip]").tooltip("hide");
      }).on("mousedown", ".tag", args, function(e) {
        // 範囲選択モードでもクリック出来るように
        if (e.data.stop_bubbling) e.stopPropagation();
      });
    },

    openEditor: function() {
      var ids = Action.prototype._getSelectedIds.call(this, arguments);
      if (ids.length === 0) return;
      this._createEditorField(ids, function(field) {
        bootbox.dialog({
          title: "タグの編集",
          message: field,
          buttons: {
            cancel: {
              label: "キャンセル",
              className: "btn-default",
              callback: function() {
              }
            },
            main: {
              label: "適用",
              className: "btn-primary",
              callback: function() {
                var states = {};
                var new_tag = $("#new-tag").val();
                $("#tag-editor-field input[type=checkbox]").each(function(i, v) {
                  states[$(v).data("tagname")] = $(v).data("checkState");
                });
                if (new_tag) {
                  states[new_tag] = 2;
                }
                $.post("/api/edit_tag", {
                  ids: ids,
                  states: states
                });
              }
            }
          }
        });
      });
    },

    _createEditorField: function(ids, callback) {
      var field = $("<div id=tag-editor-field class=form-group>");
      var self = this;
      var ids_count = ids.length;

      function calcState(count) {
        if (count === 0) {
          return 0;
        }
        else if (count < ids_count) {
          return 1;
        }
        else {
          return 2;
        }
      }

      $.post("/api/taginfo.json", { ids: ids }, function(taginfo) {
        $.each(taginfo, function(tagname, info) {
          var label = $('<label><input type="checkbox" data-tagname="' + tagname.replace(/"/g, "&quot;") +
            '" data-default-checkstate=' + calcState(info.count) + '> ' + info.html + '&nbsp;&nbsp;</label>');
          field.append(label);
        });
        var input = $('<div><input type="text" id="new-tag" placeholder="新規タグ" class="form-control"></div>' +
            '<div><small>（複数追加する場合は半角スペースで区切る）</small></div>');
        field.append(input);
        self._registerEventsForEditorField(field);
        callback(field);
      });
    },

    _registerEventsForEditorField: function(field) {
      function setCheckState(element, state) {
        switch (state) {
        case 0:
          element.prop("indeterminate", false);
          element.prop("checked", false);
          break;
        case 1:
          if (element.data("defaultCheckstate") == 1) {
            element.prop("indeterminate", true);
            element.prop("checked", false);
            break;
          }
          state++;
        case 2:
          element.prop("indeterminate", false);
          element.prop("checked", true);
          break;
        }
        element.data("checkState", state);
      }

      field.find("input[type=checkbox]")
        .on("click", function(e) {
          var elm = $(e.target);
          var next_state = (elm.data("checkState") + 1) % 3;
          setCheckState(elm, next_state);
        })
        .each(function(i, v) {
          var elm = $(v);
          setCheckState(elm, elm.data("defaultCheckstate"));
        });
    },
  });

  /*************************************************************************
   * タグの色選択機能
   *************************************************************************/
  var SelectColorMenu = Narou.SelectColorMenu = (function() {
    this.initializeEvents();
    this.initializeMenuEvents();
    this.$menu = $("#select-color-menu");
  });

  $.extend(SelectColorMenu.prototype, {
    open: function(target_tag, pos, callback) {
      var self = this;
      this.target_tag = target_tag;
      var caller = function() {
        if (typeof callback === "function")
          callback();
      };
      $(document).one("hide.bs.dropdown", function() {
        self.$menu.hide();
      });
      Narou.popupMenu("#select-color-menu", pos, function() {
        self.$menu.hide();
        caller();
      });
    },

    initializeEvents: function() {
      var self = this;
      $(document).on("click", ".select-color-button", function(e) {
        e.stopPropagation();
        var $this = $(this);
        var pos = {
          x: $this.offset().left + $this.width() + 10,
          y: $this.offset().top - 20
        }
        self.open($(this).data("targetTag"), pos, function() {
        });
      });
    },

    initializeMenuEvents: function() {
      var self = this;
      var colors = ["green", "yellow", "blue", "magenta", "cyan", "red", "white"];
      $.each(colors, function(i, color) {
        $("#select-color-menu-" + color).on("click", function(e) {
          e.preventDefault();
          e.stopPropagation();
          $.post("/api/change_tag_color", {
            tag: self.target_tag,
            color: color
          });
          self.$menu.hide();
        });
      });
    },
  });

  /*************************************************************************
   * ドラッグ＆ドロップ関係
   *************************************************************************/
  var DragDrop = Narou.DragDrop = (function() {
     this.initializeValidateUrlRegexpList();
  });

  $.extend(DragDrop.prototype, {
    initializeValidateUrlRegexpList: function() {
      if (typeof this.validate_url_regexp_list !== "undefined") return;
      var self = this;
      this.validate_url_regexp_list = [];
      $.ajax({
        type: "GET",
        url: "/api/validate_url_regexp_list",
        dataType: "json",
        success: function(json) {
          $.each(json, function(i, value) {
            self.validate_url_regexp_list.push(value);
          });
        }
      });
    },

    isValidNovelUrl: function(url) {
      var result = false;
      $.each(this.validate_url_regexp_list, function(i, regexp) {
        if (url.match(regexp)) {
          result = true;
          return false;   // break
        }
      });
      return result;
    },

    getLinkText: function(event, callback) {
      var self = this;
      var data_transfer = event.dataTransfer;
      $.each(data_transfer.types, function(i, type) {
        if (type === "Files") {
          // ショートカットファイルがドラッグされた場合は中身からリンクを抜き出す
          $.each(data_transfer.files, function(i, file) {
            if (!self.isSupportFile(file.name)) return;
            var reader = new FileReader;
            reader.onload = function(e) {
              var link = self.parseLink(file.name, reader.result);
              if (link) callback(link);
            };
            reader.readAsText(file);
          });
        }
        else {
          // TextはIE用
          if (type === "text/plain" || type === "Text") {
            var link = data_transfer.getData(type);
            if (link.length > 0) {
              callback(link);
            }
          }
        }
      });
      return;
    },

    isSupportFile: function(filename) {
      return !!filename.match(/\.(?:url|webloc)$/i);
    },

    parseLink: function(filename, text) {
      filename.toLowerCase().match(/\.(url|webloc)$/);
      var link = null;
      switch (RegExp.$1) {
      case "url":
        link = this.parseLinkDotURL(text);
        break;
      case "webloc":
        link = this.parseLinkDotWebloc(text);
        break;
      }
      return link;
    },

    // OSX で使われる .webloc 形式のショートカット
    parseLinkDotWebloc: function(text) {
      if (text.match(/<string>(.+?)<\/string>/i)) {
        return RegExp.$1;
      }
      return null;
    },

    // Windows で使われる .URL 形式のショートカット
    parseLinkDotURL: function(text) {
      if (text.match(/URL=(.+)/i)) {
        return RegExp.$1;
      }
      return null;
    },
  });

  /*************************************************************************
   * 自動保存・同期機能付きメモ帳
   *************************************************************************/
  var Notepad = Narou.Notepad = (function() {
    this.object_id = this.createObjectId();
  });

  Notepad.replace = function(id, options) {
    var notepad = new Notepad;
    notepad.replace(id, options);
    return notepad;
  };

  $.extend(Notepad.prototype, {
    DEFAULTS: {
      autosave: true,
      readonly: false,
      synchronizing: true,    // 別ウィンドウ同士で内容を同期するか
      rows: 20,
      // string or Deferred オブジェクト
      text: function() {
        return $.get("/api/notepad/read");
      }
    },

    renderer: _.template(
                '<div id="<%= container_id %>" class="notepad-container">' +
                '<textarea class="form-control" rows="<%- rows %>" ' +
                '<% if (readonly) { %>readonly<% } %>' +
                '><%- text %></textarea>' +
                '<span class="notepad-icon glyphicon glyphicon-ok text-success hide"></span>' +
                '</div>'
              ),

    replace: function(id, options) {
      var opt = _.merge({}, this.DEFAULTS, options);
      this.id = id;
      this.autosave = opt.autosave;
      this.readonly = opt.readonly;
      this.synchronizing = opt.synchronizing;
      this.rows = opt.rows;
      this.text = opt.text;

      this.createElements();
    },

    save: function(textarea) {
      var self = this;
      textarea._old_value = textarea.value;
      return $.post("/api/notepad/save", {
        text: textarea.value,
        object_id: this.object_id
      })
      .done(function() {
        self.activeOkIcon();
      });
    },

    createObjectId: function() {
      return String((new Date).getTime()) + _.random(0, 10000);
    },

    createElements: function() {
      var self = this;
      var text = this.text;
      var render = function(stringified_text) {
        var rendered_html = self.renderer({
          container_id: self.containerId(),
          readonly: self.readonly,
          rows: self.rows,
          text: stringified_text
        });
        var elm = $("#" + self.id).html(rendered_html);
        var textarea = elm.find("textarea");
        if (self.autosave && !self.readonly) {
          self.attachAutoSaveEvents(textarea);
        }
        if (self.synchronizing) {
          self.attachSynchronizingEvents(textarea);
        }
      };

      if (typeof text == "function") {
        text()
          .done(function(stringified_text) {
            render(stringified_text);
          })
          .fail(function() {
            render("");
          });
      }
      else {
        render(text);
      }
    },

    attachAutoSaveEvents: function(textarea) {
      var timer_id = null;
      var self = this;

      textarea
        .on("focus", function() {
          this._old_value = this.value;
        })
        .on("blur", function() {
          if (this.value !== this._old_value) {
            self.save(this);
          }
        })
        .on("keyup paste cut", function() {
          // paste, cut イベントは実行される「直前」に発生するので、
          // 実際にテキストボックスに反映されるまでに少し待つ
          setTimeout(function() {
            clearTimeout(timer_id);
            timer_id = setTimeout(function(value, old_value) {
              if (value !== old_value) {
                self.save(this);
              }
            }.bind(this), 1000, this.value, this._old_value);
          }.bind(this), 10);
        })
    },

    activeOkIcon: function() {
      var icon = this.container().find(".notepad-icon");
      icon
        .removeClass("hide")
        .show()
        .delay(2000)
        .fadeOut(1000);
    },

    attachSynchronizingEvents: function(textarea) {
      var self = this;
      var notification = Notification.instance();
      notification.on("notepad.change", function(data) {
        if (data.object_id == self.object_id)
          return;
        var dom = textarea[0];
        if (dom.value != data.text) {
          dom.value = dom._old_value = data.text;
        }
      });
    },

    container: function() {
      return $("#" + this.containerId());
    },

    containerId: function() {
      return self.id + "_notepad";
    },
  });

  /*************************************************************************
   * 埋め込みテンプレート変換
   *************************************************************************/
  Narou.Template = {
    // role="template" を探して、そのテンプレートを処理したあと
    // 同じ場所にレンダリング結果を埋め込む。
    // 一回だけレンダリングすればいいもの向け
    replaceAll: function(hash) {
      $("[role=template]").each(function() {
        var renderer = _.template($(this).text());
        $(this).after(renderer(hash));
      });
    }
  };


  /*************************************************************************
   * フラッシュメッセージ
   *************************************************************************/
  Narou.Flash = {
    renderer: _.template(
                '<div class="container">' +
                '<div class="fadeout-alert alert alert-<%= type %>">' +
                '<%= message %>' +
                '</div></div>'
              ),

    show: function(message, type) {
      var obj = $(Narou.Flash.renderer({
        message: message, type: type || "success"
      }));
      $("body").append(obj);
      this.setEvents(obj);
    },

    setEvents: function(object) {
      $(object)
        .delay(2000)
        .animate({ opacity: "hide" }, 1500)
        .queue(function(next) {
          $(this).remove();
          next();
        });
    }
  };

  return Narou;
})();

