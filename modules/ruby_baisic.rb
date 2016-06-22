# encoding: UTF-8

#打印一个字符串
puts "hello"

print "2 +2 is equal to " ,2+2

#把hello world 打印4次
10.times do print "hello world!" end
 #puts 和 print的区别在于，puts会自动换行
puts 

# 一个类
class Person
  #为person定义了三个属性 ，attr表示属性，accessor表示这些属性是可以访问的
  attr_accessor :name,:age,:gender
end #end与class配对

#创建person的新实例
p = Person.new
p.name="Andy"
p.age=10
p.gender="male"

print p.name

# 下面是类的继承
class Pet
   attr_accessor :name, :gender, :color
end

class Cat <Pet
end

class Dog <Pet
  #类的方法
  def bark
    puts "wang wang!"
  end
end

#snake 有自己的属性 length
class Snake <Pet
  attr_accessor :length
end


snake = Snake.new
snake.length=10
snake.name="Yami"
puts " #{snake.name}'s length is #{snake.length }"

dog = Dog.new
dog.bark()

#ruby 的反射
puts "---反射---"
puts dog.class
puts 2.class #Fixnum


#kernel模块 ruby的核心模块 ，  在每一个类和有效的范围中使用
puts "---kernel 模块---"
Kernel.puts "hello"


puts "---字符串 String---"
str = "this is test"
puts str.class
puts str.length
puts str.upcase


## ruby的表达式
puts "--ruby的表达式---"
puts "a"+"b"+"c"
age = 19
puts "you are too young" if age > 18 && age < 20
puts "you are too young" if age.between?(18,20) 
puts "8<=>10 #{8<=>10}"
puts "10<=>8 #{10<=>8}"
puts "10<=>10 #{10<=>10}"
puts "8==10 #{8==10}"

puts "---迭代子---"
#将do后面的代码块传递给times
2.times do
  puts "hello"
  puts "laopo"
end

#也可以这样
2.times {
  puts "hello"
  puts "laopo"
}

puts "---迭代子中访问当前迭代数字---"
puts "从0开始每一步是2,num是当前迭代的步数"
0.step(5,2) do
  |num| puts num
end

puts "---浮点数 转换---"
puts 3.to_f / 3
puts 3.0.to_i / 3

puts "---大写字母开头的为常量名,想想类也是大写字母开头---"
Pi = 3.145926
#对常量进行修改会提示错误
Pi = 3.3 #warning: already initialized constant Pi



#字符串
puts("---字符串---")
x="a"
y="b"
puts "successful" if x+y=="ab"

puts("---字符串包含多行文本，使用双引号只能包含一行文本，使用分隔符可以包含多行文本 ,不一定使用花括号，可以使用<> ()---")
str = %q{
aaa
bbb
ccc}
puts str

puts("---字符串包含多行文本，使用引入文档   <<表示标记了字符串的开始，后面跟的是分解符号---")
str = <<END_STR
aaa
bbb
ccc
END_STR
puts str


puts("---字符串的其他表达式---")
str = "a"*5
puts str
puts 'a'>'A' #比较ascii码
puts 'a'<'A'
puts ?a #查看某个字符的值   97
puts ?b
puts 97.chr # a


#插写 有点像django的模板
puts "---插写---"
x = 10
y = 20
puts "#{x} + #{y} = #{x+y}"
puts "it is a #{ "bad " * 5} world"


#正则表达式
#替换第一个匹配的文本
puts "foobarbar".sub("bar","foo")
#替换所有匹配的文本
puts "foobarbar".gsub("bar","foo")
#//表示一个正则表达式 ^..表示头两个字符
puts "foobarbar".sub(/^../,"ha")

#用正则表达式在进行迭代 ，scan通过传递给他的正则表达式在字符串中扫描，寻找所有匹配的表达式的内容
"xyz".scan(/./) do |letter| 
  puts letter
end

"this is a test".scan(/\w+/) do |letter| 
  puts letter
end 

#匹配查询运算符 =~ 检查是否包含
puts "String has vowels" if "this is a test" =~ /[aeiou]/
puts "String contains no digits" unless "this is a test" =~ /0-9/
#使用字符串的match比=~更强大，它把所有传给他的参数都看做是正则表达式
puts "String has vowels 1" if "this is a test".match(/[aeiou]/)
puts "String has vowels 2" if "this is a test".match("[aeiou]") #可以来自从外部文件中

