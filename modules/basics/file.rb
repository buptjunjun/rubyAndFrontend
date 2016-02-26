#encoding:utf-8
require 'digest/md5'
require 'fileutils'

file_name = "test.jpg"
#data = File.open(file_name).read
data = File.open(file_name,"rb").read
puts data.encoding
puts data.class
puts data.size

#IO.write("test1.jpg",data)
puts File.size?(file_name)

puts Digest::MD5.hexdigest(data)


#copy file
dir = File.expand_path("../test_files/")
file = File.join(dir,"aaa.txt")
new_file = File.join(dir,"bbb.txt")

ext_name = File.extname(new_file)
new_file = new_file.sub(ext_name,"_c#{ext_name}")

FileUtils.copy(file,new_file)