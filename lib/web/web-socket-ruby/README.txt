HTML5 Web Socket server/client implementation in Ruby.

For server, em-websocket ( https://github.com/igrigorik/em-websocket ) may be a better choice, especially if you want to use EventMachine.


* How to run sample

- Run sample Web Socket server (echo server) with:
  $ ruby samples/echo_server.rb localhost 10081

- Run sample Web Socket client and type something:
  $ ruby samples/stdio_client.rb ws://localhost:10081
  Ready
  hoge
  Sent: "hoge"
  Received: "hoge"


* Usage example

Server:

  # Runs the server at port 10081. It allows connections whose origin is example.com.
  server = WebSocketServer.new(:port => 10081, :accepted_domains => ["example.com"])
  server.run() do |ws|
    # The block is called for each connection.
    # Checks requested path.
    if ws.path == "/"
      # Call ws.handshake() without argument first.
      ws.handshake()
      # Receives one message from the client as String.
      while data = ws.receive()
        puts(data)
        # Sends the message to the client.
        ws.send(data)
      end
    else
      # You can call ws.handshake() with argument to return error status.
      ws.handshake("404 Not Found")
    end
  end

Client:

  # Connects to Web Socket server at host example.com port 10081.
  client = WebSocket.new("ws://example.com:10081/")
  # Sends a message to the server.
  client.send("Hello")
  # Receives a message from the server.
  data = client.receive()
  puts(data)


* Supported WebSocket protocol versions

WebSocketServer class (server) accepts version hixie-75, hixie-76, hybi-07, hybi-10.
WebSocket class (client) speaks version hixie-76.


* Tips: JavaScript client implementation

Google Chrome Dev Channel natively supports Web Socket. For other browsers, you can use an implementation using Flash:
http://github.com/gimite/web-socket-js/tree/master


* WebSocket protocol versions

The server supports the protocol defined in RFC 6455, draft versions hixie-75 and hixie-76.

The client speaks draft version hixie-76.


* License

New BSD License.
