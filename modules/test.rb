# #encoding:utf-8
# require 'rubygems'
# require 'active_record'
# require 'yaml'
# require 'logger'
#
#
# s = "abcd<p></p><img src=x onerror=alert(/xss/) />test";
# s1 = "abcd<img src=x />test";
# s2 = "你好sss"
# s3 = '<img title="Love" alt="Love" src="http://tv.baicizhan.com/bczbqplugin/imgs/tsj/t_0025.gif" style="font-size: 14px; color: rgb(0, 0, 0); line-height: 22.5px;">'
#
# puts s2 =~ /\w*(<img src=)*/
# (title='.*')
# ARGV.each do |item|
#   puts item
# end
#
#
# def get(e)
#   ret = {}
#   ret["msg"] = e.message
#   stackStr = ""
#   e.backtrace.each {|stack| stackStr += "\n"+stack.to_s}
#   ret["stack"] = stackStr
#   return ret
# end
#
# begin
#   1/0
# rescue => e
#   puts get(e).inspect
# end

a = [1,2,3]
while((b = a.shift) != nil)
  puts b
end

class Name
  A = 1
  B = 2
end

puts Name.const_get("A")

module ParentModule

  def foo
    puts "parent foo"
  end
end

module ChildModule
  include  ParentModule

  def foo
    puts "child foo"
  end
end

obj = Object

obj.extend(ChildModule)

puts obj.is_a? ParentModule
puts obj.foo


class GrandChild
  include ChildModule

  def foo
    puts "hello grand child"
  end
end

gchild = GrandChild.new
gchild.foo


a = 123
def time(num1,num2)
  start = Time.now
  result = yield num1,num2
  puts "Completed in #{Time.now - start} seconds."
  result
end

time(123,123) do |x,y|
 puts  x +2
end


class A
  def foo
    puts "a"
  end
end

class B < A
  def foo
    super
    puts "b"
  end
end

b = B.new
b.foo

b=1
puts eval("a=1; a==b")
puts eval("a=1; a!=b")

a = 'dddd df "adsfa" ""   '
puts

