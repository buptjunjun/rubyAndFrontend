require 'thrift'
require File.expand_path("../multiplication_service.rb",__FILE__)
class MultiplicatoinHandler
  def multiply(n1, n2)
    n1*n2
  end
end


handler = MultiplicatoinHandler.new
processor = MultiplicationService::Processor.new(handler)
transport = Thrift::ServerSocket.new(9090)
transportFactory = Thrift::BufferedTransportFactory.new
server = Thrift::SimpleServer.new(processor,transport,transportFactory)
puts "starting the server"
server.serve()
puts "done."