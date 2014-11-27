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
end

class Narou::AppServer < Sinatra::Base
  register Sinatra::Reloader if $debug
  helpers Narou::ServerHelpers

  configure do
    set :app_file, __FILE__
    set :erb, trim: "-"
    set :haml, format: :html5
    enable :protection

    set(:version) do
      Command::Version.create_version_string
    end
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

  get "/settings" do
    @title = "環境設定"
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
      CommandLine.run(["convert", ids])
    end
  end

  post "/api/download" do
    target = params["target"] or pass
    Narou::Worker.push do
      CommandLine.run(["download", target])
    end
  end

  post "/api/download_force" do
    ids = select_valid_novel_ids(params["ids"]) or pass
    Narou::Worker.push do
      CommandLine.run(["download", "--force", ids])
    end
  end

  post "/api/update" do
    Narou::Worker.push do
      CommandLine.run(["update"])
    end
  end

  post "/api/update_select" do
    ids = select_valid_novel_ids(params["ids"]) or pass
    Narou::Worker.push do
      CommandLine.run(["update", ids])
    end
  end
end

