/* -*- coding: utf-8 -*-
 *
 * Copyright 2013 whiteleaf. All rights reserved.
 */
var t;   // for debugging
$(document).ready(function() {
  "use strict";

  var touchable_device = "ontouchstart" in window;
  var click_event_name = (touchable_device ? "touchstart" : "click");

  // MEMO: table 全てに対して操作
  // table.$("tr.selected").removeClass("selected");
  // MEMO: .selected が付いている行を全て取得
  // table.rows('.selected').data().length

  // 端末ごとの表示項目初期設定
  var cell_visible = (touchable_device ?
      // スマフォ系端末
      {
        id: false, last_update: false, title: true, author: false, sitename: false,
        toc_url: false, novel_type: false, tags: false, status: false, menu: true,
        download: false,
      }
      // PC
    : {
        id: true, last_update: true, title: true, author: true, sitename: true,
        toc_url: true, novel_type: true, tags: true, status: true, menu: true,
        download: true,
      });

  $.fn.dataTable.Api.register("fireChangeSelect()", function() {
    $(this.table().node()).trigger("changeselect");
  });

  $.fn.dataTable.Api.register("eachRow()", function(callback) {
    this.table().rows().eq(0).each(function(idx) {
      var row = table.row(idx);
      var data = row.data();
      callback(row, data);
    });
  });

  var now = new Date;
  var today = Narou.formatDate(now, "YYYYMMDD");
  var ANNOTATION_COLOR_TIME_LIMIT = 6 * 60 * 60;   // 6時間(秒)

  function isToday(date) {
    var dateobj = (typeof date === "number" ? new Date(date * 1000) : date);
    return Narou.formatDate(dateobj, "YYYYMMDD") === today;
  }

  var table = t = $("#novel-list").DataTable({
    ajax: "/api/list",
    dom: (touchable_device ? 'lprtpi' : 'Rlprtpi'),
    stateSave: true,
    stateDuration: 0,   // tableの状態保存を永続化
    paginationType: "full_numbers",
    lengthMenu: [[20, 50, 100, -1], [20, 50, 100, "全"]],
    order: [[ 1, "desc" ]],   // 最初は新着順でソートしておく
    columns: [
      // ID
      { title: "ID",
        data: "id", className: "column-id text-center", visible: cell_visible.id },
      // 最終更新日
      { title: "更新日",
        data: "last_update", className: "text-center",
        orderSequence: [ "desc", "asc" ], visible: cell_visible.last_update,
        render: function(data, type, row) {
          if (type === "display" || type === "filter") {
            var date = new Date(data * 1000);
            var display = Narou.formatDate(date, "YYYY/MM/DD<br>hh:mm");
            if (type === "display") {
              var klass = null;
              if (row.new_arrivals_date) {
                if (row.new_arrivals_date >= data
                    && (row.new_arrivals_date + ANNOTATION_COLOR_TIME_LIMIT) * 1000 >= now) {
                  klass = "new-arrivals";
                }
              }
              if (!klass && (data + ANNOTATION_COLOR_TIME_LIMIT) * 1000 >= now) {
                klass = "new-update";
              }
              if (klass) {
                display = "<span class=" + klass + ">" + display + "</span>";
              }
            }
            return display;
          }
          return data;
        }
      },
      // タイトル
      { title: "タイトル",
        data: "title", visible: cell_visible.title },
      // 作者名
      { title: "作者名",
        data: "author", visible: cell_visible.author },
      // 掲載サイト
      { title: "掲載",
        data: "sitename", visible: cell_visible.sitename },
      // 掲載URL
      {
        title: "リンク",
        data: "toc_url", className: "text-center", orderable: false,
        searchable: false, visible: cell_visible.toc_url },
      // 小説種別
      { title: "種別",
        data: "novel_type", className: "text-center", width: "25px",
        orderSequence: [ "desc", "asc" ], visible: cell_visible.novel_type },
      // タグ
      { title: "タグ",
        data: "tags", orderSequence: [ "desc", "asc" ], width: "70px",
        visible: cell_visible.tags },
      // 状態
      { title: "状態",
        data: "status", visible: cell_visible.status },
      // 書籍データDLリンク
      {
        title: "ＤＬ",
        data: "download", className: "text-center", orderable: false,
        searchable: false, visible: cell_visible.download },
      {
        title: "個別",
        data: "menu", className: "text-center",
        defaultContent: '<button class="btn btn-default btn-xs">' +
                        '<span class="glyphicon glyphicon-cog"></span></button>',
        visible: cell_visible.menu,
        createdCell: function(td, cellData, rowData, rowIndex, colIndex) {
          $(td).children("button")
            .data("targetId", rowData.id)
            .on("click", function(e) {
              e.stopPropagation();
              var $this = $(this);
              var $tr = $(e.target).closest("tr");
              var target_id = $this.data("targetId");
              var $cover = $("<div class=context-menu-target-cover>");
              // MEMO: IEだと要素を追加してから座標を指定しないと反映されない
              $("body").append($cover);
              $cover.offset($tr.offset()).width($tr.width()).height($tr.height());
              context_menu.open(target_id, get_event_position(e), function() {
                $cover.remove();
              });
            });
        },
        render: function() {},
        searchable: false, orderable: false,
      },
      // 凍結状態（内部データ用）
      { title: "凍結", data: "frozen", visible: false, system_column: true },
      // 新着時間（内部データ用）
      { title: "新着時間", data: "new_arrivals_date", visible: false, system_column: true },
    ].map(function(hash) {
      // 検索用に name 要素を追加
      hash.name = hash.data;
      // table-cell 内で position: abosolute を使うために div をかます
      // 参考： http://no1026.com/archives/406
      if (!hash.render) {
        hash.render = function(data, type, row) {
          if (type === "display" || type === "filter") {
            return "<div>" + data + "</div>";
          }
          return data;
        }
      }
      return hash;
    }),
    stateLoadParams: function (_settings, data) {
      // 独自フィルタボックスへセーブデータを反映
      if (data.search.search != "") {
        $("#myFilter").val(data.search.search);
        $("#myFilter-clear").show();
      }
      else {
        $("#myFilter-clear").hide();
      }
    },
    createdRow: function(row, data, data_index) {
      if (data.frozen) {
        $(row).addClass("frozen");
      }
    },
    initComplete: function(_settings, _json) {
      table.$("[data-toggle=tooltip]").tooltip({
        animation: false,
        container: "body",
      });
      // バッジを更新しておく
      table.fireChangeSelect();
      // 範囲選択モードでもリンクとボタンが使えるように
      table.$("a, button").on("mousedown", function(e) {
        e.stopPropagation();
      });
      // タグのイベントを反映
      tag.registerEvents(table);
    },
    language: {
      lengthMenu: "_MENU_ 件分表示",
      zeroRecords: "データがひとつもないか、処理中です",
      info: "Page _PAGE_ of _PAGES_",
      infoEmpty: "該当なし",
      infoFiltered: "(全_MAX_件から検索しました)",
      paginate: {
        first: "&laquo;",
        previous: "前へ",
        next: "次へ",
        last: "&raquo;"
      },
    },
    /*
     * Extensions section
     */
    colReorder: {
      "realtime": false
    },
  });

  $.fn.dataTableExt.afnFiltering.push(function(oSettings, aData, iDataIndex) {
    var row = table.row(iDataIndex);
    return !$(row.node()).hasClass("exclude");
  });

  var storage = new Narou.Storage();
  var action = new Narou.Action(table);
  var notification = Narou.Notification.instance();
  var stream_console = new Narou.Console(notification);
  var context_menu = new Narou.ContextMenu(action, notification);
  var tag = new Narou.Tag(table);

  notification.on("table.reload", function() {
    // リロードする前に現在の状態を保存
    var selected_ids = [], excluded_ids = [];
    table.eachRow(function(row, data) {
      var $node = $(row.node());
      if ($node.hasClass("selected")) {
        selected_ids.push(data.id);
      }
      if ($node.hasClass("exclude")) {
        excluded_ids.push(data.id);
      }
    });
    table.ajax.reload(function() {
      // リロードしたら状態は解除されているので復元
      table.$("[data-toggle=tooltip]").tooltip({
        animation: false,
        container: "body",
      });
      table.eachRow(function(row, data) {
        if ($.inArray(data.id, selected_ids) !== -1) {
          $(row.node()).addClass("selected");
        }
        if ($.inArray(data.id, excluded_ids) !== -1) {
          $(row.node()).addClass("exclude");
        }
      });
      table.fireChangeSelect();
      table.draw(false);
    }, false);
  });

  notification.on("tag.updateCanvas", function() {
    tag.updateCanvas();
  });

  tag.registerEvents($(".tag-field"));

  var action_select_view = $("#action-select-view");
  var myfilter_clear = $("#myFilter-clear");

  /*
   * カスタムフィルタボックスで入力値をフィルタする
   */
  $("#myFilter").on("keyup", function() {
    table.search($(this).val()).draw();
    if ($(this).val() === "") {
      myfilter_clear.hide();
    }
    else {
      myfilter_clear.show();
    }
  })
  /*
   * リセットボタン(X)
   */
  $("#myFilter-clear").on(click_event_name, function() {
    table.search("").draw();
    $("#myFilter").val("");
    myfilter_clear.hide();
  });

  /*************************************************************
   * 小説の選択関係
   *************************************************************/

  // 指定地点に対象要素があるかどうか背面の要素までさかのぼって探す
  $.searchElementFromPoint = function(pos, target) {
    var doc = $(document);
    var html_dom = $("html")[0];
    var display_x = pos.x - doc.scrollLeft();
    var display_y = pos.y - doc.scrollTop();
    var get_element_from_pos = function(x, y, t) {
      var elm = document.elementFromPoint(x, y);
      if (!elm || elm === html_dom) return null;
      var elm_jq = $(elm);
      if (!elm_jq.is(t)) {
        elm_jq.hide();
        elm = get_element_from_pos(x, y, t);
        elm_jq.show();
      }
      return elm;
    };
    var element = get_element_from_pos(display_x, display_y, target);
    return element ? $(element) : null;
  };

  $.elementFromPoint = function(pos) {
    var doc = $(document);
    var rect = $("#rect-select-area");
    var rect_visibility = rect.is(":visible");
    if (rect_visibility) rect.hide();
    var elm = document.elementFromPoint(pos.x - doc.scrollLeft(),
                                        pos.y - doc.scrollTop());
    if (rect_visibility) rect.show();
    return elm ? $(elm) : null;
  };

  function get_event_position(e) {
    if (e.type !== "touchstart") {
      return { x: e.pageX, y: e.pageY };
    }
    else {
      return { x: e.originalEvent.touches[0].pageX,
               y: e.originalEvent.touches[0].pageY };
    }
  }

  var select_mode = storage.get("select_mode") || "single";
  var enable_rect_select_mode = function() {};
  var disable_rect_select_mode = function() {};

  $("#action-select-mode-single").on(click_event_name, function(e) {
    if (select_mode != "single") {
      $(this).addClass("active");
      $("#action-select-mode-rect").removeClass("active");
      select_mode = "single";
      storage.set("select_mode", select_mode).save();
      disable_rect_select_mode();
      enable_single_select_mode();
    }
    slideNavbar.close();
    e.preventDefault();
  });

  function disable_single_select_mode() {
    table.off("click", "tr")
    table.off("click", "a")
    $("#novel-list tbody").css("cursor", "auto");
  }

  function enable_single_select_mode() {
    var dont_select = false;
    // ここだけはスマフォ系でも touchstart ではなく click で。
    // touchstart だと画面スクロールのためのスワイプでも反応してしまう
    table
      .on("click", "tr", function () {
        $(this).toggleClass("selected");
        table.fireChangeSelect();
      })
      .on("click", "a", function(e) {
        // リンクをクリックした時は選択処理は行わない
        e.stopPropagation();
      })
    $("#novel-list tbody").css("cursor", "pointer");
  }

  if (touchable_device) {
    // スマフォ系は範囲選択モードは封印しておく
    $("#action-select-mode-rect").addClass("disabled");
  }
  else {
    $("#action-select-mode-rect").on(click_event_name, function(e) {
      if (select_mode != "rect") {
        $(this).addClass("active");
        $("#action-select-mode-single").removeClass("active");
        select_mode = "rect";
        storage.set("select_mode", select_mode).save();
        disable_single_select_mode();
        enable_rect_select_mode();
      }
      slideNavbar.close();
      e.preventDefault();
    });

    var selected_rect_element = $("<div id=rect-select-area>").hide();
    $("body").append(selected_rect_element);

    disable_rect_select_mode = function() {
      $("body").off("mousedown mousemove mouseup");
      $("#novel-list tbody, #rect-select-area").css("cursor", "auto");
      close_rect_select_menu_handler();
    };

    var close_rect_select_menu_handler = function() {
      $("#rect-select-menu").hide();
      selected_rect_element.hide();
    };

    var unregister_close_handler = function() {
      $(document).off("click", close_rect_select_menu_handler);
    };

    var start_element, end_element;

    var get_rows_rect_selected = function() {
      var target = "td";
      var start = start_element;
      var end = end_element;
      var rows = [];
      if (!start || !end) {
        return rows;
      }
      var from, to;
      if (start.offset().top < end.offset().top) {
        from = start.parents("tr");
        to = end.parents("tr");
      }
      else {
        from = end.parents("tr");
        to = start.parents("tr");
      }
      var current = from;
      while (current.length !== 0) {
        rows.push(current);
        if (current[0] === to[0]) break;
        current = current.next();
      }
      return rows;
    };

    // 範囲選択後に表示される選択肢
    var rect_select_menu_initialize = function() {
      var menu = $("#rect-select-menu");
      // 選択
      $("#rect-select-menu-select").on("click", function(e) {
        e.preventDefault();
        var rows = get_rows_rect_selected();
        $.each(rows, function(_i, row) {
          row.addClass("selected");
        });
        table.fireChangeSelect();
        menu.hide();
        selected_rect_element.hide();
      });
      // 解除
      $("#rect-select-menu-clear").on("click", function(e) {
        e.preventDefault();
        var rows = get_rows_rect_selected();
        $.each(rows, function(_i, row) {
          row.removeClass("selected");
        });
        table.fireChangeSelect();
        menu.hide();
        selected_rect_element.hide();
      });
      // 反転
      $("#rect-select-menu-reverse").on("click", function(e) {
        e.preventDefault();
        var rows = get_rows_rect_selected();
        $.each(rows, function(_i, row) {
          row.toggleClass("selected");
        });
        table.fireChangeSelect();
        menu.hide();
        selected_rect_element.hide();
      });
      // キャンセル
      $("#rect-select-menu-cancel").on("click", function(e) {
        e.preventDefault();
        menu.hide();
        selected_rect_element.hide();
      });
    };
    rect_select_menu_initialize();

    enable_rect_select_mode = function() {
      var not_clicked_yet = true;
      var is_moved = false;
      var start_position = null;
      var end_position = null;
      $("#novel-list tbody, #rect-select-area").css("cursor", "crosshair");
      $("body").on("mousedown", function(e) {
        var _pos = get_event_position(e);
        var mousedowned_element = $.elementFromPoint(_pos);
        if (!mousedowned_element || mousedowned_element.closest("#novel-list tbody").length === 0)
          return;
        e.preventDefault();
        e.stopPropagation();
        var self = this;
        var finish_selecting_proc = function() {
          $(self).off("mousemove mouseup");
          not_clicked_yet = true;
          is_moved = false;
          Narou.popupMenu("#rect-select-menu", end_position, close_rect_select_menu_handler);
        };
        if (not_clicked_yet) {
          // 範囲選択開始
          $("#rect-select-menu").hide();
          unregister_close_handler();
          not_clicked_yet = false;
          start_position = _pos;
          start_element = mousedowned_element;
          $(self).on("mousemove", function(e) {
            is_moved = true;
            var pos = get_event_position(e);
            if ($.elementFromPoint(pos).closest("#novel-list tbody").length === 0)
              return;
            end_position = pos;
            end_element = $.searchElementFromPoint(end_position, "td");
            var rect = {};
            rect.x = (pos.x < start_position.x ? pos.x : start_position.x);
            rect.y = (pos.y < start_position.y ? pos.y : start_position.y);
            rect.w = Math.abs(pos.x - start_position.x);
            rect.h = Math.abs(pos.y - start_position.y);
            selected_rect_element.css({
              left: rect.x, top: rect.y,
              width: rect.w, height: rect.h
            });
          });
          // ボタンを離さないでそのまま移動させた場合は、ドラッグによる範囲選択とみなす
          $(self).on("mouseup", function(e) {
            if (is_moved) {
              finish_selecting_proc();
            }
          });
          selected_rect_element.css({
            left: start_position.x,
            top: start_position.y,
            width: 1, height: 1
          }).show();
        }
        else {
          finish_selecting_proc();
        }
      });
    }
  }

  function restore_select_mode() {
    if (select_mode === "single") {
      enable_single_select_mode();
      $("#action-select-mode-single").addClass("active");
    }
    else {
      enable_rect_select_mode();
      $("#action-select-mode-rect").addClass("active");
    }
  }
  restore_select_mode();

  /*
   * メニュー
   *   表示＞全ての項目を表示
   */
  $("#action-view-all").on(click_event_name, function(e) {
    e.preventDefault();
    slideNavbar.slide();
    var aoColumns = table.settings()[0].aoColumns;
    table.columns().eq(0).each(function(index) {
      if (!aoColumns[index].system_column) {
        table.column(index).visible(true);
      }
    });
    table.draw(false);
  });

  /*
   * メニュー
   *   表示＞表示する項目を設定
   */
  var colvis = new $.fn.dataTable.ColVis(table, {
    restore: "元に戻す",
    showAll: "全ての項目を表示",
    showNone: "全て隠す",
    bCssPosition: true,
    overlayFade: 300,
    exclude: [ "title", "frozen", "new_arrivals_date" ],
  });
  $("#action-view-setting").on(click_event_name, function(e) {
    e.preventDefault();
    var pos = {};
    if (touchable_device) {
      var target = $(this);
      pos.x = target.offset().left;
      pos.y = target.offset().top + target.outerHeight();
    }
    else {
      pos = get_event_position(e);
    }
    $(colvis.dom.collection).css({
      position: "absolute",
      left: pos.x, top: pos.y
    });
    slideNavbar.slide();
    colvis._fnCollectionShow();
  });

  /*
   * メニュー
   *   表示＞凍結中以外を表示
   */
  var nonfrozen_rows = [];
  $("#action-view-without-frozen").on(click_event_name, function(e) {
    e.preventDefault();
    slideNavbar.slide();
    $(this).toggleClass("active");
    table.rows().eq(0).each(function(idx) {
      var row = table.row(idx);
      var data = row.data();
      if (!data.frozen) {
        $(row.node()).toggleClass("exclude");
      }
    });
    table.draw();
  });

  /*
   * メニュー
   *   表示＞凍結中を表示
   */
  var frozen_list = [];
  $("#action-view-frozen").on(click_event_name, function(e) {
    e.preventDefault();
    slideNavbar.slide();
    $(this).toggleClass("active");
    table.rows().eq(0).each(function(idx) {
      var row = table.row(idx);
      var data = row.data();
      if (data.frozen) {
        $(row.node()).toggleClass("exclude");
      }
    });
    table.draw();
  });

  /*
   * メニュー
   *   表示＞表示設定を全てリセット
   */
  $("#action-view-reset").on(click_event_name, function(e) {
    // localStorageを全て消してリロードする
    localStorage.clear();
  });

  /*
   * メニュー
   *   選択＞全ての小説を選択
   */
  $("#action-select-all").on(click_event_name, function(e) {
    e.preventDefault();
    slideNavbar.slide();
    action.selectAll();
  });

  /*
   * メニュー
   *   選択＞表示されている小説を選択
   */
  $("#action-select-view").on(click_event_name, function(e) {
    e.preventDefault();
    slideNavbar.slide();
    action.selectView();
  });

  /*
   * メニュー
   *   選択＞選択を全て解除
   */
  $("#action-select-clear").on(click_event_name, function(e) {
    e.preventDefault();
    slideNavbar.slide();
    action.selectClear();
  });

  /*
   * メニュー
   *   タグ > 選択した小説のタグを編集
   */
  $("#action-tag-edit").on(click_event_name, function(e) {
    e.preventDefault();
    slideNavbar.slide();
    tag.openEditor();
  });

  /*
   * メニュー
   *   オプション＞環境設定
   */
  $("#action-option-settings").on(click_event_name, function(e) {
    // ページ遷移するだけ
  });

  /*
   * メニュー
   *   オプション＞ヘルプ
   */
  $("#action-option-help").on(click_event_name, function(e) {
    // ページ遷移するだけ
  });

  /*
   * メニュー
   *   オプション＞Narou.rbについて
   */
  $("#action-option-about").on(click_event_name, function(e) {
    e.preventDefault();
    slideNavbar.slide();
    $.get("/about", function(data) {
      bootbox.dialog({
        title: '<span class="glyphicon glyphicon-info-sign"></span> Narou.rb について',
        message: data,
        backdrop: true
      });
    });
  });

  /*
   * メニュー
   *   オプション＞サーバをシャットダウン
   */
  $("#action-option-server-shutdown").on(click_event_name, function(e) {
    e.preventDefault();
    slideNavbar.slide();
    bootbox.dialog({
      title: '<span class="glyphicon glyphicon-off"></span> シャットダウン',
      message: "Narou.rb WEB UI サーバをシャットダウンします。<br>" +
               "シャットダウンすると再起動するまでアクセスは出来なくなります。<br>" +
               "再起動するにはコンソールでもう一度 <kbd>narou web</kbd> を実行" +
               "して下さい。",
      backdrop: true,
      buttons: {
        danger: {
          label: "シャットダウン",
          className: "btn-danger",
          callback: function() {
            $.post("/shutdown", function(data) {
              bootbox.alert(data);
            });
          }
        },
        main: {
          label: "キャンセル",
          className: "btn-default",
        }
      }
    });
  });

  /*
   * 「選択」メニューの横に現在選択中の小説数をバッジで表示
   */
  var register_badge_number_of_selecting = function(table) {
    table.on("changeselect", function() {
      var selected_count = table.rows(".selected").data().length;
      $("#badge-number-of-selecting").text(selected_count);
      var tooltip_opt = {
        animation: false,
        container: "body",
        placement: "bottom"
      }
      if (selected_count > 0) {
        tooltip_opt.title = "選択した小説を更新";
        $("#button-update").tooltip("destroy").tooltip(tooltip_opt);
        tooltip_opt.title = "選択した小説を送信";
        $("#button-send").tooltip("destroy").tooltip(tooltip_opt);
        enable_menu_item(".enable-selected");
      }
      else {
        tooltip_opt.title = "すべての小説を更新";
        $("#button-update").tooltip("destroy").tooltip(tooltip_opt);
        tooltip_opt.title = "更新された小説を送信";
        $("#button-send").tooltip("destroy").tooltip(tooltip_opt);
        disable_menu_item(".enable-selected");
      }
    });
  };
  register_badge_number_of_selecting(table);

  /*
   * Tooltip 化
   */
  $("[data-toggle=tooltip]").tooltip({
    animation: false,
    container: "body",
    placement: "bottom",
  });

  /*
   * ボタンを一時的に非アクティブ化
   */
  function disableButtonMoment($button) {
    $button.addClass("disabled");
    // 少したったらアクティブに戻す
    setTimeout(function() {
      $button.removeClass("disabled");
    }, 1000);
  }

  /*
   * ボタン
   *   Download > 新規ダウンロード
   */
  $("#button-download").on("click", function(e) {
    e.preventDefault();
    action.download();
  });

  /*
   * ボタン
   *   Download > 選択した小説を強制再ダウンロード
   */
  $("#button-download-force").on("click", function(e) {
    e.preventDefault();
    action.downloadForce();
  });

  /*
   * ボタン
   *   Update
   */
  $("#button-update").on("click", function(e) {
    e.preventDefault();
    disableButtonMoment($(this));
    action.update();
  });

  /*
   * ボタン
   *   Send
   */
  $("#button-send").on("click", function(e) {
    e.preventDefault();
    disableButtonMoment($(this));
    action.send();
  });

  /*
   * ボタン
   *   Freeze > 選択した小説を凍結
   */
  $("#button-freeze-on").on("click", function(e) {
    e.preventDefault();
    action.freezeOn();
  });

  /*
   * ボタン
   *   Freeze > 選択した小説の凍結を解除
   */
  $("#button-freeze-off").on("click", function(e) {
    e.preventDefault();
    action.freezeOff();
  });

  /*
   * ボタン
   *   Remove > 選択した小説を削除
   */
  $("#button-remove").on("click", function(e) {
    e.preventDefault();
    action.remove();
  });

  /*
   * ボタン
   *   Remove > 選択した小説をファイルも含めて削除
   */
  $("#button-remove-with-file").on("click", function(e) {
    e.preventDefault();
    action.removeWithFile();
  });

  /*
   * ボタン
   *   Convert
   */
  $("#button-convert").on("click", function(e) {
    e.preventDefault();
    disableButtonMoment($(this));
    action.convert();
  });

  /*
   * ボタン
   *   Other > 選択した小説の差分を表示
   */
  $("#button-diff").on("click", function(e) {
    e.preventDefault();
    action.diff();
  });

  /*
   * ボタン
   *   Other > 選択した小説の調査状況ログを表示
   */
  $("#button-inspect").on("click", function(e) {
    e.preventDefault();
    action.inspect();
  });

  /*
   * ボタン
   *   Other > 選択した小説の保存フォルダを開く
   */
  $("#button-folder").on("click", function(e) {
    e.preventDefault();
    action.folder();
  });

  /*
   * ボタン
   *   Other > 選択した小説のバックアップを作成
   */
  $("#button-backup").on("click", function(e) {
    e.preventDefault();
    action.backup();
  });

  /*
   * ショートカット設定
   * http://www.openjs.com/scripts/events/keyboard_shortcuts/index.php
   */
  var initialize_shortcut = function() {
    var options = {
      disable_in_input: true,
    };
    var add = function() {
      var keys = [];
      var callback = null;
      for (var i = 0; i < arguments.length; i++) {
        var value = arguments[i];
        switch (typeof value) {
        case "string":
          keys.push(value);
          break;
        case "function":
          callback = value;
          break;
        default:
          $.error("invalid arguments: unknow type");
          break;
        }
      }
      if (!callback) $.error("shortcut error: need callback");
      for (var i = 0; i < keys.length; i++) {
        shortcut.add(keys[i], callback, options);
      }
    };
    add("Ctrl+A", "Meta+A", function() { action.selectView(); });
    add("Shift+A", function() { action.selectAll(); });
    add("Ctrl+Shift+A", "Meta+Shift+A", function() { action.selectClear(); });
    add("ESC", function() {
      if ($("#rect-select-menu").is(":visible")) {
        close_rect_select_menu_handler();
      }
      else {
        action.selectClear();
      }
    });
    add("S", function() {
      $("#action-select-mode-single").trigger("click");
    });
    add("R", function() {
      $("#action-select-mode-rect").trigger("click");
    });
  };
  if (!touchable_device) {
    initialize_shortcut();
  }

  /*
   * disabled なメニューは何もしないように
   */
  var nothing_to_do = function() { return false };
  function disable_menu_item(id) {
    $(id).addClass("disabled").on(click_event_name, nothing_to_do);
  }

  function enable_menu_item(id) {
    $(id).removeClass("disabled").off(click_event_name, nothing_to_do);
  }

  disable_menu_item(".navbar li.disabled");
});