# 使用括号 x是MatchData
x = "this is a test".match(/(\w+) (\w+)/)
puts x.class
puts x.length
x.length.times {
|num| puts x[num]
}


#数组与列表
puts "---数组与列表---"
a = []
b = [1,"a bc"]

#向数组的末尾加入元素
a  << "a"
a  << 23
puts "a=#{a}"
puts "b=#{b}"
a[0]*=3
puts "*3 : a[0]=#{a[0]}"

#也可以使用push
a.push("push")
puts "push : a=#{a}"
#从末尾弹出
a.pop
puts "pop : a=#{a}"

#join 方法
puts "join : a=#{a.join("|")}"

# scan 返回的是Array
letters = "this is a test".scan(/\w+/)
puts letters.class #Array
puts letters.join(",")
splits = "this is a test".split(/\s+/)
puts splits.class
puts splits.join(",")

# inspect 几乎所有的内置类都有, 相当于java中的toString 
puts "inspec : #{splits.inspect}"


puts "---数组的迭代 each---"
splits.each do |element|
  print element.to_s + "|"
end
puts

puts  "---数组的转化 collect---"
tmp = splits.collect{ |element| element+"X" }
puts tmp.inspect

puts  "---数组的加法减法---"
x = [1,"x"]
y = [2,"y"]
z = x+y
puts z.inspect
tmp = z-x
puts tmp.inspect

puts  "---数组是否为空,是否包含某个元素---"
puts x.empty?
puts z.include?("x")

puts  "---数组的first last reverse方法---"
puts "z.first = #{z.first} z.last = #{z.last}"
puts "z.first(2) = #{z.first(2).inspect} z.last(2) = #{z.last(2).inspect}"
puts "z.reverse = #{z.reverse.inspect}"


##散列表
puts "--散列表---"
dict = {'cat'=>'andy','dog'=>'xitele'}
puts dict.inspect
puts dict["cat"]
dict['cat'] = "Andy Yang"
puts dict.inspect

puts "---散列表 迭代 删除---"
dict.each {|key,value|
  print "#{key} = #{value} "
}
puts
puts "keys = #{dict.keys().inspect()}"
puts "values = #{dict.values().inspect()}"

dict.delete("cat")
puts "delete cat :#{dict.inspect}"

#有条件删除山列表的元素
x = {'a'=>100, 'b'=>200, 'c'=>300}
x.delete_if {|key,value| value < 300}
puts "delete_if: #{x.inspect}"

puts "---散列表中的散列表---"
bigdict = {
   "person"=>{
      "name" => "andy",
      "age" => 28
   },
   "animal"=>{
      "name" => "dog",
      "age" => 2
   },
}

puts bigdict.inspect
puts bigdict['person']['age']


## 流程控制
puts "---流程控制 ---"
puts "---if unless---"
age = 10
puts "you are too young to use this system 1" if age < 18
#也可以这样
if age < 18
  puts "you are too young to use this system 2"
end

#unless 与if相反
unless age > 18
  puts "you are too young to use this system 3"
end

#if与unless 也提供 else
unless age < 18
  puts "you are too young to use this system 4" 
else
  puts "welcome "
end

#三元运算符 ?:
puts "---三元运算符 ?:---"
age = 10
type = age < 18 ?"child":"adult"
puts "type = #{type}"


puts "---多重比较---"
age = 15
if age < 5
  type = "little child"
elsif age >=5 && age < 18
  type ="child"
else
  type = "adult"
end

puts "type = #{type}"

#ruby中的switch 
puts "ruby中的switch"
fruit = "orange"
case fruit
  when "orange" 
    color = "yellow"
  when "apple"
    color="red"
  when "banana"
    color="yellow"
  else  #如果都没有匹配到则执行else中的东西 相当于default
     color = "unknown"
end
puts "color = #{color}"


#还可以用这种表达方式
color =  case fruit
  when "orange" 
    "yellow"
  when "apple"
    "red"
  when "banana"
    "yellow"
  else  #如果都没有匹配到则执行else中的东西 相当于default
    "unknown"
end
puts "color = #{color}"


#while until 
puts "---while until---"
i = 10
while i < 12
  print  "#{i} "
  i+=1
end
puts 

i = 10
until i > 100
  print "#{i} "
  i = i*2
end
puts()


#也可以这样
i=2
i = i * 2 until i > 1000
puts "i = #{i}" #1024



