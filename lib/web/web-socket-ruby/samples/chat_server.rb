# Copyright: Hiroshi Ichikawa <http://gimite.net/en/>
# Lincense: New BSD Lincense

$LOAD_PATH << File.dirname(__FILE__) + "/../lib"
require "web_socket"
require "thread"

Thread.abort_on_exception = true

if ARGV.size != 2
  $stderr.puts("Usage: ruby sample/chat_server.rb ACCEPTED_DOMAIN PORT")
  exit(1)
end

server = WebSocketServer.new(
  :accepted_domains => [ARGV[0]],
  :port => ARGV[1].to_i())
puts("Server is running at port %d" % server.port)
connections = []
history = [nil] * 20

server.run() do |ws|
  begin
    
    puts("Connection accepted")
    ws.handshake()
    que = Queue.new()
    connections.push(que)
    
    for message in history
      next if !message
      ws.send(message)
      puts("Sent: #{message}")
    end
    
    thread = Thread.new() do
      while true
        message = que.pop()
        ws.send(message)
        puts("Sent: #{message}")
      end
    end
    
    while data = ws.receive()
      puts("Received: #{data}")
      for conn in connections
        conn.push(data)
      end
      history.push(data)
      history.shift()
    end
    
  ensure
    connections.delete(que)
    thread.terminate() if thread
    puts("Connection closed")
  end
end
