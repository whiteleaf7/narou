# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "socket"
require "sinatra/base"
require "sinatra/json"
if $debug
  require "sinatra/reloader"
  require "pry"
end
require "haml"
require "sass"
require_relative "../logger"
require_relative "../CommandLine"
require_relative "../inventory"
require_relative "worker"
require_relative "pushserver"
require_relative "settingmessages"

module Narou::ServerHelpers
  #
  # タグをHTMLで装飾する
  #
  def decorate_tags(tags)
    tags.map do |tag|
      %!<span class="tag label label-#{Command::Tag.get_color(tag)}" data-tag="#{escape_html(tag)}">#{escape_html(tag)}</span>!
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
  # 与えられたデータが真偽値だった場合、設定画面用に「する」「しない」に変換する
  # 真偽値ではなかった場合、そのまま返す
  #
  def value_to_msg(value)
    case value
    when TrueClass
      "する"
    when FalseClass
      "しない"
    else
      value
    end
  end
end

class Narou::AppServer < Sinatra::Base
  register Sinatra::Reloader if $debug
  helpers Narou::ServerHelpers

  configure do
    set :app_file, __FILE__
    set :erb, trim: "-"
    enable :protection
    enable :sessions

    set(:version) do
      Command::Version.create_version_string
    end
  end

  def self.push_server=(server)
    @@push_server = server
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
      udp.connect("128.0.0.0", 7)
      adrs = Socket.unpack_sockaddr_in(udp.getsockname)[1]
      udp.close
      adrs
    }.call
  end

  # ===================================================================
  # ルーティング
  # ===================================================================

  before do
    Narou::Worker.push_as_system_worker do
      Inventory.clear
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
    @view_invisible = params["view_invisible"] == "1"
    @setting_variables = Command::Setting.get_setting_variables
    @error_list = {}
  end

  post "/settings" do
    built_arguments = []
    output = ""
    device = params.delete("device")
    [:local, :global].each do |scope|
      @setting_variables[scope].each do |name, info|
        param_data = params[name]
        argument = ""
        if info[0] == :boolean
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
    haml :about, layout: false
  end

  post "/shutdown" do
    self.class.quit!
    "シャットダウンしました。再起動するまで操作は出来ません"
  end

  before "/novels/:id/*" do
    @id = params[:id]
    not_found unless @id =~ /^\d+$/
    @data = Downloader.get_data_by_target(@id)
    not_found unless @data
  end

  before "/novels/:id/setting" do
    @title = "小説の変換設定"
    @novel_title = @data["title"]
    @setting_variables = []
    @error_list = {}
    @novel_setting = NovelSetting.load(@id, true)
    @default_settings = NovelSetting::DEFAULT_SETTINGS
    @force_settings = Inventory.load("local_setting", :local).select { |n| n.start_with?("force.") }
    @replace_pattern = @novel_setting.load_replace_pattern
  end

  post "/novels/:id/setting" do
    # 変換設定保存
    @default_settings.each do |info|
      name, type = info[:name], info[:type]
      param_data = params[name]
      value = nil
      begin
        case type
        when :boolean
          if param_data
            value = convert_on_off_to_boolean(param_data)
          else
            value = false
          end
        else
          value = Helper.string_cast_to_type(param_data, type)
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
      send_file(path, filename: File.basename(path))
    else
      not_found
    end
  end

  # -------------------------------------------------------------------------------
  # API's
  # -------------------------------------------------------------------------------

  get "/api/list" do
    database_values = Database.instance.get_object.values
    json_objects = {
      draw: 1, recordsTotal: database_values.count, recordsFiltered: database_values.count
    }
    json_objects[:data] =
      database_values.map do |data|
        tags = data["tags"] || []
        id = data["id"]
        {
          id: id.to_s,
          last_update: data["last_update"].to_i,
          title: escape_html(data["title"]),
          author: escape_html(data["author"]),
          sitename: data["sitename"],
          toc_url: %!<a href="#{escape_html(data["toc_url"])}" target="_blank" ! +
                   %!data-toggle="tooltip" data-placement="top" title="#{data["toc_url"]}">! +
                   %!<span class="glyphicon glyphicon-link"></span></a>!,
          novel_type: data["novel_type"] == 2 ? "短編" : "連載",
          tags: (tags.empty? ? "" : decorate_tags(tags) + '&nbsp;<span class="tag label label-white" data-tag="" data-toggle="tooltip" title="タグ検索を解除">&nbsp;</span>'),
          status: [
            Narou.novel_frozen?(id) ? "凍結" : nil,
            tags.include?("end") ? "完結" : nil,
            tags.include?("404") ? "削除" : nil,
          ].compact.join(", "),
          download: %!<a href="/novels/#{id}/download"><span class="glyphicon glyphicon-book"></span></a>!,
          frozen: Narou.novel_frozen?(id),
          new_arrivals_date: data["new_arrivals_date"] ? data["new_arrivals_date"].to_i : nil
        }
      end
    json json_objects
  end

  post "/api/convert" do
    ids = select_valid_novel_ids(params["ids"]) or pass
    Narou::Worker.push do
      CommandLine.run!(["convert", "--no-open", ids])
    end
  end

  post "/api/download" do
    target = params["target"] or pass
    Narou::Worker.push do
      CommandLine.run!(["download", target])
      @@push_server.send_all("table.reload" => true)
    end
  end

  post "/api/download_force" do
    ids = select_valid_novel_ids(params["ids"]) or pass
    Narou::Worker.push do
      CommandLine.run!(["download", "--force", ids])
      @@push_server.send_all("table.reload" => true)
    end
  end

  post "/api/update" do
    Narou::Worker.push do
      CommandLine.run!(["update"])
      @@push_server.send_all("table.reload" => true)
    end
  end

  post "/api/update_select" do
    ids = select_valid_novel_ids(params["ids"]) or pass
    Narou::Worker.push do
      CommandLine.run!(["update", ids])
      @@push_server.send_all("table.reload" => true)
    end
  end

  post "/api/send" do
    Narou::Worker.push do
      CommandLine.run!(["send"])
    end
  end

  post "/api/send_select" do
    ids = select_valid_novel_ids(params["ids"]) or pass
    Narou::Worker.push do
      CommandLine.run!(["send", ids])
    end
  end

  post "/api/freeze" do
    ids = select_valid_novel_ids(params["ids"]) or pass
    Narou::Worker.push do
      CommandLine.run!(["freeze", ids])
      @@push_server.send_all("table.reload" => true)
    end
  end

  post "/api/freeze_on" do
    ids = select_valid_novel_ids(params["ids"]) or pass
    Narou::Worker.push do
      CommandLine.run!(["freeze", "--on", ids])
      @@push_server.send_all("table.reload" => true)
    end
  end

  post "/api/freeze_off" do
    ids = select_valid_novel_ids(params["ids"]) or pass
    Narou::Worker.push do
      CommandLine.run!(["freeze", "--off", ids])
      @@push_server.send_all("table.reload" => true)
    end
  end

  post "/api/remove" do
    ids = select_valid_novel_ids(params["ids"]) or pass
    Narou::Worker.push do
      CommandLine.run!(["remove", "--yes", ids])
      @@push_server.send_all("table.reload" => true)
    end
  end

  post "/api/remove_with_file" do
    ids = select_valid_novel_ids(params["ids"]) or pass
    Narou::Worker.push do
      CommandLine.run!(["remove", "--yes", "--with-file", ids])
      @@push_server.send_all("table.reload" => true)
    end
  end

  post "/api/diff" do
    ids = select_valid_novel_ids(params["ids"]) or pass
    Narou::Worker.push do
      # diff コマンドは１度に一つのIDしか受け取らないので
      ids.each do |id|
        # セキュリティ的にWEB UIでは独自の差分表示のみ使う
        CommandLine.run!(["diff", "--no-tool", id])
        print "<hr>"
      end
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
    Narou::Worker.push do
      CommandLine.run!(["folder", ids])
    end
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
    result = '<div><span class="tag label label-default" data-tag="">タグ検索を解除</span></div>'
    tagname_list = Command::Tag.get_tag_list.keys
    tagname_list.each do |tagname|
      result << "<div>#{decorate_tags([tagname])}</div>"
    end
    result
  end

  post "/api/taginfo.json" do
    ids = select_valid_novel_ids(params["ids"]) or pass
    ids.map!(&:to_i)
    database = Database.instance
    tag_info = {}
    database.each do |_, data|
      tags = data["tags"] || []
      tags.each do |tag|
        tag_info[tag] ||= {
          count: 0,
          html: decorate_tags([tag])
        }
        if ids.include?(data["id"])
          tag_info[tag][:count] += 1
        end
      end
    end
    json tag_info
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
end

