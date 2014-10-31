# Copyright: Hiroshi Ichikawa <http://gimite.net/en/>
# Lincense: New BSD Lincense

$LOAD_PATH << File.dirname(__FILE__) + "/../lib"
require "web_socket"

Thread.abort_on_exception = true
# WebSocket.debug = true

if ARGV.size != 2
  $stderr.puts("Usage: ruby sample/echo_server.rb ACCEPTED_DOMAIN PORT")
  exit(1)
end

server = WebSocketServer.new(
  :accepted_domains => [ARGV[0]],
  :port => ARGV[1].to_i())
puts("Server is running at port %d" % server.port)
server.run() do |ws|
  puts("Connection accepted")
  puts("Path: #{ws.path}, Origin: #{ws.origin}")
  if ws.path == "/"
    ws.handshake()
    while data = ws.receive()
      printf("Received: %p\n", data)
      ws.send(data)
      printf("Sent: %p\n", data)
    end
  else
    ws.handshake("404 Not Found")
  end
  puts("Connection closed")
end
