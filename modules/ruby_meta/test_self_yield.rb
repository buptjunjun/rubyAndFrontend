#self yield
#用某个对象调用一个方法，并传入一个block，在执行这个block的时候又将self当做参数传递进去

class TestSelfYield
  attr_accessor :name,:password

  def initialize(&block)
    yield self if block #将self 当做参数传递给block
  end
end

tsy = TestSelfYield.new do |self_| ##<TestSelfYield:0x007ff0fd93ece8 @name="abc", @password="bcd">
  self_.name="abc"
  self_.password = "bcd"
end

puts tsy.inspect

#ruby用多个方法调用形成方法调用链很常见，按时中间某部分出了问题的调试会很恼火，可以使用tap函数来进行
#tap函数用来调试“火车失事”

a = [1,1,2,3,4,"abc","bcd"]
b=["abc",2]


#c = (a-b).push(100).shift.upcase.next

#加入tap{|x| puts x }打印出当前的对象值
c = (a-b).push(100).shift.tap{|x| puts "调用到这里 对象值是:"+x.inspect }.upcase.next
puts c