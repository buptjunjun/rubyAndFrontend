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

puts "一个对象extend一个方法"
class NeedMorePower

end

n1 = NeedMorePower.new
#没有这个方法
begin
  n1.instance_method
rescue => e
  puts e.to_s
end

n2 = NeedMorePower.new
n2.extend(CommonMethodAgain) #扩展了一个CommonMethodAgain的方法
n2.instance_method
#n2.class.static_method #会报错

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


puts "\n==白板类"

class BlankClass

  def method_missing(method, *args , &block)
     if method.to_s == "display"
       puts "display in method_missing"
     end
  end
end

bc1 = BlankClass.new
puts "Object 的方法，#{Object.instance_methods(true).grep(/display/)}" #打印Object的方法
bc1.display #因为object有display类，所有不会打印 "display in method_missing"

=begin
  1.我们在给一个类通过method_missing提供动态方法的时候，有时候会忽略这个对象已经有了同名的方法(method_missing里面的代码就得不到调用)，这时候我们需要将原来的方法删掉。
  2.将原来对象的所有方法都删掉，这个对象就成为了一个白板类。
  3.如果将一个类全部实例方法都删掉了也会出问题，比如 send 方法 method_missing方法这些就不能删除，为了保留一些核心的方法，ruby将这些方法进行了重命名，在前后都加入了两个下划线，为__send__.所有以“__”开头的不要删除。
=end
class BlankClass

  #不隐藏以__和"instance_eval"打头的方法
  def self.hide(method)
    if instance_methods.include?(method.to_s) and method.to_s !~ /^(__|instance_eval)/
      @hidden_methods ||= {}
      @hidden_methods[method.to_s] = instance_method(method.to_s)
      puts "undefined #{method.to_s}"
      undef_method method.to_s
    end
  end

  instance_methods.each do |m|
    undef_method m unless m.to_s =~ /^__|method_missing|respond_to?/
  end

end

bc2 = BlankClass.new
puts "\n"
bc2.display #打印 "display in method_missing"