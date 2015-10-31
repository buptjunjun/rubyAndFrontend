require 'thrift'
require File.expand_path("../multiplication_service.rb",__FILE__)

port = 9090
transport = Thrift::BufferedTransport.new(Thrift::Socket.new("localhost",port))
protocal = Thrift::BinaryProtocol.new(transport)
client = MultiplicationService::Client.new(protocal)

transport.open()
puts client.multiply(2,3)