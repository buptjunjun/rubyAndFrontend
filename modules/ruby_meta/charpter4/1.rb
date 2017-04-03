#encoding:utf-8

#类跟方法一样可以返回最后一条语句的值

ret1 = class Myclass
  puts "1 #{self} #{self.class}"
  self
end

puts ret1.inspect

#在不知道类名的情况下打开一个类

def add_method_to(a_class)
  a_class.class_eval do
    puts "2 #{self} #{self.class}"
    def foo()
      puts "foo" #还可以使用test，如果用class关键字就作用域不一样
      puts "3 #{self} #{self.class}"
    end
  end
end


#给Myclass添加一个方法
add_method_to(ret1)
#测试
Myclass.new.foo



class MyClass
  @my_var = 1 #self是Myclass类，@my_var 是 类的变量

  def self.read; @my_var ;end

  def write
    @my_var = 2 #self是当前对象，是对象的实例变量
  end

  def read
    @my_var
  end
end

obj = MyClass.new

puts obj.write
puts "obj.read = #{obj.read}"
puts "Myclass.read = #{MyClass.read}"


#不使用关键字创建类,继承Array类
Myclass1 = Class.new(Array) do

  def self.foo1

  end

  def foo
    puts "foo1"
  end
end

obj1 = Myclass1.new
obj1.foo
puts obj1.size



#单件方法
puts "Myclass1.singleton_methods #{Myclass1.singleton_methods} "