# frozen_string_literal: true

#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../narou_logger"
require_relative "../inventory"
require_relative "../novelsetting"
require_relative "../eventable"
require_relative "update"

module Command
  class Setting < CommandBase
    include Narou::Eventable

    class InvalidSelectValue < StandardError; end

    def self.oneline_help
      "各コマンドの設定を変更します"
    end

    def initialize
      super "[<name>=<value> ...] [options]\n" \
            "--burn <target> [<target2> ...]"
      @opt.separator <<-EOS

  ・各コマンドの設定の変更が出来ます。
  ・Global な設定はユーザープロファイルに保存され、すべての narou コマンドで使われます
  ・下の一覧は一部です。すべてを確認するには -a オプションを付けて確認して下さい
  ・default. で始まる設定は、setting.ini で未設定時の項目の挙動を指定することが出来ます
  ・force. で始まる設定は、setting.ini や default.* 等の指定を全て無視して項目の挙動を強制出来ます

  Local Variable List:
        <name>           <value>              説明
      EOS
      @opt.separator(get_variable_list_strings(:local))

      @opt.separator("\n  Global Variable List:")
      @opt.separator(get_variable_list_strings(:global))

      @opt.separator <<-EOS

    これ以外にも設定出来る項目があります。確認する場合は
    narou setting -a コマンドを参照して下さい

  Examples:
    narou setting --list                 # 現在の設置値一覧を表示
    narou setting convert.no-open=true   # 値を設定する
    narou setting convert.no-epub=       # 右辺に何も書かないとその設定を削除出来る
    narou setting device                 # 変数名だけ書くと現在の値を確認出来る

    narou s convert.copy-to=C:/dropbox/mobi
    # パスにスペースが含まれる場合はダブルクウォーテーションで囲う
    narou s convert.copy-to="C:\\Documents and Settings\\user\\epub"

  Options:
      EOS
      @opt.on("-l", "--list", "現在の設定値を確認する") {
        output_setting_list
        exit 0
      }
      @opt.on("-a", "--all", "設定できる全ての変数名を表示する") {
        @options["all"] = true
        display_variable_list
        exit 0
      }
      @opt.on("--burn", "指定した小説の未設定項目に共通設定を焼き付ける") {
        @options["burn"] = true
      }
    end

    def get_scope_of_variable_name(name)
      [:local, :global].each do |scope|
        if SETTING_VARIABLES[scope].include?(name)
          return scope
        end
      end
      nil
    end

    #
    # 値の文字列を設定に基づいた型にキャストして、[scope, value] 形式で返す
    # 不正な設定名もしくは値の場合は例外を吐く
    #
    def casting_variable(name, value)
      scope = get_scope_of_variable_name(name)
      unless scope
        raise Helper::InvalidVariableName, "#{name} は不明な名前です"
      end
      variable_definition = SETTING_VARIABLES[scope][name]
      case variable_definition[:type]
      when :select
        select_values = variable_definition[:select_keys]
        unless select_values.include?(value)
          raise InvalidSelectValue, "不明な値です。#{select_values.join(", ")} の中から指定して下さい"
        end
        casted_value = value
      when :multiple
        select_values = variable_definition[:select_keys]
        value.split(",").each do |input_value|
          unless select_values.include?(input_value)
            raise InvalidSelectValue, "不明な値です。#{select_values.join(", ")} の中から指定して下さい"
          end
        end
        casted_value = value
      else
        casted_value = Helper.string_cast_to_type(value, variable_definition[:type])
      end
      [scope, casted_value]
    end

    def output_setting_list
      settings = {
        local: Inventory.load("local_setting", :local),
        global: Inventory.load("global_setting", :global)
      }
      settings.each do |scope, scoped_settings|
        stream_io.puts "[#{scope.capitalize} Variables]"
        scoped_settings.each do |name, value|
          if value =~ / /
            value = "'#{value}'"
          end
          stream_io.puts "<bold><green>#{name}</green></bold>=#{value}".termcolor
        end
      end
    end

    def output_error(msg, name = nil)
      @error_count += 1
      stream_io.error msg
      trigger(:error, msg, name)
    end

    def sweep_dust_variable(target_name, settings)
      deleted = false
      settings.each_value do |scoped_settings|
        if scoped_settings.has_key?(target_name)
          scoped_settings.delete(target_name)
          deleted = true
        end
      end
      deleted
    end

    def output_value(name, settings)
      scope = get_scope_of_variable_name(name)
      if scope
        stream_io.puts settings[scope][name]
      else
        output_error("#{name} という変数は存在しません", name)
      end
    end

    def execute(argv)
      super
      if @options["burn"]
        burn_default_settings(argv)
        return
      end
      display_help! if argv.empty?
      settings = {
        local: Inventory.load("local_setting", :local),
        global: Inventory.load("global_setting", :global)
      }
      device = Narou.get_device
      @error_count = 0
      self.extend(device.get_hook_module) if device
      argv.each do |arg|
        name, value = arg.split("=", 2).map(&:strip)
        if name == ""
          output_error("書式が間違っています。変数名=値 のように書いて下さい")
          next
        end
        if value.nil?
          output_value(name, settings)
          next
        end
        scope = get_scope_of_variable_name(name)
        unless scope
          if value == ""
            # 定義上ではすでに存在しないが、設定ファイルには残っている古い変数
            # を削除できるようにする
            if sweep_dust_variable(name, settings)
              stream_io.puts "#{name} の設定を削除しました"
            else
              output_error("#{name} という変数は存在しません", name)
            end
          else
            output_error("#{name} という変数は設定出来ません", name)
          end
          next
        end
        if value == ""
          hook_call(:modify_settings, settings[scope], name, nil)
          next
        end
        begin
          scope, casted_value = casting_variable(name, value)
        rescue Helper::InvalidVariableName, Helper::InvalidVariableType, InvalidSelectValue => e
          output_error(e.message, name)
          next
        end
        hook_call(:modify_settings, settings[scope], name, casted_value)
      end
      settings[:local].save
      settings[:global].save
      exit @error_count if @error_count > 0
    end

    def modify_settings(scoped_settings, name, value)
      if value.nil?
        scoped_settings.delete(name)
        stream_io.puts "#{name} の設定を削除しました"
      else
        scoped_settings[name] = value
        stream_io.puts "#{name} を #{value} に設定しました"
      end
      if name == "device" && value
        modify_settings_when_device_changed(scoped_settings)
      end
    end

    def modify_settings_when_device_changed(settings)
      device = Device.create(settings["device"])
      message = StringIO.new
      device.get_relative_variables.each do |name, value|
        if value.nil?
          settings.delete(name)
          message.puts "  <bold><red>← #{name} が削除されました</red></bold>".termcolor
        elsif settings[name].nil? || settings[name] != value
          settings[name] = value
          message.puts "  <bold><green>→ #{name} が #{value} に変更されました</green></bold>".termcolor
        end
      end
      if message.length > 0
        stream_io.puts "端末を#{device.display_name}に指定したことで、以下の関連設定が変更されました"
        stream_io.puts message.string
      end
    rescue Device::UnknownDevice => e
      output_error("#{e.message}\n設定できるのは #{Device::DEVICES.keys.join(", ")} です", "device")
    end

    def get_variable_list_strings(scope)
      result = +""
      SETTING_VARIABLES[scope].each do |name, info|
        if @options["all"] || !info[:invisible]
          raise "変数名「#{name}」のtypeが未設定です" unless info[:type]
          type_description = Helper.variable_type_to_description(info[:type])
          result << "    <bold><green>#{name.ljust(18)}</green></bold> #{type_description} #{info[:help]}\n".termcolor
        end
      end
      result
    end

    def display_variable_list
      stream_io.puts "Local Variable List:"
      stream_io.puts get_variable_list_strings(:local).gsub(/^ {4}/, "")
      stream_io.puts
      stream_io.puts "Global Variable List:"
      stream_io.puts get_variable_list_strings(:global).gsub(/^ {4}/, "")
    end

    #
    # 小説の setting.ini の未設定項目に共通設定を焼き付ける
    #
    # default.* が設定されているならそれを、なければオリジナル設定を
    #
    def burn_default_settings(argv)
      if argv.empty?
        error "対象小説を指定して下さい"
        exit Narou::EXIT_ERROR_CODE
      end
      msg = "指定された小説のsetting.iniの未項目設定に共通設定を焼き付けます。\n" \
            "(共通設定とはsetting.iniの項目が未設定時に使用される default.* 系設定およびNarou.rbオリジナル設定のこと)\n" \
            "よろしいですか"
      return unless Narou::Input.confirm(msg)

      tagname_to_ids(argv)
      argv.each do |arg|
        data = Downloader.get_data_by_target(arg)
        unless data
          error "#{arg} は存在しません"
          next
        end
        novel_setting = NovelSetting.new(arg, true, true)    # 空っぽの設定を作成
        novel_setting.settings = novel_setting.load_setting_ini["global"]
        original_settings = NovelSetting.get_original_settings
        default_settings = NovelSetting.load_default_settings

        original_settings.each do |original|
          name = original[:name]
          unless novel_setting.settings.include?(name)
            if default_settings.include?(name)
              novel_setting[name] = default_settings[name]
            else
              novel_setting[name] = original[:value]
            end
          end
        end

        novel_setting.save_settings
        stream_io.puts "#{data["title"]} の設定を保存しました"
      end
    end

    def self.get_setting_variables
      SETTING_VARIABLES
    end

    def self.get_setting_tab_names
      SETTING_TAB_NAMES
    end

    def self.get_setting_tab_info
      SETTING_TAB_INFO
    end

    SETTING_TAB_NAMES = {
      general: "一般",
      detail: "詳細",
      webui: "WEB UI",
      global: "Global",
      default: "default.*",
      force: "force.*",
      command: "コマンド",
    }

    SETTING_TAB_INFO = {
      webui: "WEB UI 専用の設定です",
      global: "Global な設定はユーザープロファイルに保存され、すべての narou コマンドで使われます",
      default: "default.* 系の設定は個別の変換設定で未設定の項目の挙動を指定することが出来ます",
      force: "force.* 系の設定は個別設定、default.* 等の設定を無視して反映されるようになります",
      command: "default_args.* 系の設定は、各種コマンドのオプションを省略した場合に使用されるオプションを指定出来ます",
    }

    SETTING_VARIABLES = {
      local: {
        # 変数名 => { type: 受け付ける型, help: 説明[, invisible: 不可視化フラグ,
        #             select_keys: 選択肢型の時のキー(配列),
        #             select_summaries: 選択肢型の時のキーの概要(配列)] }
        "device" => {
          type: :select,
          help: "変換、送信対象の端末(sendの--help参照)",
          select_keys: Device::DEVICES.keys,
          select_summaries: Device::DEVICES.values.map { |d| d::DISPLAY_NAME },
          tab: :general
        },
        "hotentry" => {
          type: :boolean, help: "新着投稿だけをまとめたデータを作る",
          tab: :general
        },
        "hotentry.auto-mail" => {
          type: :boolean, help: "hotentryをメールで送る(mail設定済みの場合)",
          tab: :detail
        },
        "concurrency" => {
          help: "ダウンロードと変換の同時実行を有効にする。有効にするとログの出力方式が変更される。※β版",
          type: :boolean,
          tab: :general
        },
        "concurrency.format-queue-text" => {
          help: "同時実行時の変換キュー表示テキストのフォーマット。CUI専用。" \
                "デフォルトは #{Narou::ConcurrencyDefaultLogger::FORMAT_TEXT.inspect.escape}",
          type: :string
        },
        "concurrency.format-queue-style" => {
          help: "同時実行時の変換キュー表示スタイルのフォーマット。CUI専用。" \
                "デフォルトは #{Narou::ConcurrencyDefaultLogger::FORMAT_STYLE.inspect.escape}。" \
                "left:右寄せする場合に必要な幅。text:表示テキスト。space:半角スペース",
          type: :string
        },
        "logging" => {
          help: "ログの保存を有効にする。保存場所は#{Narou.log_dir&.basename}フォルダ。concurrencyが有効な場合、変換ログだけ別ファイルに出力される",
          type: :boolean,
          tab: :general
        },
        "logging.format-filename" => {
          help: "ログファイル名のフォーマット。デフォルトは\"#{Narou::LoggerModule::LOG_FORMAT_FILENAME}\" 。" \
                "日付でファイルを分けたくなければ固定ファイル名にする。書式は http://bit.ly/date_format 参照",
          type: :string,
          tab: :detail
        },
        "logging.format-timestamp" => {
          help: "ログ内のタイムスタンプのフォーマット。デフォルトは\"#{Narou::LoggerModule::LOG_FORMAT_TIMESTAMP}\"。タイムスタンプを記録したくなければ $none とだけ入力",
          type: :string,
          tab: :detail
        },
        "update.interval" => {
          type: :float, help: "更新時に各作品間で指定した秒数待機する(処理時間を含む)。最低#{Update::Interval::MIN}秒以上",
          tab: :general
        },
        "update.strong" => {
          type: :boolean, help: "改稿日当日の連続更新でも更新漏れが起きないように、中身もチェックして更新を検知する(やや処理が重くなる)",
          tab: :general
        },
        "update.convert-only-new-arrival" => {
          type: :boolean, help: "更新時に新着のみ変換を実行する",
          tab: :general
        },
        "update.sort-by" => {
          type: :select,
          help: "アップデートを指定した項目順で行う\n#{Narou.update_sort_key_summaries(40)}",
          select_keys: Narou::UPDATE_SORT_KEYS.keys,
          select_summaries: Narou::UPDATE_SORT_KEYS.values,
          tab: :general
        },
        "convert.copy-to" => {
          type: :directory,
          help: "変換したらこのフォルダにコピーする\n" \
                "      ※注意：存在しないフォルダだとエラーになる",
          tab: :general
        },
        "convert.copy-to-grouping" => {
          type: :multiple,
          help: "copy-toで指定したフォルダの中で更に指定の各種フォルダにまとめる",
          select_keys: %w(device site),
          select_summaries: %w(端末毎にまとめる 掲載サイト毎にまとめる),
          tab: :general
        },
        "convert.copy_to" => {
          type: :directory, help: "copy-toの昔の書き方(非推奨)", invisible: true
        },
        "convert.no-epub" => {
          type: :boolean, help: "EPUB変換を無効にする", invisible: true
        },
        "convert.no-mobi" => {
          type: :boolean, help: "MOBI変換を無効にする", invisible: true
        },
        "convert.no-strip" => {
          type: :boolean,
          help: "MOBIのstripを無効にする\n" \
                "      ※注意：KDP用のMOBIはstripしないでください",
          invisible: true
        },
        "convert.no-zip" => {
          type: :boolean, help: "i文庫用のzipファイル作成を無効にする", invisible: true
        },
        "convert.no-open" => {
          type: :boolean, help: "変換時に保存フォルダを開かないようにする",
          tab: :general
        },
        "convert.inspect" => {
          type: :boolean, help: "常に変換時に調査結果を表示する",
          tab: :detail
        },
        "convert.multi-device" => {
          type: :multiple,
          help: "複数の端末用に同時に変換する。deviceよりも優先される。" \
                "端末名をカンマ区切りで入力。ただのEPUBを出力したい場合はepubを指定",
          select_keys: Device::DEVICES.keys,
          select_summaries: Device::DEVICES.values.map { |d| d::DISPLAY_NAME },
          tab: :general
        },
        "convert.filename-to-ncode" => {
          type: :boolean, help: "書籍ファイル名をNコードで出力する(ドメイン_Nコードの形式)",
          tab: :general
        },
        "download.interval" => {
          type: :float, help: "各話DL時に指定秒数待機する。デフォルト#{Downloader::DEFAULT_INTERVAL_WAIT}秒",
          tab: :detail
        },
        "download.wait-steps" => {
          type: :integer,
          help: "指定した話数ごとに長めのウェイトが入る\n" \
                "      ※注意：11以上を設定してもなろうの場合は10話ごとにウェイトが入ります",
          tab: :detail
        },
        "download.use-subdirectory" => {
          type: :boolean,
          help: "小説を一定数ごとにサブフォルダへ分けて保存する\n" \
                "      ※注意：小説を大量に同一フォルダに保存するとパフォーマンスが劣化する回避策",
          tab: :detail
        },
        "download.choices-of-digest-options" => {
          type: :string,
          help: "ダイジェスト化選択肢が出た場合に、自動で項目を選択する。" \
                "カンマ区切りで選択したい順番に数字で記入する。" \
                "最終的に更新かキャンセルが選択されなかった場合はキャンセル扱いになる\n" \
                "#{Downloader.choices_to_string(width: 27)}",
          tab: :detail
        },
        "send.without-freeze" => {
          type: :boolean, help: "送信時に凍結された小説は対象外にする",
          tab: :general
        },
        "send.backup-bookmark" => {
          type: :boolean, help: "一括送信時に栞データを自動でバックアップする(KindlePW系用)",
          tab: :detail
        },
        "multiple-delimiter" => {
          type: :string, help:  "--multiple指定時の区切り文字",
          tab: :detail
        },
        "filename-length-limit" => {
          type: :integer, help:  "ファイル名の長さを制限する。ファイル名の長さでエラーが出ない限り基本的にはいじらないこと。デフォルトは#{Helper::FILENAME_LENGTH_LIMIT}文字",
          tab: :detail
        },
        "economy" => {
          type: :multiple,
          help: "容量節約に関する設定。カンマ区切りで設定\n" \
                "(cleanup_temp:変換後に作業ファイルを削除 send_delete:送信後に書籍ファイルを削除 " \
                "nosave_diff:差分ファイルを保存しない nosave_raw:rawデータを保存しない)",
          select_keys: %w(cleanup_temp send_delete nosave_diff nosave_raw),
          select_summaries: %w(変換後に作業ファイルを削除 送信後に書籍ファイルを削除
                               差分ファイルを保存しない rawデータを保存しない),
          tab: :detail
        },
        "guard-spoiler" => {
          type: :boolean,
          help: "ネタバレ防止機能。ダウンロード時の各話タイトルを伏せ字で表示する",
          tab: :detail
        },
        "normalize-filename" => {
          type: :boolean, help: "ファイル名の文字列をNFCで正規化する。※既存データとの互換性が無くなる可能性があるので、バックアップを取った上で機能を理解の上有効にして下さい",
          tab: :detail,
        },
        "webui.theme" => {
          type: :select, help: "WEB UI 用テーマ選択",
          invisible: true,
          select_keys: Narou.get_theme_names,
          select_summaries: Narou.get_theme_names,
          tab: :webui
        },
        "webui.table.reload-timing" => {
          type: :select, help: "小説リストの更新タイミングを選択。未設定時は１作品ごとに更新",
          invisible: true,
          select_keys: %w(every queue),
          select_summaries: %w(
            １作品ごとに更新
            キューごとに更新
          ),
          tab: :webui
        },
      },
      global: {
        "aozoraepub3dir" => {
          type: :directory, help: "AozoraEpub3のあるフォルダを指定", invisible: true
        },
        "line-height" => {
          type: :float, help: "行間サイズ(narou init から指定しないと反映されません)", invisible: true
        },
        "difftool" => {
          type: :string, help: "diffで使うツールのパスを指定する",
          tab: :global
        },
        "difftool.arg" => {
          type: :string, help: "difftoolで使う引数を設定(オプション)",
          tab: :global
        },
        "no-color" => {
          type: :boolean, help: "カラー表示を無効にする",
          tab: :global
        },
        "color-parser" => {
          type: :select,
          help: "コンソール上でのANSIカラーを表示する方法の選択(Windowsのみ)。" \
                "system: システムに任せる(デフォルト) / self: Narou.rbで処理",
          select_keys: %w(system self),
          select_summaries: %w(システムに任せる Narou.rbで処理),
          tab: :global
        },
        "server-port" => {
          type: :integer, help: "WEBサーバ起動時のポート。server-port + 1 のポートも WebSocket で使用",
          tab: :global
        },
        "server-bind" => {
          type: :string, help: "WEBサーバのホスト制限(未設定時:起動PCのIP)。頻繁にローカルIPが変わってしまう場合は127.0.0.1の指定を推奨",
          invisible: true,
          tab: :global
        },
        "server-digest-auth.enable" => {
          type: :boolean, help: "WEBサーバでDigest認証を使用するかどうか",
          invisible: true,
          tab: :global
        },
        "server-digest-auth.user" => {
          type: :string, help: "WEBサーバでDigest認証をするユーザ名",
          invisible: true,
          tab: :global
        },
        "server-digest-auth.password" => {
          type: :string, help: "WEBサーバのDigest認証のパスワード。hashed-passwordも設定した場合はそちらが優先される",
          invisible: true,
          tab: :global
        },
        "server-digest-auth.hashed-password" => {
          type: :string,
          help: "WEBサーバのDigest認証のパスワードを、Realmを\"narou.rb\"としてハッシュにしたもの。下記のようなコマンドで生成できる\n" \
                "$ ruby -r 'digest/md5' -e 'puts Digest::MD5.hexdigest \"\#{$*[0]}:narou.rb:\#{$*[1]}\"' user password",
          invisible: true,
          tab: :global
        },
        "server-ws-add-accepted-domains" => {
          type: :string, help: "PushServer の accepted_domains に追加するホストのリスト（カンマ区切り）",
          invisible: true,
          tab: :global
        },
        "over18" => {
          type: :boolean, help: "18歳以上かどうか", invisible: true,
          tab: :global
        },
      }
    }

    %w(default force).each do |kind|
      NovelSetting::ORIGINAL_SETTINGS.each do |default|
        value = {
          type: default[:type],
          help: "\n      " + default[:help],
          invisible: true,
          select_keys: default[:select_keys],
          select_summaries: default[:select_summaries],
          tab: kind.intern
        }
        SETTING_VARIABLES[:local]["#{kind}." + default[:name]] = value
      end
    end

    Dir.glob(File.expand_path(File.join(File.dirname(__FILE__), "*.rb"))) do |path|
      cmd_name = File.basename(path, ".rb")
      SETTING_VARIABLES[:local]["default_args." + cmd_name] = {
        type: :string, help: "#{cmd_name} コマンドのデフォルトオプション", invisible: true,
        tab: :command
      }
    end

    SETTING_VARIABLES.freeze
  end
end