##代码块
puts "---代码块--- each 接收一个代码块，{}和do end之间的都是代码块，本质上是匿名函数"
x = [1,2,3]
x.each {|elem| print "#{elem} "} 
puts()
x.each do |elem| print "#{elem} " end

puts "---接收代码块的函数 code_block前的&表示是代码块 ,一次只能传递一个代码块---"
def each_vowel(&code_block)
  %w(a e i o u).each{|vowel| code_block.call(vowel)}
end

each_vowel {|a| print a+" "}

puts "---也可以使用lambda将代码块存放在变量之中---"
print_param = lambda {|x| print "#{x} "}
#使用lambda的call方法来执行代码块
print_param.call(100)
puts()

#范围
puts "---范围---"
r1=('A'.."Z")
puts r1.class
a1 = r1.to_a #转换为数组
puts a1.class

puts "---把范围当成数组的索引 一次取多个元素 和设置多个元素---"
a = [1,2,3,4,5,6]
puts a[2..5].inspect
a[0,2] = ["a","b"]
puts a.inspect

#符号
puts "---符号 Symbol 符号就像java里面的String 是一个不变类---"
current_situation = :good
puts ":good is #{current_situation.class}" # Symbol

#符号不包含值和变量，
puts "fine " if current_situation == :good
puts "panic " if current_situation == :bad
#现在 内存中只有一个:good 和一个:bad

#假设我们 将:good 和:bad 换成字符串 内存中就有 2个good和一个bad 占用内存
current_situation1 = "good"
puts ":good is #{current_situation1.class}" # Symbol
#符号不包含值和变量，
puts "fine " if current_situation1 == "good"
puts "panic " if current_situation1 == "bad"

person1 = {:name => "Andy",:age => 10}
puts person1.inspect
puts person1[:name]


puts "---在ruby内部中有一个符号表，像c/c++在编译期间才有一个符号表，编译完成就没有了，而ruby把它保留下来了---"
puts "--- 打印所有的 符号---"
puts  Symbol.all_symbols


sa = "hello"
sb = "hello"
puts sa == sb

#快速创建数组
puts "---快速创建数组---"
a = %w(a 1,s  aa)
puts a.class
puts a.inspect #["a", "1,s", "aa"]

#select 是所有数组和散列表都有的方法
puts "---select 方法---"
a = %w(a a b b c d e f f)
b = %w(a f)
#这句话的意思是 从a去除b有的字母
selected_word = a.select {|word| !b.include?(word)} 
puts selected_word.inspect #["b", "b", "c", "d", "e"]

puts "---数组和散列表排序 sort_by---"
a = %w(a aaa bbb cc dd e)
sorted_a = a.sort_by {|elem| elem.length}  
puts "sorted_a = #{sorted_a.inspect}"# ["a", "e", "cc", "dd", "aaa", "bbb"]

puts "---strip方法---"
puts "    aaa    ".strip.length #3

## 类
puts "\n###类###"
puts "---变量的作用域 局部变量 ，全局变量， 对象变量， 类变量---"
puts "--局部变量---"
if true
  x = 10
  x+=1
  puts x #11
  if true
    x=100
    x+=1
    puts x #101
  end
  puts x #101
end

puts()
def basic_method
  x = 20
  puts x
end
x = 10
puts x  #10
basic_method #20
puts x #10


puts "---全局变量 $---"
 $x = 10
 
 def method
   $x+=1 
   puts $x 
 end
 puts $x #10
 method() #11
 puts $x #11
 
 
puts "---实例变量 类变量，类方法 实例方法--"

#@@share_by_class可以在类之间访问
@@share_by_class = "share by class"
class Square
  attr_accessor :number_of_squares
  def initialize(side_length)
    @side_length = side_length  # @side_length是实例变量
    if defined?(@@number_of_squares)
      @@number_of_squares += 1 #类变量使用@@ 这里用来保存 当前的实例个数
    else
      @@number_of_squares=1
    end
  end
  
  def area
    @side_length * @side_length # 不用return返回，默认返回最后一个表达式的值
  end
  
  #实例方法 给对象调用的，可以与类方法重名 ,也可以访问并修改类变量
  def count
    @@number_of_squares+=1
    @@number_of_squares 
  end
  #类方法 前面加上 self，self表示当前类与java的this有些不同 也可以使用 
  # 也可以使用Square.count
  def self.count
    @@number_of_squares
  end

  #@@share_by_class可以在类之间访问
  def show_var_share_by_class
    puts "@@share_by_class可以在类之间访问"
    @@share_by_class
  end

