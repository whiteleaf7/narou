# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

module Command
  class Web < CommandBase
    def self.oneline_help
      "WEBアプリケーション用サーバを起動します"
    end

    def initialize
      super("[options...]")
      @opt.separator <<-EOS

  ・WEBアプリケーション用サーバを起動します
  ・小説の管理及び設定をブラウザで行うことができます
  ・--port を指定しない場合、ポートは初回起動時にランダムで設定します
    (以降同じ設定を引き継ぎます)
  ・サーバ起動後にブラウザを立ち上げます
  ・サーバの停止はコンソールで Ctrl+C を入力します

  Examples:
    narou web   # サーバ起動(ポートはランダム。ポート設定保存)
    narou web -p 4567   # ポート4567で起動(保存はされない)

    # 先に決めておく
    narou s server-port=8000
    narou web   # ポート8000で起動

  Options:
      EOS
      @opt.on("-p", "--port PORT", Integer, "起動するポートを指定") { |port|
        @options["port"] = port
      }
      @opt.on("-n", "--no-browser", "起動時にブラウザは開かない") {
        @options["no-browser"] = true
      }
    end

    def confirm_of_first
      setting = Inventory.load("server_setting", :global)
      is_first = !setting["already-server-boot"]
      if is_first
        puts <<-EOS
初めてサーバを起動します。ファイアウォールのアクセス許可を尋ねられた場合、許可をして下さい。
また、起動したサーバを止めるにはコンソール上で Ctrl+C を入力するか、ブラウザ上で「設定(歯車マーク)→サーバをシャットダウン」を実行して下さい。

        EOS
        if @options["no-browser"]
          puts "(何かキーを押して下さい)"
        else
          puts "(何かキーを押して下さい。サーバ起動後ブラウザが立ち上がります)"
        end
        $stdin.getch
        setting["already-server-boot"] = true
        setting.save
      end
      is_first
    end

    class EatLogger < StringIO
      def write(*a) end
    end

    def create_push_server(params)
      host, port = params[:host], params[:port]
      push_server = Narou::PushServer.instance
      push_server.accepted_domains = (host == "0.0.0.0" ? "*" : host)
      push_server.port = port + 1
      push_server.host = host
      push_server
    end

    def execute(argv)
      super
      require_relative "../web/all"
      confirm_of_first
      $stderr = EatLogger.new unless $display_backtrace
      params = Narou::AppServer.create_address(@options["port"])
      push_server = create_push_server(params)
      Narou.web = true
      Thread.abort_on_exception = true

      address = "http://#{params[:host]}:#{params[:port]}/"
      puts address
      puts "サーバを止めるには Ctrl+C を入力"
      puts

      push_server.run
      unless @options["no-browser"]
        Thread.new do
          sleep 0.2 until Narou::AppServer.running?
          Helper.open_browser(address)
        end
      end
      $stdout = Narou::StreamingLogger.new(push_server)
      ProgressBar.push_server = push_server
      Narou::AppServer.push_server = push_server
      Narou::Worker.instance.start
      Narou::AppServer.run!
      push_server.quit
    rescue Errno::EADDRINUSE => e
      STDOUT.puts <<-EOS
#{e}
ポートが使われています。サーバがすでに立ち上がっているかどうか確認して下さい。
他のアプリケーションが使っているポートだった場合、ポートを変更して下さい。

ポートの変更方法
  $ narou s server-port=5678
      EOS
      exit Narou::EXIT_ERROR_CODE
    end
  end
end

