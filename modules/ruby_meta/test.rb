


def call_method
  client = 123

  if block_given?
    yield(client)
  end
end



call_method do |client|
  puts client
end