end

square_a = Square.new(10)
square_b = Square.new(3)
puts "square of a = #{square_a.area}"
puts "square of b = #{square_b.area}"
puts "count of square = #{Square.count}"
puts "count of square by instance = #{square_b.count}"
puts "@@share_by_class可以在类之间访问 :#{square_b.show_var_share_by_class}"
#puts "count of square by instance = #{Square.number_of_squares}"

puts "\n ---继承--- ruby只能单继承"
class ParentClass
  attr_accessor :name
  def initialize
    @name = "qianqian"
  end
  
  def method1
    puts "method1 in parentclass"
  end
  
  def method2
    puts "method2 in parentclass"
  end
end

#继承需要使用< 来表示
class ChildClass  < ParentClass
  attr_accessor :age
  def initialize()
    super#调用父类的构造方法
    @age = 10  
  end
  
  def method2
    super  #调用上一级的相同的方法
    method1 #调用继承自父类的method1
    puts "method2 in childclass"
  end 
end

my_obj = ChildClass.new()
my_obj.method1 #method1 in parentclass
my_obj.method2 #method2 in childclass
puts "name = #{my_obj.name}"
puts "age = #{my_obj.age}"

#puts my_obj.is_instan
puts "---覆写现有类的方法---"
class String 
  def length  #复写String类的length方法
    10
  end
end

puts "aaaaaaaaaaaaaaaaaaaa".length #10


puts "---反射---"
str = "a"
puts "所有方法：#{str.methods.inspect}"

my_obj = ChildClass.new()
puts "所有的实例变量 ：#{my_obj.instance_variables.inspect}" #所有的实例变量 ：["@age", "@name"]


puts "---private public protected---"

class Person
  def initialize(age)
    @age = age
  end
  
  def is_child
    self.age < 18  
  end
  
  def age
    @age
  end
  
  #protected 的方法
  def age_difference_with(other_person)
    (self.age - other_person.age).abs
  end
  
  #private 表示只能在实例范围内访问
  private :is_child
  # 表明age可以在类的范围类访问 
  protected  :age
end

person1 = Person.new(10)
person2 = Person.new(20)
#验证protected方法
puts "age difference = #{person1.age_difference_with(person2)}"
#puts person1.age #报错  protected method `age' called for #<Person:0x44002f0 @age=10> (NoMethodError)


puts "---嵌套类---"
Pi = 10
class Drawing
  #Pi是常量 作用于只在类的范围类
  Pi = 3.1415
  def initialize
    @my_resource = "my resource"
  end

  class Line
    
  end
  
  class Circle
    def what_am_i
       puts "访问被嵌套的类的资源 #{@my_resource}"
      "this is a circle"
    end
  end
  
  #访问累内部类
  def self.give_me_a_circle
    Circle.new
  end
end

a = Drawing.give_me_a_circle
puts a.what_am_i
a = Drawing::Circle.new #可以这样访问内部类
puts a.what_am_i
puts "常量的作用于只在类的范围内"
puts Drawing::Pi
puts Pi



puts "---模块 module---"
#分别属于两个命名空间的方法
module NumberStuff
  def NumberStuff.random
    rand(1000)
  end
  
  class Ruler
    attr_accessor :length
    def initialize()
      @length =1
    end
  end
end

module LetterStuff
  def LetterStuff.random
    (rand(26)+65).chr
  end
  
  class Ruler
    attr_accessor :name
    def initialize()
      @name
    end
  end
end
  
puts NumberStuff.random
puts LetterStuff.random

r1 = NumberStuff::Ruler.new
r2 = LetterStuff::Ruler.new
#不会冲突
r1.length=10
r2.name="ruler"


puts "--include模块中的方法，include是将模块的内容放到当前作用域中--"
module UserfulFeathres
  def class_name
    self.class.to_s
  end
end

class Person1 
  include UserfulFeathres #把模块中的方法include到了Person1中
end
x = Person1.new()
puts x.class_name # Person1
puts x.methods.include?("class_name") #true

#即使不include到类中，也可以使用
include UserfulFeathres
puts class_name  #Object

