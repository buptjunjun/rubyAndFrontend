#encoding: utf-8

require 'thread'
t1 = Thread.new{
  sleep_time = 3
  puts "#{self.inspect} sleep #{sleep_time}"
  sleep(sleep_time)
  puts "#{self.inspect} wake up"
}
puts "---"
t1.run