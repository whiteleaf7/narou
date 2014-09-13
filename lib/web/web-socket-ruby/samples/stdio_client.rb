# Copyright: Hiroshi Ichikawa <http://gimite.net/en/>
# Lincense: New BSD Lincense

$LOAD_PATH << File.dirname(__FILE__) + "/../lib"
require "web_socket"

if ARGV.size != 1
  $stderr.puts("Usage: ruby samples/stdio_client.rb ws://HOST:PORT/")
  exit(1)
end

client = WebSocket.new(ARGV[0])
puts("Connected")
Thread.new() do
  while data = client.receive()
    printf("Received: %p\n", data)
  end
  exit()
end
$stdin.each_line() do |line|
  data = line.chomp()
  client.send(data)
  printf("Sent: %p\n", data)
end
client.close()