# Enumerable模块
puts "---Enumerable模块 包含了 collect select min max 等20几种方法，可以在自己的类中引入Enumerable，但需要实现each方法---"
class AllVowels
  include Enumerable #我们的AllVowels类将拥有collect select 等方法了
  @@vowels = %w(a e i o u)
  def each
    @@vowels.each{|v| yield v}  #yield表示像代码块传递每隔元音字母
  end
end

vowels = AllVowels.new 
puts vowels.collect {|i| i+"x"}.inspect
puts vowels.select {|i| i > "e"}.inspect
puts vowels.sort().inspect
puts vowels.max.inspect


##Comparable模块 提供基本的比较运算如< > <= >= <=>和between?方法
puts "---Comparable---"
class Song
  include Comparable
  attr_accessor :length ,:song_name
  def initialize(song_name, length)
    @song_name = song_name
    @length = length
  end
  # 提供了这个方法后 ，Comparable会回根据这个方法提供 < > <= >=等运算了  
  def <=>(other)
    @length <=>other.length
  end
end


s1 = Song.new("s1",10)
s2 = Song.new("z2",15)
s3 = Song.new("s3",20)

puts s1 < s2
puts s2 <=> s3
puts s2.between?(s1,s3)

puts "---include的时候也会把类include进来---"
include LetterStuff

r = Ruler.new
r.name= "Ruler1"
puts r.instance_variables.inspect

##项目和沉程序库
puts "##项目和程序库"


puts %q{---从其他目录包含，load 和 require都可以节后绝对路径和本地路径
例如 require a 首先在本地路径中搜索a.rb,然后会在其他地方搜索 ruby搜索的路径
包含在$:中
  }
$:.each {|x| puts x}
puts "可以添加我们自定义的路径"
$: <<"./"
$:.each {|x| puts x}

#下面自能打印一个 hello from ruby_libs.rb 尽管require两次
# require "ruby11"
# require "ruby11"
# puts "require end"
# #load 每一次载入都重新处理
# load "./ruby_libs.rb"
# load "ruby_libs.rb"



puts "---有条件的包含代码---"
$debugmode = false
require "ruby_libs.rb" if $debugmode == true

#一口气可以require N个文件
#%w(c:/ d:/).each {|l| require l} 


#Struct用来创建专门存储数据的特殊类
Person2 = Struct.new(:name,:age)
andy = Person2.new("andy",28)
puts andy.name 
puts andy.age

  

## 异常
puts "###异常 使用raise 抛出异常   "
puts "---异常处理的原理是：当异常被抛出后，程序被挂起，然后从调用堆栈中向上找，对异常处理代码---"
def method(name)
  #raise 也可以不加参数 那会抛出一个 runtimeEror 但是这样不好
  raise ArgumentError,"no name present!" if name.empty?
end

#method('')


puts "---异常处理使用begin rescue end来 处理的"
begin
  method
rescue ArgumentError =>e
  puts "rescue a program from an ArgumentError "+e.inspect
rescue ZeroDivisionError => e
  puts "rescue a program from an ZeroDivisionError "+e.inspect
rescue => e #这个resucue用来处理没有被检查到的异常
  puts e.inspect
end



puts "---throw catch:ruby中的break,跳出代码块,当throw :finish 后 就会结束以:finish为参数的代码块"
def generate_num_excpet_3
  x = rand(1000)
  if x%10 == 3
    puts "throw when x = #{x}"
    throw :finish ##如果 没有地方catch :finish 则报错`throw': uncaught throw `finish11' (NameError)
  end
end

catch(:finish) do 
  1000.times{generate_num_excpet_3}
  puts "generate 1000 numbers without 123"  
end
puts "---单元测试:看看 MyUnitTest.rb---"

puts "标准输入输出"
print "请输入一行："
#a = gets #从命令行读取一行 
puts a 
print "请输入多行："
#a = readlines #从标准输入读取多行 以EOF结尾 Eclipse 中医ctrl+Z表示
puts a

puts "---文件操作---"
file = File.open("test.txt") 
puts file.class
puts "---File 的each 每次返回一行---"
file.each {|line| puts line}
file.close()

puts "---给each 传递一个参数作为行的分解符号---"
file = File.open("test.txt") 
file.each(",") {|line| puts line}
file.close()

puts "---file open 可以接受代码块，open将文件以 f 传递给 代码块 当代码块结束的时候， 会自动关闭这个这个文件---"
File.open("test.txt") {|f| 
  puts f.gets } 

#如果使用new的话就必须手动关闭这个文件
file1 = File.new("test.txt","r")
puts file1.gets
file1.close()

