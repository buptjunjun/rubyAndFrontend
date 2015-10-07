#encoding:utf-8
#active mq 测试

require 'stomp'

port = 61613
client = Stomp::Client.new( 'admin', 'admin', 'www.coderlong.com', port )

client.subscribe("/queue/test") do |msg|
  puts "in subscribe"
  puts msg
end
client.join
client.close