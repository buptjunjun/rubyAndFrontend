#encoding:utf-8
require 'digest/md5'

file_name = "test.jpg"
#data = File.open(file_name).read
data = File.open(file_name,"rb").read
puts data.encoding
puts data.class
puts data.size

#IO.write("test1.jpg",data)
puts File.size?(file_name)

puts Digest::MD5.hexdigest(data)