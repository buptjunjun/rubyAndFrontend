#测试类的self


class TestCurrentClass

  ConstA = 12345

  def initialize
    @params = "params--"
  end

  #是TestCurrentClass的Class对象
  puts "1." +self.inspect

  def method1
    puts "2."+self.inspect

    #method2还是在TestCurrentClass上面定义的
    #但是现在的self的TestCurrentClass的对象?
    #这里是特殊情况:定义这个方法是放在self的类中的，这时候的self是TestCurrentClass对象，ta的类是TestCurrentClass
    def method2
      puts "3."+self.inspect
    end
  end

end

#是TestCurrentClass的一个对象
t = TestCurrentClass.new
t.method1
t.method2


module TestExtend
  def method1
      puts "TestExtend"
  end
end

# t.instance_eval{
#   def method1
#     puts "instance_eval method1"
#   end
# }

t.method1

t.extend(Object.const_get("TestExtend"))

t.method1

code = File.read("test_module1.txt")

eval(code)


t.instance_eval{
  self.extend(TestModule1)
}
puts t.method1
