/* -*- coding: utf-8 -*-
 *
 * Copyright 2013 whiteleaf. All rights reserved.
 */
var t;   // for debugging
$(document).ready(function() {
  "use strict";

  var touchable_device = "ontouchstart" in window;
  var click_event_name = (touchable_device ? "touchstart" : "click");

  var datatables_init_completed = false;

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
        download: true, folder: false, update_button: false, general_lastup: false,
      }
      // PC
    : {
        id: true, last_update: true, title: true, author: true, sitename: true,
        toc_url: true, novel_type: true, tags: true, status: true, menu: true,
        download: true, folder: true, update_button: true, general_lastup: true,
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

  /*
   * タグ検索
   */
  var $tag_search = $("#tag-search");
  $.fn.dataTable.ext.search.push(function (settings, data, dataIndex) {
    var tag_name = $tag_search.val();
    if (tag_name.length == 0) return true;
    var tags = table.row(dataIndex).data().tags;
    return tags.match(new RegExp('data-tag="' + tag_name + '"'));
  });

  var ANNOTATION_COLOR_TIME_LIMIT = 6 * 60 * 60;   // 6時間(秒)
  var GENERAL_LASTUP_CLASSES = [
    [60 * 60, "gl-60minutes"],
    [6 * 60 * 60, "gl-6hour"],
    [24 * 60 * 60, "gl-24hour"],
    [3 * 24 * 60 * 60, "gl-3days"],
    [7 * 24 * 60 * 60, "gl-1week"],
    [-1, "gl-other"]
  ];

  function today() {
    return Narou.formatDate(new Date, "YYYYMMDD");
  }

  function isToday(date) {
    var dateobj = (typeof date === "number" ? new Date(date * 1000) : date);
    return Narou.formatDate(dateobj, "YYYYMMDD") === today();
  }

  // initComplete や ajax.reload した時に再設定するために呼ばれる
  function resettingTableState() {
    refreshTooltop(table.$("[data-toggle=tooltip]"), null, "top");
    // バッジを更新しておく(.selectedの復元が終わってから呼ぶ)
    table.fireChangeSelect();
    // タグのイベントを反映
    tag.registerEvents(table);

    table.draw(false);
  }

  function openContextMenuWithTr(tr, event) {
    var $tr = $(tr);
    var target_id = table.row(tr).data().id;
    var $cover = $("<div class=context-menu-target-cover>");
    // MEMO: IEだと要素を追加してから座標を指定しないと反映されない
    $("body").append($cover);
    $cover.offset($tr.offset()).width($tr.width()).height($tr.height());
    $cover.one("contextmenu", function(e) {
      e.preventDefault();
      $cover.remove();
      context_menu.close();
    });
    context_menu.open(target_id, get_event_position(event), function() {
      $cover.remove();
    });
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
      // UPDATEした日時
      { title: "更新日",
        data: "last_update", className: "text-center",
        orderSequence: [ "desc", "asc" ], visible: cell_visible.last_update,
        render: function(data, type, row) {
          if (type === "display" || type === "filter") {
            var now = new Date;
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
            return "<div>" + display + "</div>";
          }
          return data;
        }
      },
      // なろう：最終話掲載日、ハーメルン：最新投稿
      {
        title: "最新話<br>掲載日",
        data: "general_lastup", className: "text-center",
        orderSequence: [ "desc", "asc" ], visible: cell_visible.general_lastup,
        render: function(data, type, row) {
          if (type === "display" || type === "filter") {
            if (!data)
              return "";
            var now = new Date;
            var date = new Date(data * 1000);
            var diff_time = (now - date) / 1000;
            var display = Narou.formatDate(date, "YYYY/MM/DD<br>hh:mm");
            var klass = "";
            for (var i = 0;; i++) {
              var value = GENERAL_LASTUP_CLASSES[i];
              klass = value[1];
              if (value[0] === -1 || diff_time <= value[0]) break;
            }
            return '<div><span class="general-lastup ' + klass + '">' + display + '</span></div>';
          }
          else if (type === "sort") {
            return data * 10000 + (row.id | 0);
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
      // 掲載URL
      {
        title: "リンク",
        data: "toc_url", className: "text-center", orderable: false,
        searchable: false, visible: cell_visible.toc_url },
      // 書籍データDLリンク
      {
        title: "ＤＬ",
        data: "download", className: "text-center", orderable: false,
        searchable: false, visible: cell_visible.download },
      {
        title: "保存先",
        data: "folder", className: "text-center", orderable: false,
        searchable: false, visible: cell_visible.folder,
        defaultContent: '<button class="btn btn-default btn-xs">' +
                        '<span class="glyphicon glyphicon-folder-open"></span></button>',
        createdCell: function(td, cellData, rowData, rowIndex, colIndex) {
          $(td).children("button")
            .data("targetId", rowData.id)
            .on("click", function(e) {
              e.stopPropagation();
              var $this = $(this);
              var target_id = $this.data("targetId");
              action.folder(target_id);
            });
        },
        render: function() {}
      },
      {
        title: "更新",
        data: "update_button", className: "text-center", orderable: false,
        searchable: false, visible: cell_visible.update_button,
        defaultContent: '<button class="btn btn-default btn-xs">' +
                        '<span class="glyphicon glyphicon-refresh"></span></button>',
        createdCell: function(td, cellData, rowData, rowIndex, colIndex) {
          $(td).children("button")
            .data("targetId", rowData.id)
            .on("click", function(e) {
              e.stopPropagation();
              var $this = $(this);
              var target_id = $this.data("targetId");
              action.updateForce(target_id);
            });
        },
        render: function() {}
      },
      {
        title: "個別",
        data: "menu", className: "text-center",
        defaultContent: '<button class="btn btn-default btn-xs">' +
                        '<span class="glyphicon glyphicon-option-horizontal"></span></button>',
        visible: cell_visible.menu,
        createdCell: function(td, cellData, rowData, rowIndex, colIndex) {
          $(td).children("button")
            .data("targetId", rowData.id)
            .on("click", function(e) {
              e.stopPropagation();
              openContextMenuWithTr($(e.target).closest("tr"), e);
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
      // タグ検索を復元
      $tag_search.val(storage.get("tag_search"));
      // 範囲選択モードでもリンクとボタンが使えるように
      table.on("mousedown", "a, button", function(e) {
        e.stopPropagation();
      });
      // リンククリックした時点でツールチップは消す
      table.on("click", "a", function(e) {
        $(this).tooltip("hide");
      });
      resettingTableState();

      table.draw(false);

      datatables_init_completed = true;
    },
    language: {
      //lengthMenu: "_MENU_ 件分表示　<span id='icon-refresh-table' class='glyphicon glyphicon-repeat'></span>",
      lengthMenu: "_MENU_ 件分表示",
      emptyTable: "データが登録されていません",
      zeroRecords: "ひとつも見つかりませんでした",
      infoPostFix: "",
      info: "Page _PAGE_ of _PAGES_",
      infoEmpty: "該当なし",
      infoFiltered: "(全_MAX_件から検索しました)",
      loadingRecords: "ロード中です",
      processing: "処理中...",
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
      realtime: false,

      // colReorder でカラムの順番が入れ替えられた場合、createdCell 内で
      // 設定している内容が全てリセットされてしまいイベント等が消えてしまうので、
      // ここで一旦リロードしてイベントが再設定されるようにする。
      // これは createdCell が初期化時に一度しか呼ばれないためで、dataTables の
      // 今後のバージョンアップで予定されている updatedCell が実装されるまでの
      // 暫定処置として reorderCallback で代用する。
      // https://github.com/DataTables/ColReorder/issues/49
      reorderCallback: function() {
        // stateSave が有効な状態でカラムが入れ替えられていた場合、
        // initComplete イベントが発火する前に一度この reorderCallback が発火されるので、
        // 無駄なリロードをしないように初期化後のみ有効にする
        if (datatables_init_completed) {
          notification.trigger("table.reload");
        }
      },
    },
  });

  var storage = new Narou.Storage();
  var action = new Narou.Action(table);
  var notification = Narou.Notification.instance();
  var stream_console = new Narou.Console(notification);
  var tag = new Narou.Tag(table);
  var context_menu = new Narou.ContextMenu(action, tag);
  var select_color_menu = new Narou.SelectColorMenu;

  /*
   * コントロールパネル（操作ボタン群）をフッターに移動させる／元に戻す
   */
  var fixed_buttons = storage.get("buttons_fix_footer");

  function fix_buttons_to_footer() {
    refreshTooltop(
        $("#control-panel > div")
          .appendTo("#footer-navbar > .container")
          .addClass("in-footer dropup")
          .find("[data-toggle=tooltip]")
            .data("placement", "top")
        );
    table.fireChangeSelect();
    $("#footer-navbar").removeClass("hide");
  }

  function cancel_fix_buttons() {
    $("#footer-navbar").addClass("hide");
    refreshTooltop(
        $("#footer-navbar > .container > div")
          .appendTo("#control-panel")
          .removeClass("in-footer dropup")
          .find("[data-toggle=tooltip]")
            .data("placement", "bottom")
        );
    table.fireChangeSelect();
  }

  if (fixed_buttons) {
    fix_buttons_to_footer();
  }

  /*
   * 凍結の表示状態制御
   */
  var visibility_frozen_novel, visibility_nonfrozen_novel;

  $.fn.dataTable.ext.search.push(function(settings, data, dataIndex) {
    var state_frozen = table.row(dataIndex).data().frozen;
    if (state_frozen) {
      return visibility_frozen_novel;
    }
    else {
      return visibility_nonfrozen_novel;
    }
  });

  function restoreVisibilityForViewMenu() {
    visibility_frozen_novel = storage.get("visibility_frozen_novel");
    visibility_nonfrozen_novel = storage.get("visibility_nonfrozen_novel");
    var visibility_open_new_tab = storage.get("open_new_tab_setting_pages");
    var visibility_buttons_fix_footer = storage.get("buttons_fix_footer");
    if (typeof visibility_frozen_novel === "undefined")
      visibility_frozen_novel = true;
    if (typeof visibility_nonfrozen_novel === "undefined")
      visibility_nonfrozen_novel = true;
    if (typeof visibility_open_new_tab === "undefined")
      visibility_open_new_tab = false;
    if (typeof visibility_buttons_fix_footer === "undefined")
      visibility_buttons_fix_footer = false;
    // メニューのチェック状態も復元
    var method = ["removeClass", "addClass"];
    $("#action-view-frozen")[method[visibility_frozen_novel | 0]]("active");
    $("#action-view-nonfrozen")[method[visibility_nonfrozen_novel | 0]]("active");
    $("#action-view-toggle-setting-page-open-new-tab")[method[visibility_open_new_tab | 0]]("active");
    $("#action-view-toggle-buttons-fix-footer")[method[visibility_buttons_fix_footer | 0]]("active");
  }

  restoreVisibilityForViewMenu();

  function saveVisibilityFrozen() {
    storage.set("visibility_frozen_novel", visibility_frozen_novel);
    storage.set("visibility_nonfrozen_novel", visibility_nonfrozen_novel);
    storage.save();
  }

  function toggleVisibilityFrozen() {
    visibility_frozen_novel = !visibility_frozen_novel;
  }

  function toggleVisibilityNonFrozen() {
    visibility_nonfrozen_novel = !visibility_nonfrozen_novel;
  }

  /*
   * テーブルリロードイベント定義
   */
  notification.on("table.reload", function() {
    // リロードする前に現在の状態を保存
    var selected_ids = [];
    table.eachRow(function(row, data) {
      var $node = $(row.node());
      if ($node.hasClass("selected")) {
        selected_ids.push(data.id);
      }
    });
    table.ajax.reload(function() {
      // リロードしたら状態は解除されているので復元
      table.eachRow(function(row, data) {
        if ($.inArray(data.id, selected_ids) !== -1) {
          $(row.node()).addClass("selected");
        }
      });
      resettingTableState();
    }, false);
  });

  /*
   * サーバ再起動イベント定義
   */
  notification.on("server.rebooted", function() {
    location.href = "/";
  });

  notification.on("tag.updateCanvas", function() {
    tag.updateCanvas();
  });

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
    return Narou.get_event_position(e);
  }

  var select_mode = storage.get("select_mode") || "hybrid";
  var enable_rect_select_mode = function() {};
  var disable_rect_select_mode = function() {};

  $("#action-select-mode-single").on(click_event_name, function(e) {
    if (select_mode != "single") {
      $(this).addClass("active");
      $("#action-select-mode-" + select_mode).removeClass("active");
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
    // 小説一覧テーブル内で右クリックしたら個別メニューを表示
    $("#novel-list tbody").on("contextmenu", function(e) {
      var target_tag_name = e.target.tagName.toLowerCase();
      // ボタンとかリンクはブラウザの右クリックメニューをそのまま使いたい
      if (target_tag_name === "button" || target_tag_name === "a" ||
          $(e.target).parent("button, a")[0])
        return;

      e.preventDefault();   // ブラウザの右クリックメニューを抑制
      e.stopPropagation();
      var mousedowned_element = $.elementFromPoint(get_event_position(e));
      var tr = mousedowned_element.parents("tr");
      openContextMenuWithTr(tr, e);
    });

    var initMode = function(mode) {
      if (select_mode != mode) {
        $("#action-select-mode-" + mode).addClass("active");
        $("#action-select-mode-" + select_mode).removeClass("active");
        if (select_mode == "single") {
          disable_single_select_mode();
          enable_rect_select_mode();
        }
        select_mode = mode;
        storage.set("select_mode", mode).save();
        $("#novel-list tbody, #rect-select-area")
          .css("cursor", mode == "rect" ? "crosshair" : "pointer");
      }
    };
    $("#action-select-mode-rect").on(click_event_name, function(e) {
      initMode("rect");
      slideNavbar.close();
      e.preventDefault();
    });
    $("#action-select-mode-hybrid").on(click_event_name, function(e) {
      initMode("hybrid");
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
        $(this).children("a").blur();
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
        $(this).children("a").blur();
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
        $(this).children("a").blur();
      });
      // キャンセル
      $("#rect-select-menu-cancel").on("click", function(e) {
        e.preventDefault();
        e.stopPropagation();
        menu.hide();
        selected_rect_element.hide();
        $(this).children("a").blur();
      });
    };
    rect_select_menu_initialize();

    enable_rect_select_mode = function() {
      var not_clicked_yet = true;
      var is_moved = false;
      var start_position = null;
      var end_position = null;
      var resetCursor = function() {
        $("#novel-list tbody, #rect-select-area")
          .css("cursor", select_mode == "rect" ? "crosshair" : "pointer");
      };
      resetCursor();
      $("body").on("mousedown", function(e) {
        var _pos = get_event_position(e);
        var mousedowned_element = $.elementFromPoint(_pos);
        if (!mousedowned_element || mousedowned_element.closest("#novel-list tbody").length === 0)
          return;

        // 右クリックは無視（contextmenu イベント内で個別メニューを表示する）
        if (e.which == 3)
          return;

        e.preventDefault();
        e.stopPropagation();
        var self = this;
        var moving_count = 0;
        var finish_selecting_proc = function() {
          $(self).off("mousemove mouseup");
          not_clicked_yet = true;
          is_moved = false;
          Narou.popupMenu("#rect-select-menu", end_position, close_rect_select_menu_handler);
          resetCursor();
        };
        var mouse_up_when_mode_hybrid_proc = function() {
          mousedowned_element.parents("tr").toggleClass("selected");
          $(self).off("mousemove mouseup");
          not_clicked_yet = true;
          is_moved = false;
          table.fireChangeSelect();
          $("#rect-select-menu").hide();
          selected_rect_element.hide();
        };
        if (not_clicked_yet) {
          // 範囲選択開始
          $("#rect-select-menu").hide();
          context_menu.close();
          unregister_close_handler();
          not_clicked_yet = false;
          start_position = _pos;
          start_element = mousedowned_element;
          $(self).on("mousemove", function(e) {
            moving_count++;
            if (select_mode == "hybrid" && moving_count < 10) {
              // 範囲選択化への遊び。多少動かした程度はクリックとみなす
              return;
            }
            is_moved = true;
            selected_rect_element.show();
            $("#novel-list tbody, #rect-select-area").css("cursor", "crosshair");
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
            else if (select_mode == "hybrid") {
              mouse_up_when_mode_hybrid_proc();
            }
          });
          selected_rect_element.css({
            left: start_position.x,
            top: start_position.y,
            width: 1, height: 1
          });
        }
        else {
          finish_selecting_proc();
        }
      });
    }
  }

  function restore_select_mode() {
    if (select_mode === "single")
      enable_single_select_mode();
    else
      enable_rect_select_mode();
    $("#action-select-mode-" + select_mode).addClass("active");
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
  $("#action-view-nonfrozen").on(click_event_name, function(e) {
    e.preventDefault();
    slideNavbar.slide();
    $(this).toggleClass("active");
    toggleVisibilityNonFrozen();
    saveVisibilityFrozen();
    table.draw();
  });

  /*
   * メニュー
   *   表示＞凍結中を表示
   */
  $("#action-view-frozen").on(click_event_name, function(e) {
    e.preventDefault();
    slideNavbar.slide();
    $(this).toggleClass("active");
    toggleVisibilityFrozen();
    saveVisibilityFrozen();
    table.draw();
  });

  /*
   * メニュー
   *   表示＞変換設定ページは新規タブで開く
   */
  $("#action-view-toggle-setting-page-open-new-tab").on(click_event_name, function(e) {
    e.preventDefault();
    slideNavbar.slide();
    $(this).toggleClass("active");
    var open_new_tab = storage.get("open_new_tab_setting_pages");
    storage.set("open_new_tab_setting_pages", !open_new_tab);
    storage.save();
  });

  /*
   * メニュー
   *   表示＞ボタンを画面下部に固定
   */
  $("#action-view-toggle-buttons-fix-footer").on(click_event_name, function(e) {
    e.preventDefault();
    slideNavbar.slide();
    $(this).toggleClass("active");
    fixed_buttons = !storage.get("buttons_fix_footer");
    storage.set("buttons_fix_footer", fixed_buttons);
    storage.save();
    if (fixed_buttons)
      fix_buttons_to_footer();
    else
      cancel_fix_buttons();
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
   *   ツール > D&Dウィンドウを開く
   */
  $("#action-tool-open-dnd-window").on(click_event_name, function(e) {
    e.preventDefault();
    slideNavbar.slide();
    window.open("/widget/drag_and_drop", "widget_window",
                "width=400,height=350,menubar=no,toolbar=no,scrollbars=no,resizable=yes");
  });

  /*
   * メニュー
   *   ツール > CSV形式でリストをダウンロード
   */
  $("#action-tool-csv-download").on(click_event_name, function(e) {
    e.preventDefault();
    slideNavbar.slide();
    location.href = "/api/csv/download"
  });

  /*
   * メニュー
   *   ツール > CSVファイルからインポート
   */
  $("#action-tool-csv-import").on(click_event_name, function(e) {
    e.preventDefault();
    slideNavbar.slide();
    action.csvImport();
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
   *   オプション＞サーバを再起動
   */
  $("#action-option-server-reboot").on(click_event_name, function(e) {
    e.preventDefault();
    slideNavbar.slide();
    action.rebootDialog();
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
      message: "<p>Narou.rb WEB UI サーバをシャットダウンします。<br>" +
               "シャットダウンすると再度立ち上げるまではアクセスは出来なくなります。<br>" +
               "再度立ち上げるにはコンソールでもう一度 <kbd>narou web</kbd> を実行して下さい。</p>" +
               "<p class=text-danger>アップデート中や変換中の小説がある場合は中断されます。<br>" +
               "終わったかどうか確認しましょう。</p>",
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

  // tooltip() にハッシュで設定を渡すと、DOMに設定されているdata-placementなどの
  // 値が無視されてしまうため、デフォルト値を変更しておく
  _.merge($.fn.tooltip.Constructor.DEFAULTS, {
    animation: false,
    container: "body",
    placement: "bottom"
  });

  function refreshTooltop(id, title, placement) {
    $(id)
      .tooltip("destroy")
      .tooltip({ title: title, placement: placement })
      .on("shown.bs.tooltip", function(e) {
        setTimeout(function() {
          $(e.target).tooltip("hide");
        }, 3500);
      });
  }

  /*
   * 「選択」メニューの横に現在選択中の小説数をバッジで表示
   */
  var register_badge_number_of_selecting = function(table) {
    table.on("changeselect", function() {
      var selected_count = table.rows(".selected").data().length;
      $("#badge-number-of-selecting").text(selected_count);
      if (selected_count > 0) {
        refreshTooltop("#button-update", "選択した小説を更新");
        refreshTooltop("#button-send", "選択した小説を送信");
        enable_menu_item(".enable-selected");
      }
      else {
        refreshTooltop("#button-update", "すべての小説を更新");
        refreshTooltop("#button-send", "更新された小説を送信");
        disable_menu_item(".enable-selected");
      }
    });
  };
  register_badge_number_of_selecting(table);

  /*
   * Tooltip 化
   */
  refreshTooltop("[data-toggle=tooltip]");

  $("button").on("mouseleave", function() {
    $(this).tooltip("hide");
  });

  /*
   * ボタンを一時的に非アクティブ化
   */
  function disableButtonMoment($button) {
    $button.blur();
    $button.tooltip("hide");
    $button.prop("disabled", true);
    // 少したったらアクティブに戻す
    setTimeout(function() {
      $button.prop("disabled", false);
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
   *   Update > 表示されている小説を更新
   */
  $("#button-update-view").on("click", function(e) {
    e.preventDefault();
    action.updateView();
  });

  /*
   * ボタン
   *   Update > 最新話掲載日を更新
   */
  $("#button-update-general-lastup").on("click", function(e) {
    e.preventDefault();
    action.updateGeneralLastup();
  });

  /*
   * ボタン
   *   Update > 凍結済みも更新
   */
  $("#button-update-force").on("click", function(e) {
    e.preventDefault();
    action.updateForce();
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
   *   Send > hotnentry を送信
   */
  $("#button-send-hotentry").on("click", function(e) {
    e.preventDefault();
    action.send("hotentry");
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
   * ボタン
   *   Other > 選択した小説の設定の未設定項目に共通設定を焼付ける
   */
  $("#button-setting-burn").on("click", function(e) {
    e.preventDefault();
    action.settingBurn();
  });

  /*
   * アイコン
   *   ○件表示の横のリロードアイコン
   */
  $("#icon-refresh-table").on("click", function(e) {
    notification.trigger("table.reload");
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
      if (!context_menu.closed) {
        context_menu.close();
      }
      else {
        action.selectClear();
      }
    });
    add("S", function() { $("#action-select-mode-single").trigger("click"); });
    add("R", function() { $("#action-select-mode-rect").trigger("click"); });
    add("H", function() { $("#action-select-mode-hybrid").trigger("click"); });
  };
  if (!touchable_device) {
    initialize_shortcut();
  }

  /*
   * disabled なメニューは何もしないように
   */
  function disable_menu_item(selector) {
    var $element = $(selector);
    $element.each(function(i, dom) {
      if (dom.tagName.toLowerCase() == "button")
        $(dom).prop("disabled", true);
      else
        $(dom).addClass("disabled");
    });
  }

  function enable_menu_item(selector) {
    var $element = $(selector);
    $element.each(function(i, dom) {
      if (dom.tagName.toLowerCase() == "button")
        $(dom).prop("disabled", false);
      else
        $(dom).removeClass("disabled");
    });
  }

  disable_menu_item(".navbar li.disabled");
});