puts "--把所有行读入到一个数组中---"
puts File.open("test.txt").readlines().inspect

puts "---把文件内容全部读入到一个字符串中 立即关闭文件---"
text = File.read("test.txt")
puts text

puts "---也可以这样子读入所有的行,他会立即关闭文件--"
puts File.readlines("test.txt").inspect


puts "---文件的指针位置---"
f = File.open("test.txt")
puts "f.pos = #{f.pos}"
puts f.gets
puts "f.pos = #{f.pos}"
f.pos= 0 #修改pos继续读取的是上一行
puts f.gets


puts "---写文件---"
File.open("test1.txt","a+") do |f|  #如果文件不存在会自动生成的
    f.puts "add to the tail"  #file的puts是将文字写入到文件中 
end


puts "--平台无关性的文件名--"
puts File.join("a","b","c.txt")
puts File::SEPARATOR  #系统的分隔符号
puts "test.txt fullpath = #{File.expand_path("test.txt")}"

puts "------------迭代器------------"
puts "----map 同 collect----"
puts [1,2,3,4].map{|x| x+1} #2 3 4 5

puts "----collect 同 map----"
puts [1,2,3,4].collect{|x| x+1} #2 3 4 5

puts "----reject----"
puts [1,2,3,4].reject{|x| x > 3} #1 2 3


puts "----select----"
puts [1,2,3,4].select{|x| x > 3} #4


puts "----inject----"
#
#inject带有一个参数和block。block中的两个参数是有含义的。第一个参数reslut在inject第一次执行block时把inject带的参数付值给它，
# element就是数组中的元素，该例中inject一共执行4次block，每次执行block完后，最后语句的结果再付值给result，
# 如此循环，直到遍历数组中所有
#因为数组有4个元素，所以要执行4次block操作：
#
puts [1,2,3,4].inject(10){|result, element| result+element} #20

array = [1, 2, 3, 4, 5, 6].inject([]) do |result, element|
  result << element.to_s if element % 2 == 0
  result
end
puts array  #array  => ["2", "4", "6"]

puts "----------ruby中的* 表示将多个参数打包到一个数组中---------"
def max(*param)
  return param[0] + param[1]
end

puts max(1,2)

puts "------ruby中的&表示代码块------"
def min(a,b, &p)
  p.call(a,b)
end

min(1,2){|a,b| puts a+b }
min(1,2) do |a,b| puts a+b end


puts "------yield执行代码块------"
def call_block
  yield(1)
  yield(2)
  yield(3)
end

call_block { |i|
  puts "#{i}: Blocks are cool!"
}


puts "----参数尾巴的Hash可以省略{ }---"

def my_print(a, b, options)
  puts a
  puts b
  puts options[:x]
  puts options[:y]
  puts options[:z]
end

my_print("A", "B", { :x => 123, :z => 456 } )
my_print("A", "B", :x => 123, :z => 456) # 结果相同

puts true and false # 相当于 (puts true) and false
puts (true and false) #
puts false and true # 相当于 (puts false) and true
puts (false and true) # 相当于 puts (false and true)
puts  true && false # 相当于 puts (true && false)
puts true & false # 相当于 puts (true & false)

#retry 输出 012223
[1,2,3,4].each_with_index do |item,index|
  retrycount = 0
  abc = 10
  begin
    abc+=1
    puts  index
    puts abc;
    if index == 2
      a = 1/0;
    end
  rescue
    retrycount += 1
    if retrycount < 3
      retry #回到begin
    end
  end
end


puts %{
java 和 ruby之间的区别
 ruby使用require，java 使用 import,
 ruby的成员变量都是private的，java有public protected private的区别
 ruby中的一切都是对象，1，2.1这些都是对象。java 的false true 1，2不是对象，不够ruby彻底
 ruby 没有静态类型检查
 没有显示的类型转换，只要调用方法。应该用单元测试
 构造器只是initialize 不是类的名字
 不使用接口，使用混入mixins(将一个module混入到另一类中).
 nil代替null
}

puts "module 的两种作用"
puts "module的两个功能，第一个是用为命名空间"
module Trig
  Pi = 3.14
  def self.sin(x)
    puts "trig  sin 3.14"
  end
end


module Moral
  VERY_BAD = 0
  BAD = -1
  def self.sin(x)
    puts "moral sin x"
  end
end

