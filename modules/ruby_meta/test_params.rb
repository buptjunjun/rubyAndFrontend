#encoding:utf-8
#测试ruby的参数

#有名参数
#有名参数是一个简单的hash表
#缺点是定义的时候参数可读性不高
def login(args)
  puts args.inspect
end

login(:name=>"a",:password=>"b") #{:name=>"a", :password=>"b"}

#参数数组
#使用*将参数收集到一个数组中,一个方法中只能有一个参数数组
def login1(*args)
  puts args.inspect
end

login1("name","password") #["name", "password"]

#默认参数
def login2(name,password="default")
  puts "#{name} - #{password}"
end

login2("name") #name - default


#混合使用默认参数,有名参数
#优缺点:使用普通参数可以很明确哪些参数存在; 使用参数数组和有名参数的话方法要自己解析参数,增加复杂度
def login3(*args)
  puts args.inspect
end

login3(:a,b="123",b:"b",c:"c") #[:a, "123", {:b=>"b", :c=>"c"}]

class TT

  def foo(a,b,c)
    puts "#{a} #{b} #{c}--"
  end

  def self.def_m(name)

    define_method(name) do |*args|
      puts foo(*args)
    end
  end

  def_m :ttt
end


TT.new().ttt(123,345,567)