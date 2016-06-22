#encoding:utf-8

class Myclass

    define_method :test do |arg1,arg2=2|
        puts "#{arg1} - #{arg2}"
    end

end

cls = Myclass.new
cls.test(2233)
cls.test("1",2)
cls.send(:test,*[444,111])
cls.test(*[444,111])


class Ds
  def get_mouse_info()
    return "mouse x1"
  end

  def get_mouse_price()
    return 10
  end

  def get_screen_info()
    return "screen1 x1"
  end

  def get_screen_price()
    return 10
  end

end


class Computer
  def initialize(ds)
      @ds = ds
  end

  def mouse
    price = @ds.get_mouse_price
    info = @ds.get_mouse_info
    result = "#{price}, #{info}"
  end


  def screen
    price = @ds.get_screen_price
    info = @ds.get_screen_info
    result = "#{price}, #{info}"
  end
end


#使用动态定义方法来重构Computer类
class Computer1
  def initialize(ds)
    @ds = ds
  end

  def self.define_component(name)
    define_method(name) do
      price = @ds.send("get_#{name}_price")
      info = @ds.send("get_#{name}_info")
      result = "#{price}, #{info}"
    end
  end

  define_component :mouse
  define_component :screen
end


#使用method_messing来重构Computer类 (幽灵方法)
class Computer2
  def initialize(ds)
    @ds = ds
  end


  def respond_to?(name)
    @ds.respond_to?("get_#{name}_price") || super
  end

  #使用幽灵方法来重构
  def method_missing(method_name, *args)

   #如果没有这个方法就使用默认的method_messing
   if !@ds.respond_to?("get_#{method_name}_price")
     super
   end

    price = @ds.send("get_#{method_name}_price")
    info = @ds.send("get_#{method_name}_info")
    result = "#{price}, #{info}"
  end

end



puts "--Commputer--"
ds = Ds.new
cp = Computer.new(ds)
puts cp.mouse

puts "--Commputer1--"
ds = Ds.new
cp = Computer1.new(ds)
puts cp.mouse


puts "--Commputer2--"
ds = Ds.new
cp = Computer2.new(ds)
puts cp.mouse
puts cp.respond_to?(:mouse)
#puts ds.send("get_mouse_price")


require 'delegate'

class DComputer < DelegateClass(Computer)
  def initialize(cp)
    super(cp)
  end


  def hello
    puts "hello"
  end

end

puts "---代理类测试---"
cp = Computer.new(ds)
dcp = DComputer.new(cp)
dcp.hello
puts dcp.mouse


define_method :foo, ->{ puts "test"; 42 }
puts foo
