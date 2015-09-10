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
1 require 'rufus-scheduler'
2 scheduler = Rufus::Scheduler.new
3
4 puts Time.new
5 puts 'process begin----'
6 scheduler.cron '/1 * * * *' do
  7   puts Time.new
  8   puts 'Hello word'
  9 end
10 scheduler.join