#encoding:utf-8

class Myclass
  def my_method
    @v = 1
  end
end


obj = Myclass.new
puts obj.class
puts obj.my_method
puts obj.instance_variables
puts obj.methods.grep(/^my/)


#注意实例方法和方法
puts obj.methods == Myclass.instance_methods


#类本身也是对象，她也有自己的类，名字叫做Class
puts Myclass.class #Class
puts Class.instance_methods(false).inspect #[:allocate, :new, :superclass]


puts Myclass.superclass #Object
puts Object.superclass #BasicObject
puts BasicObject.superclass.nil?#true


puts Class.class.class.class
puts Module.class

puts Class.superclass #Object
puts Module.superclass # Object


module A
  module B
    class C
      Y=4
      puts Module.nesting.inspect #获取当前常量的路径
    end
    X = 3
  end

  Z="123"
  A::M = 111
end

#返回当前范围内的顶级常量
puts A.constants.inspect

puts c = A::B::C.constants

require File.dirname(__FILE__)+"/to_be_require.rb"
puts "---" + M.inspect

#load的第二个参数如果是
load(File.dirname(__FILE__)+"/to_be_load.rb" ,true)
#puts "+++"+Y.inspect


class PrviateClassTest
  def public_m
    private_m #不能执行
  end

  private

  def private_m
    puts "private m"
  end
end


pt1 = PrviateClassTest.new
pt1.public_m