include Trig
include Moral

Trig.sin("123")
Moral.sin(Moral::VERY_BAD)


puts  %{module的两个功能，第二个是在不同的类中使用module中共享的功能，叫做混入mixins java使用继承或者组合的方式得到其他功能
      Although every class is a module, the include method does not allow a class to be included within another class.}

module D
  def initialize(name)
    @name = name
  end

  def to_s
    @name
  end
end

module Debug
  include D

  def who_am_i?
    "#{self.class.name} {\##{self.object_id}}: #{self.to_s}"
  end
end

class Phonograph
  include Debug
end

class EightTrack
  include Debug
end

ph = Phonograph.new("JUNJUN")
et = EightTrack.new("LANLAN")

puts ph.who_am_i?
puts et.who_am_i?


puts "可变对象(mutable object)和不可变对象(immutable object)"
str = "A simple string"
str.freeze
begin
  str << "An attempt to modify. " #修改一个可变对象
rescue => e
  puts  "#{e.class} #{e}"
end

puts "str is #{str.frozen?}" #str没有
str += " modified"  # += 会返回一个新对象，并没有改变原来的对象，只是改变了str这个指向对象的指针
puts str  #A simple string modified
puts "str is #{str.frozen?}" #false str已经是另一个对象了，所以是mutable了


puts 'ruby的方法,定义方法'
def hello
  'hello'
end
puts hello

puts 'ruby的方法,使用方法的默认参数，但是只能从左向右指定,如果name1没有指定，name2使用不了默认值'
def hello1 (name1="noname1",name2="noname2")
  puts "hello #{name1} , #{name2}"
end
hello1("junjun") #hello junjun , noname2
hello1(name2="xiaolan") #hello xiaolan , noname2


puts "方法重命名"
def oldmtd
  "old method"
end

puts %"当一个方法重命名后 新名字会指向老方法的一个copy,当老方法重新定义后,不影响新方法
 alias creates a new name that refers to an existing method, operator, global variable, or
 regular expression backreference ($&, $`, $', and $+). Local variables, instance variables,
 class variables, and constants may not be aliased. The parameters to alias may be names or symbols."

alias newmtd oldmtd
newmtd_again = oldmtd

puts oldmtd #old method
puts newmtd #old method

#其实他们都是不同的对象了
puts oldmtd.object_id #70133163120280
puts newmtd.object_id #70133163120240

def oldmtd
  "old method improved"
end

puts oldmtd #old method improved
puts newmtd #old method 改了oldmtd 不影响 newmtd

#和alias效果一样
puts oldmtd.object_id #70163953507420
puts newmtd_again.object_id #70163953507620

puts "ruby方法传递多个参数"
puts  %{What is the sequence in which the parameters are put on to the stack?
        Left to right like C or right to left like Pascal?
        The answer is Left to right as you can see in this example p012mtdstack.rb
        参数放进栈的顺序是从左到又的}

def foo(a1="11",*my_string,a2)
  "a1 = #{a1} my_string = #{my_string.inspect} a2=#{a2}"
end

puts foo("hello","word","哈哈","a2")
puts foo("hello1")

puts "!方法 ?方法 带有?的方法叫做bang方法,表示这个方法很危险，他会直接修改一个变量指向的对象，也可以自己定义一个带!的方法，没有硬性要求
      ?方法一般返回true或者false 表示询问，比如 array的empty?就好像在问array'你是空的码'"

hello111 = "hello"
puts hello111.upcase #HELLO
puts hello111 #hello
puts hello111.upcase! #HELLO 会改变hello111指向的对象
puts hello111 #HELLO


#返回多个值
def abc
  return 1,2,3
end

a,b = abc
puts a
puts b


def isBlank?(str)
  return str.nil? || str.empty? || 0 == (str =~ /^\s*$/)
end

puts isBlank?(nil)
puts isBlank?("")
puts isBlank?("  ")
puts isBlank?(" aa ")

#String#scan
"123,123,234".scan(/\d+/) do |arg|
  puts arg
end

module TestModule
  class TestClass
    def self.test
      puts "test"
    end
  end

  TestModule::TestClass.test
end

TestModule::TestClass.test
puts "over"


abcd = {test:"abc"}
puts abcd

#ruby 排序
h = ['1','10','11','2','4']
p h.sort
p h.sort{|a,b| a.to_i <=> b.to_i}
p h.sort_by{|x| x.to_i}