# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

# rubocop:disable Metrics/ClassLength
# rubocop:disable Style/ClassAndModuleChildren

require "socket"
require "sinatra/base"
require "sinatra/json"
require "sinatra/reloader" if $development
require "better_errors" if $debug
require "tilt/erubis"
require "tilt/haml"
require "tilt/sass"
require_relative "../logger"
require_relative "../commandline"
require_relative "../inventory"
require_relative "worker"
require_relative "pushserver"
require_relative "settingmessages"

module Narou::ServerHelpers
  #
  # タグをHTMLで装飾する
  #
  def decorate_tags(tags)
    tags.sort.map do |tag|
      %!<span class="tag label label-#{Command::Tag.get_color(tag)}" data-tag="#{escape_html(tag)}">#{escape_html(tag)}</span>!
    end.join(" ")
  end

  #
  # タグをHTMLで装飾する(除外タグ指定用)
  #
  def decorate_exclusion_tags(tags)
    tags.sort.map do |tag|
      %!<span class="tag label label-#{Command::Tag.get_color(tag)}" data-exclusion-tag="#{escape_html(tag)}">^tag:#{escape_html(tag)}</span>!
    end.join(" ")
  end

  #
  # Rubyバージョンを構築
  #
  def build_ruby_version
    begin
      `"#{RbConfig.ruby}" -v`.strip
    rescue
      config = RbConfig::CONFIG
      "ruby #{RUBY_VERSION}p#{config["PATCHLEVEL"]} [#{RUBY_PLATFORM}]"
    end
  end

  #
  # 有効な novel ID だけの配列を生成する
  # ID が指定されなかったか、１件も存在しない場合は nil を返す
  #
  def select_valid_novel_ids(ids)
    return nil unless ids.kind_of?(Array)
    result = ids.select do |id|
      id =~ /^\d+$/
    end
    result.empty? ? nil : result
  end

  #
  # フォーム情報の真偽値データを実際のデータに変換
  #
  def convert_on_off_to_boolean(str)
    case str
    when "on"
      true
    when "off"
      false
    else
      nil
    end
  end

  #
  # nil true false を nil on off という文字列に変換
  #
  def convert_boolean_to_on_off(bool)
    case bool
    when TrueClass
      "on"
    when FalseClass
      "off"
    else
      "nil"
    end
  end

  #
  # HTMLエスケープヘルパー
  #
  def h(text)
    Rack::Utils.escape_html(text)
  end

  #
  # 与えられたデータが真偽値だった場合、設定画面用に「はい」「いいえ」に変換する
  # 真偽値ではなかった場合、そのまま返す
  #
  def value_to_msg(value)
    case value
    when TrueClass
      "はい"
    when FalseClass
      "いいえ"
    else
      value
    end
  end

  def notepad_text_path
    File.join(Narou.local_setting_dir, "notepad.txt")
  end

  def query_to_boolean(value, default: false)
    case value
    when "1", 1, "true", true
      true
    when "0", 0, "false", false
      false
    else
      default
    end
  end
end

