#encoding: UTF-8
#ruby的一些库
require 'fileutils'
puts "hello from ruby_libs.rb"

array = [1,2,3]
array.delete_at(1)
puts array

array.each do  |item|
  if item ==  1
    break;
  end
  puts item
end

#
# FileUtils.cp("/tmp/.jpg","/User/junjun/documents/")
#
FileUtils.mkdir_p("/tmp/1/2")
FileUtils.copy_file("/var/folders/2s/pj4tqrx1421_xw8_4ttppnxc0000gn/T/RackMultipart20150814-19169-r8c5gd" ,"/tmp/1234.log")

#定时任务
require 'rufus-scheduler'
scheduler = Rufus::Scheduler.new

puts Time.new
puts 'process begin----'
scheduler.cron '/1 * * * *' do
   puts Time.new
   puts 'Hello word'
 end
scheduler.join


