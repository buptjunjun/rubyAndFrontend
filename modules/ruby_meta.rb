# encoding: UTF-8

require 'ostruct'
#ruby元编程实践
puts "第一章"
class Test

end

#method_missing
puts Test.ancestors

puts "第二章"
puts "一 ruby的方法"
puts "一 ruby的动态派发"

class Test
  #动态定义方法
  "method1,method2".scan(/\w+\d/) do |arg|
    puts "定义方法:#{arg}"
    define_method arg do |myarg|
      puts myarg+";"
    end
  end

  def self.method3(str)
    puts "method3#{str}"
  end
end

t1 = Test.new
t2 = Test.new
t1.method1("测试method1")
t2.method2("测试method2")

#动态调用方法
t2.send("method1","测试send")

#Object.const_get("Test") 获取一个类
puts Object.const_get("Test").method3("测试动态获取类")
t3 = Object.const_get("Test").new
puts t3.method2("测试动态获取类")

puts "===幽灵方法 method_missing"
=begin
  method_missing 是kernel的一个方法 当把一个方法发送给一个对象的时候，
  对象会沿着祖先链向上寻找这个方法,当找到object的时候还没有找到就会调用 kernel的method_missing方法
  如果没有处理 会默认报一个  undefined method `test_method_missing' for #<Test:0x007fca6d0f7280> (NoMethodError)
=end

# undefined method `test_method_missing' for #<Test:0x007fca6d0f7280> (NoMethodError)
begin
  t1.test_method_missing
rescue => e
  puts e
end

#从新打开Test类加入method_missing
class Test
  def method_missing (method_name,*args,&block)
    if method_name.to_s == "test_method_missing"
      puts "test_method_missing exist!haha"
      if block
         block.call(args)
      end
      return
    end
    super(method_name,args,block)
  end
end

t1.test_method_missing("你好 block","他好,我也好") do |args|
  puts args
end

#现实中的例子
car = OpenStruct.new
car.name = "大众"
car.price = 123.12
puts "#{car.name} costs #{car.price}"

class MyOpenstruct
  def initialize
    @attribute={}
  end

  def method_missing(method_name, *args)
    key = method_name.to_s
    if key =~ /=$/
      #chop去掉字符串某位的最后一个字符
      @attribute[key.chop] = args[0]
    else
      @attribute[key]
    end
  end
end

#自己实现一个
puts "MyOpenstruct"
mycar = MyOpenstruct.new
mycar.name = "大众"
mycar.price = 123.12
puts "#{mycar.name} costs #{mycar.price}"


#mixin
#设计模式--Mixin模式
puts "\n\n==mixin==\n"
module CommonModule
  def test_method
    puts self.class
    puts "method=="
  end
end

#include将module里的方法变成instance method
class TestModule
  include CommonModule
end
puts TestModule.new.test_method

#extend将moudle里的方法变成class method
class TestModuleAgain
  extend CommonModule
end
TestModuleAgain.test_method


#同时包括class method和instance method
module CommonMethodAgain
  #included可以看做是include的一个回调函数，在include调用完成后会调用这个函数
  #其中base是调用include的类
  def self.included(base)
    puts "==#{base}"
    base.extend(ClassMethods) #在调用include的类上面调用extend将ClassMethods里面的方法作为class method
    puts "includes finished"
  end

  def instance_method
    puts  "self=#{self} CommonMethodAgain instance method"
  end

  module ClassMethods
    def static_method
      puts "self=#{self} CommonMethodAgain instance method"
    end
  end
end

class TestModuleBoth
  include CommonMethodAgain
end

TestModuleBoth.static_method
TestModuleBoth.new.instance_method

puts "respond_to? 和 method_missing"
=begin
  respond_to?查看一个对象是否能响应某个方法
=end
#给MyOpenstruct加上respond_to？方法，所有已有的属性都能响应
class MyOpenstruct
  def respond_to?(method)
     attr = method.to_s
     attr = method.chop if method =~ /$=/
     @attribute[attr] != nil || super
  end
end
mycar = MyOpenstruct.new
mycar.width = 123
puts mycar.respond_to?(:width)

