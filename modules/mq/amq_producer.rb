#encoding:utf-8
#active mq 测试

require 'stomp'

port = 61613
client = Stomp::Client.new( 'admin', 'admin', 'www.coderlong.com', port)
10.times do
  client.publish("/queue/test", "hello world--!") #client.publish(queue name,message)
  puts "about to subscribe"
end

client.close