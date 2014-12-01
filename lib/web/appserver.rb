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

module Narou::ServerHelpers
  #
  # タグをHTMLで装飾する
  #
  def decorate_tags(tags)
    tags.map do |tag|
      %!<span class="label label-#{Command::Tag.get_color(tag)}">#{escape_html(tag)}</span>!
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
    when NilClass
      "nil"
    when TrueClass
      "on"
    else
      "off"
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
  # bindは自分で設定する場合は narou s server-bind=localhost で行う
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
    host = bind ? bind : ipaddress
    set :port, port
    set :bind, host
    {
      host: host == "localhost" ? host : ipaddress,
      port: port
    }
  end

  #
  # 自分のIPアドレス取得
  #
  # 参考：http://qiita.com/saltheads/items/cc49fcf2af37cb277c4f
  #
  def self.my_ipaddress
    udp = UDPSocket.new
    udp.connect("128.0.0.0", 7)
    adrs = Socket.unpack_sockaddr_in(udp.getsockname)[1]
    udp.close
    adrs
  end

  # ===================================================================
  # ルーティング
  # ===================================================================

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
    is_error = false
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
    unless built_arguments.empty?
      $stdout.silence do
        setting = Command::Setting.new
        setting.add_event_listener(:error) do |msg, name|
          if name
            @error_list[name] = msg
          end
        end
        begin
          setting.execute(built_arguments)
        rescue SystemExit => e
          is_error = e.status
        end
      end
    end
    if is_error
      session[:alert] = [ "#{is_error}個の設定にエラーがありました", "danger" ]
    else
      session[:alert] = [ "保存が完了しました", "success" ]
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
        {
          id: data["id"].to_s,
          last_update: data["last_update"].strftime("%Y/%m/%d %R"),
          title: escape_html(data["title"]),
          author: escape_html(data["author"]),
          sitename: data["sitename"],
          toc_url: %!<a href="#{escape_html(data["toc_url"])}" target="_blank" ! +
                   %!data-toggle="tooltip" data-placement="top" title="#{data["toc_url"]}">! +
                   %!<span class="glyphicon glyphicon-link"></span></a>!,
          novel_type: data["novel_type"] == 2 ? "短編" : "連載中",
          tags: decorate_tags(tags),
          status: [
            Narou.novel_frozen?(data["id"]) ? "凍結" : nil,
            tags.include?("end") ? "完結" : nil,
            tags.include?("404") ? "削除" : nil,
          ].compact.join(", "),
          download: %!<a href="#"><span class="glyphicon glyphicon-book"></span></a>!,
        }.tap { |this|
          # table-cell 内で position: abosolute を使うために div をかます
          # 参考： http://no1026.com/archives/406
          this.each do |key, value|
            this[key] = "<div>#{value}</div>"
          end
          # 内部データ用なのでそのまま
          this[:frozen] = Narou.novel_frozen?(data["id"])
          this[:_id] = data["id"].to_s
        }
      end
    json json_objects
  end

  post "/api/convert" do
    ids = select_valid_novel_ids(params["ids"]) or pass
    Narou::Worker.push do
      CommandLine.run!(["convert", ids])
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

  post "/api/display_text_list" do
    Narou::Worker.push do
      CommandLine.run!(["list"])
    end
  end

  post "/api/diff" do
    ids = select_valid_novel_ids(params["ids"]) or pass
    Narou::Worker.push do
      # diff コマンドは１度に一つのIDしか受け取らないので
      ids.each do |id|
        CommandLine.run!(["diff", id])
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
end