class Narou::AppServer < Sinatra::Base
  register Sinatra::Reloader if $development
  helpers Narou::ServerHelpers

  @@request_reboot = false
  @@already_update_system = false
  @@gem_update_last_log = ""

  configure do
    set :app_file, __FILE__
    set :erb, trim: "-"
    enable :protection
    enable :sessions

    set(:version) do
      Command::Version.create_version_string
    end

    set :environment, :production unless $development
    set :server, :webrick

    if $debug
      use BetterErrors::Middleware
      BetterErrors.application_root = Narou.get_script_dir
    end
  end

  def self.push_server=(server)
    @@push_server = server
  end

  def self.push_server
    @@push_server
  end

  def self.request_reboot
    @@request_reboot = true
  end

  def self.request_reboot?
    @@request_reboot
  end

  #
  # サーバのアドレスを生成
  #
  # portは初回起動時にランダムで設定する。次回からは同じ設定を引き継ぐ。
  # bindは自分で設定する場合は narou s server-bind=address で行う。
  # bindは設定しなかった場合は起動したPCのプライベートIPアドレスが設定される。
  # この場合はLAN内からアクセス出来る。
  # bindがlocalhostの場合は実際には127.0.0.1で処理される。(起動したPCでしか
  # アクセス出来ない)
  # 0.0.0.0 を指定した場合はアクセスに制限がかからない（外部からアクセス可能）
  # セキュリティ上オススメ出来ない。
  #
  def self.create_address(user_port = nil)
    global_setting = Inventory.load("global_setting", :global)
    port, bind = global_setting["server-port"], global_setting["server-bind"]
    port = user_port if user_port
    ipaddress = my_ipaddress
    unless port
      port = rand(4000..65000)
      global_setting["server-port"] = port
      global_setting.save
    end
    bind = "127.0.0.1" if bind == "localhost"
    host = bind ? bind : ipaddress
    set :port, port
    set :bind, host
    {
      host: host,
      port: port
    }
  end

  #
  # 自分のIPアドレス取得
  #
  # 参考：http://qiita.com/saltheads/items/cc49fcf2af37cb277c4f
  #
  def self.my_ipaddress
    @@__ipaddress ||= -> {
      udp = UDPSocket.new
      begin
        # 128.0.0.0 への送信に使用されるNICのアドレスを取得
        udp.connect("128.0.0.0", 7)
        Socket.unpack_sockaddr_in(udp.getsockname)[1]
      rescue Errno::ENETUNREACH
        # 128.0.0.0 へのルーティングがないとき
        "127.0.0.1"
      ensure
        udp.close
      end
    }.call
  end

  def initialize
    super
    puts_hello_messages
    start_device_ejectable_event
    fill_general_all_no_in_database
    setup_server_authentication
  end

  def puts_hello_messages
    puts "<white>Narou.rb version #{::Version}</white>".termcolor
  end

  def start_device_ejectable_event
    return unless Device.support_eject?
    Thread.new do
      loop do
        if @@push_server.connections.count > 0
          device = Narou.get_device
          @@push_server.send_all(:"device.ejectable" => device && device.ejectable?)
        end

        sleep 2
      end
    end
  end

  def general_all_no_by_toc(id)
    toc = Downloader.new(id).load_toc_file
    return nil unless toc
    toc["subtitles"].size
  end

  # 話数の設定されていない小説の話数を取得して埋める
  def fill_general_all_no_in_database
    modified = false
    Database.instance.each do |id, data|
      next if data["general_all_no"]
      data["general_all_no"] = general_all_no_by_toc(id)
      modified = true
    end
    Database.instance.save_database if modified
  end

  # サーバーの認証の設定
  # とりあえずDigest認証のみ
  def setup_server_authentication
    setting = Inventory.load("global_setting", :global)
    return unless setting["server-digest-auth.use"]

    user = setting["server-digest-auth.user"]
    hashed = !!setting["server-digest-auth.hashed-password"]
    passwd = hashed ? setting["server-digest-auth.hashed-password"] : setting["server-digest-auth.password"]

    self.class.class_exec do
      use Rack::Auth::Digest::MD5, { realm: "narou.rb", opaque: "", passwords_hashed: hashed } do |username|
        passwd if username == user
      end
    end
  end

  # ===================================================================
  # ルーティング
  # ===================================================================

  before do
    @bootstrap_theme = case params["theme"]
                       when nil
                         Narou.get_theme
                       when ""   # 環境設定画面で未設定が選択された時
                         nil
                       else
                         params["theme"]
                       end
    Narou::Worker.push_as_system_worker do
      Inventory.clear
      Database.instance.refresh
      Narou.load_global_replace_pattern
    end
  end

  get "/" do
    setting = Inventory.load("server_setting", :global)
    @is_first_access = !setting["already-accessed"]
    if @is_first_access
      setting["already-accessed"] = true
      setting.save
    end
    haml :index, layout: true
  end

  get "/style.css" do
    scss :style
  end

  before "/settings" do
    @title = "環境設定"
    @setting_variables = Command::Setting.get_setting_variables
    @error_list = {}
    @global_replace_pattern = @replace_pattern = Narou.global_replace_pattern
  end

  post "/settings" do
    built_arguments = []
    output = ""
    device = params.delete("device")
    [:local, :global].each do |scope|
      @setting_variables[scope].each do |name, info|
        param_data = params[name]
        argument = ""
        if info[:type] == :boolean
          # :boolean 用のフォームデータは on, off, nil で渡される。
          # ただしチェックボックスはチェックした時だけ on が渡されるので、
          # 何もデータが無い＝off を選択したと判断する。
          # 隠しデータの場合は hidden として on, off, nil が必ず送信されるので、
          # それで判断できる。
          if param_data
            argument = convert_on_off_to_boolean(param_data).to_s
          else
            argument = "false"
          end
        elsif param_data.kind_of?(Array)
          argument = param_data.join(",")
        else
          argument = param_data
        end
        built_arguments << "#{name}=#{argument}"
      end
    end
    # device の項目だけ関連項目を変更するという挙動をするため、変更を上書き
    # されないように最後にまわす
    built_arguments << "device=#{device}" if device
    unless built_arguments.empty?
      $stdout.silence do
        setting = Command::Setting.new
        setting.on(:error) do |msg, name|
          if name
            @error_list[name] = msg
          end
        end
        begin
          setting.execute(built_arguments)
        rescue SystemExit
        end
      end
    end

    # 置換設定保存
    params_replace_pattern = params["replace_pattern"]
    @global_replace_pattern.clear
    if params_replace_pattern.kind_of?(Array)
      params_replace_pattern.each do |pattern|
        left, right = pattern["left"].strip, pattern["right"].strip
        next if left == ""
        @global_replace_pattern << [left, right]
      end
    end
    Narou.save_global_replace_pattern

    if @error_list.empty?
      session[:alert] = [ "保存が完了しました", "success" ]
    else
      session[:alert] = [ "#{@error_list.size}個の設定にエラーがありました", "danger" ]
    end
    haml :settings
  end

  get "/settings" do
    haml :settings
  end

  get "/help" do
    @title = "ヘルプ"
    haml :help
  end

  get "/about" do
    @narourb_version = settings.version
    @ruby_version = build_ruby_version
    haml :_about, layout: false
  end

  post "/shutdown" do
    self.class.quit!
    "シャットダウンしました。再起動するまで操作は出来ません"
  end

  post "/reboot" do
    self.class.request_reboot
    self.class.quit!
    haml :_rebooting, layout: false
  end

  post "/update_system" do
    Thread.new do
      buffer = `gem update --no-document narou`
      @@gem_update_last_log = buffer.strip!
      if buffer =~ /Nothing to update\z/
        @@push_server.send_all("server.update.nothing" => buffer)
      elsif buffer.include?("Gems updated: narou")
        @@already_update_system = true
        @@push_server.send_all("server.update.success" => buffer)
      else
        @@push_server.send_all("server.update.failure" => buffer)
      end
    end
  end

  post "/gem_update_last_log" do
    content_type "text/plain"
    @@gem_update_last_log
  end

  post "/check_already_update_system" do
    json({ result: @@already_update_system })
  end

  before "/novels/:id/*" do
    @id = params[:id]
    not_found unless @id =~ /^\d+$/
    @data = Downloader.get_data_by_target(@id)
    not_found unless @data
  end

  before "/novels/:id/setting" do
    @novel_title = @data["title"]
    @title = "小説の変換設定 - #{h @novel_title}"
    @setting_variables = []
    @error_list = {}
    @novel_setting = NovelSetting.new(@id, true, true)    # 空っぽの設定を作成
    @novel_setting.settings = @novel_setting.load_setting_ini["global"]
    @original_settings = NovelSetting.get_original_settings
    @force_settings = NovelSetting.load_force_settings
    @default_settings = NovelSetting.load_default_settings
    @replace_pattern = @novel_setting.load_replace_pattern
  end

  post "/novels/:id/setting" do
    # 変換設定保存
    @original_settings.each do |info|
      name, type = info[:name], info[:type]
      param_data = params[name]
      value = nil
      begin
        if type == :boolean
          if param_data
            value = convert_on_off_to_boolean(param_data)
          else
            value = false
          end
        elsif param_data.kind_of?(Array)
          value = param_data.join(",")
        else
          if param_data.strip != ""
            value = Helper.string_cast_to_type(param_data, type)
          end
        end
        @novel_setting[name] = value
      rescue Helper::InvalidVariableType => e
        @error_list[name] = e.message
      end
    end
    @novel_setting.save_settings

    # 置換設定保存
    params_replace_pattern = params["replace_pattern"]
    @novel_setting.replace_pattern.clear
    if params_replace_pattern.kind_of?(Array)
      params_replace_pattern.each do |pattern|
        left, right = pattern["left"].strip, pattern["right"].strip
        next if left == ""
        @novel_setting.replace_pattern << [left, right]
      end
    end
    @novel_setting.save_replace_pattern

    if @error_list.empty?
      session[:alert] = [ "保存が完了しました", "success" ]
    else
      session[:alert] = [ "#{@error_list.size}個の設定にエラーがありました", "danger" ]
    end

    haml :"novels/setting"
  end

  get "/novels/:id/setting" do
    haml :"novels/setting"
  end

  get "/novels/:id/download" do
    device = Narou.get_device
    ext = device ? device.ebook_file_ext : ".epub"
    path = Narou.get_ebook_file_path(@id, ext)
    if File.exist?(path)
      send_file(path, filename: File.basename(path), type: "application/octet-stream")
    else
      not_found
    end
  end

  get "/notepad" do
    @title = "メモ帳"
    haml :notepad
  end

  get "/edit_menu" do
    @title = "個別メニューの編集"
    haml :edit_menu
  end

  not_found do
    "not found"
  end

  # -------------------------------------------------------------------------------
  # API's
  # -------------------------------------------------------------------------------

  get "/api/list" do
    view_frozen = query_to_boolean(params["view_frozen"], default: true)
    view_nonfrozen = query_to_boolean(params["view_nonfrozen"], default: true)
    database_values = Database.instance.get_object.values
    json_objects = {
      draw: 1
    }
    json_objects[:data] =
      database_values.map do |data|
        id = data["id"]
        is_frozen = Narou.novel_frozen?(id)
        next nil if !view_frozen && is_frozen
        next nil if !view_nonfrozen && !is_frozen
        tags = data["tags"] || []
        {
          id: id.to_s,
          last_update: data["last_update"].to_i,
          title: escape_html(data["title"]),
          author: escape_html(data["author"]),
          sitename: data["sitename"],
          toc_url: data["toc_url"],
          novel_type: data["novel_type"] == 2 ? "短編" : "連載",
          tags: (tags.empty? ? "" : decorate_tags(tags) + '&nbsp;<span class="tag label label-white" data-tag="" data-toggle="tooltip" title="タグ検索を解除">&nbsp;</span>'),
          status: [
            is_frozen ? "凍結" : nil,
            tags.include?("end") ? "完結" : nil,
            tags.include?("404") ? "削除" : nil,
          ].compact.join(", "),
          download: %!<a href="/novels/#{id}/download" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-download-alt"></span></a>!,
          frozen: is_frozen,
          new_arrivals_date: data["new_arrivals_date"].tap { |m| break m.to_i if m },
          general_lastup: data["general_lastup"].tap { |m| break m.to_i if m },
          # 掲載話数
          general_all_no: data["general_all_no"],
          last_check_date: data["last_check_date"].tap { |m| break m.to_i if m },
        }
      end.compact
    json_objects[:recordsTotal] = json_objects[:data].size
    json_objects[:recordsFiltered] = json_objects[:recordsTotal]
    json json_objects
  end

  post "/api/cancel" do
    Narou::Worker.cancel
  end

  post "/api/convert" do
    ids = select_valid_novel_ids(params["ids"]) or pass
    Narou::Worker.push do
      CommandLine.run!(["convert", "--no-open", ids])
    end
  end

  post "/api/download" do
    targets = params["targets"] or pass
    targets = targets.kind_of?(Array) ? targets : targets.split
    pass if targets.size == 0
    Narou::Worker.push do
      CommandLine.run!(["download"] + targets)
      @@push_server.send_all(:"table.reload")
    end
  end

  post "/api/download_force" do
    ids = select_valid_novel_ids(params["ids"]) or pass
    Narou::Worker.push do
      CommandLine.run!(["download", "--force", ids])
      @@push_server.send_all(:"table.reload")
    end
  end

  post "/api/mail" do
    ids = select_valid_novel_ids(params["ids"]) || []
    Narou::Worker.push do
      CommandLine.run!(["mail", ids])
    end
  end

  post "/api/update" do
    ids = select_valid_novel_ids(params["ids"]) || []
    opt_arguments = []
    if params["force"] == "true"
      opt_arguments << "--force"
    end
    Narou::Worker.push do
      cmd = Command::Update.new
      cmd.on(:success) do
        @@push_server.send_all(:"table.reload")
      end
      cmd.execute!([ids, opt_arguments].flatten)
      @@push_server.send_all(:"table.reload")
    end
  end

  post "/api/update_by_tag" do
    tags = params["tags"] || []
    exclusion_tags = params["exclusion_tags"] || []
    tag_params = tags.map do |tag|
      "tag:#{tag}"
    end
    tag_params += exclusion_tags.map do |tag|
      "^tag:#{tag}"
    end
    pass if tag_params.empty?
    Narou::Worker.push do
      cmd = Command::Update.new
      cmd.on(:success) do
        @@push_server.send_all(:"table.reload")
      end
      cmd.execute!(tag_params)
      @@push_server.send_all(:"table.reload")
    end
  end

  post "/api/send" do
    ids = select_valid_novel_ids(params["ids"]) || []
    Narou::Worker.push do
      CommandLine.run!(["send", ids])
    end
  end

  post "/api/freeze" do
    ids = select_valid_novel_ids(params["ids"]) or pass
    Narou::Worker.push do
      CommandLine.run!(["freeze", ids])
      @@push_server.send_all(:"table.reload")
    end
  end

  post "/api/freeze_on" do
    ids = select_valid_novel_ids(params["ids"]) or pass
    Narou::Worker.push do
      CommandLine.run!(["freeze", "--on", ids])
      @@push_server.send_all(:"table.reload")
    end
  end

  post "/api/freeze_off" do
    ids = select_valid_novel_ids(params["ids"]) or pass
    Narou::Worker.push do
      CommandLine.run!(["freeze", "--off", ids])
      @@push_server.send_all(:"table.reload")
    end
  end

  post "/api/remove" do
    ids = select_valid_novel_ids(params["ids"]) or pass
    opt_arguments = []
    if params["with_file"] == "true"
      opt_arguments << "--with-file"
    end
    Narou::Worker.push do
      CommandLine.run!(["remove", "--yes", ids, opt_arguments])
      @@push_server.send_all(:"table.reload")
    end
  end

  post "/api/remove_with_file" do
    ids = select_valid_novel_ids(params["ids"]) or pass
    Narou::Worker.push do
      CommandLine.run!(["remove", "--yes", "--with-file", ids])
      @@push_server.send_all(:"table.reload")
    end
  end

  post "/api/diff" do
    ids = select_valid_novel_ids(params["ids"]) or pass
    number = params["number"] || "1"
    Narou::Worker.push do
      # diff コマンドは１度に一つのIDしか受け取らないので
      ids.each do |id|
        # セキュリティ的にWEB UIでは独自の差分表示のみ使う
        CommandLine.run!(["diff", "--no-tool", id, "--number", number])
        Helper.print_horizontal_rule
      end
    end
  end

  get "/api/diff_list" do
    target = params["target"] or return ""
    id = Downloader.get_id_by_target(target) or return ""
    @list = Command::Diff.new.get_diff_list(id)
    haml :_diff_list, layout: false
  end

  post "/api/diff_clean" do
    target = params["target"] or pass
    id = Downloader.get_id_by_target(target) or pass
    Narou::Worker.push do
      CommandLine.run!(%W(diff --clean #{id}))
    end
  end

  post "/api/inspect" do
    ids = select_valid_novel_ids(params["ids"]) or pass
    Narou::Worker.push do
      CommandLine.run!(["inspect", ids])
    end
  end

  post "/api/folder" do
    ids = select_valid_novel_ids(params["ids"]) or pass
    CommandLine.run!(["folder", ids])
  end

  post "/api/backup" do
    ids = select_valid_novel_ids(params["ids"]) or pass
    Narou::Worker.push do
      CommandLine.run!(["backup", ids])
    end
  end

  post "/api/clear_history" do
    Narou::PushServer.instance.clear_history
  end

  get "/api/tag_list" do
    result =
      '<div><span class="tag label label-default" data-tag="">タグ検索を解除</span></div>' \
      '<div class="text-muted" style="font-size:10px">Altキーを押しながらで除外検索</div>'
    tagname_list = Command::Tag.get_tag_list.keys
    tagname_list.sort.each do |tagname|
      result << "<div>#{decorate_tags([tagname])} " \
                "<span class='select-color-button' data-target-tag='#{h tagname}'>" \
                "<span class='#{Command::Tag.get_color(tagname)}'>a</span></span></div>"
    end
    result
  end

  get "/api/taginfo.json" do
    ids = select_valid_novel_ids(params["ids"]) or pass
    ids.map!(&:to_i)
    database = Database.instance
    tag_info = {}
    database.each do |_, data|
      tags = data["tags"] || []
      tags.each do |tag|
        tag_info[tag] ||= {
          count: 0,
          tag: tag,
          html: decorate_tags([tag]),
          exclusion_html: params["with_exclusion"] ? decorate_exclusion_tags([tag]) : ""
        }
        if ids.include?(data["id"])
          tag_info[tag][:count] += 1
        end
      end
    end
    json Hash[tag_info.sort_by { |k, v| k }].values
  end

  post "/api/edit_tag" do
    ids = select_valid_novel_ids(params["ids"]) or pass
    # key と value を重複を維持したまま反転
    invert_states = params["states"].inject({}) { |h,(k,v)| (h[v] ||= []) << k; h }
    $stdout.silence do
      invert_states.each do |state, tags|
        case state.to_i
        when 0
          # タグを削除
          CommandLine.run!(["tag", "--delete", tags.join(" "), ids])
        when 1
          # 現状を維持(何もしない)
        when 2
          # タグを追加
          CommandLine.run!(["tag", "--add", tags.join(" "), ids])
        end
      end
    end
    @@push_server.send_all(:"table.reload")
    @@push_server.send_all(:"tag.updateCanvas")
  end

  get "/api/get_queue_size" do
    res = {
      size: Narou::Worker.instance.size
    }
    json res
  end

  post "/api/update_general_lastup" do
    option = params["option"]
    option = nil if option == "all"
    is_update_modified = params["is_update_modified"] == "true"
    Narou::Worker.push do
      CommandLine.run!(["update", "--gl", option].compact)
      @@push_server.send_all(:"table.reload")
      @@push_server.send_all(:"tag.updateCanvas")
      if is_update_modified
        puts "<yellow>#{Narou::MODIFIED_TAG} タグの付いた小説を更新します</yellow>".termcolor
        CommandLine.run!(["update", "tag:#{Narou::MODIFIED_TAG}"])
        @@push_server.send_all(:"table.reload")
        @@push_server.send_all(:"tag.updateCanvas")
      end
    end
  end

  post "/api/setting_burn" do
    ids = select_valid_novel_ids(params["ids"]) or pass
    Narou::Worker.push do
      CommandLine.run!(["setting", "--burn", ids])
    end
  end

  post "/api/change_tag_color" do
    tag = params["tag"] or pass
    color = params["color"] or pass
    tag_colors = Inventory.load("tag_colors")
    tag_colors[tag] = color
    tag_colors.save
    @@push_server.send_all(:"table.reload")
    @@push_server.send_all(:"tag.updateCanvas")
  end

  get "/api/csv/download" do
    content_type "application/csv"
    attachment "novels.csv"

    Command::Csv.new.generate
  end

  post "/api/csv/import" do
    files = params["files"] or pass
    csv = Command::Csv.new
    files.each do |file|
      csv.import(file[:tempfile])
    end
    ""
  end

  # ダウンロード登録すると同時にグレーのボタン画像を返す
  get "/api/download4ie" do
    Narou::Worker.push do
      CommandLine.run!(%W(download #{params["target"]}))
      @@push_server.send_all(:"table.reload")
    end
    redirect "/resources/images/dl_button1.gif"
  end

  get "/api/validate_url_regexp_list" do
    json Downloader.load_settings.map { |setting|
      "(#{setting["url"].gsub(/\?<.+?>/, "?:").gsub("\\", "\\\\")})"
    }
  end

  get "/api/version/current.json" do
    json({ version: ::Version })
  end

  get "/api/version/latest.json" do
    json({ version: Narou.latest_version })
  end

  get "/api/notepad/read" do
    content_type "text/plain"
    if File.exist?(notepad_text_path)
      File.read(notepad_text_path)
    else
      ""
    end
  end

  post "/api/notepad/save" do
    File.write(notepad_text_path, params["text"])
    @@push_server.send_all("notepad.change" => {
      text: params["text"], object_id: params["object_id"]
    })
    ""
  end

  post "/api/eject" do
    do_eject = proc do
      device = Narou.get_device
      device.eject if device
      puts "<bold><green>端末を取り外しました</green></bold>".termcolor
    end
    if params["enqueue"] == "true"
      Narou::Worker.push do
        do_eject.call
      end
    else
      do_eject.call
    end
    ""
  end

  # -------------------------------------------------------------------------------
  # 一部分に表示するためのHTMLを取得する(パーシャル)
  # -------------------------------------------------------------------------------

  get "/partial/csv_import" do
    haml :"partial/csv_import", layout: false
  end

  get "/partial/download_form" do
    haml :"partial/download_form", layout: false
  end

  # -------------------------------------------------------------------------------
  # ウィジット関係
  # -------------------------------------------------------------------------------

  BOOKMARKLET_MODE = %w(download insert_button)

  get "/js/widget.js" do
    if BOOKMARKLET_MODE.include?(params["mode"])
      content_type :js
      erb :"bookmarklet/#{params['mode']}.js"
    else
      error("invaid mode")
    end
  end

  ALLOW_HOSTS = [].tap do |hosts|
    Downloader.load_settings.each do |s|
      hosts << s["domain"]
    end
    hosts.freeze
  end

  before "/widget/*" do
    from = params["from"]
    if ALLOW_HOSTS.include?(from)
      headers "X-Frame-Options" => "ALLOW-FROM http://#{from}/"
    end
  end

  get "/widget/download" do
    target = params["target"] or error("targetを指定して下さい")
    Narou::Worker.push do
      CommandLine.run!(["download", target])
      @@push_server.send_all(:"table.reload")
    end
    haml :"widget/download", layout: nil
  end

  get "/widget/drag_and_drop" do
    haml :"widget/drag_and_drop", layout: nil
  end

  get "/widget/notepad" do
    haml :"widget/notepad", layout: nil
  end
end
