#encoding:utf-8

class Myclass

  attr_accessor :v
  v = 1
  puts local_variables

  def my_method
    @v = 1
    v2 = 1

    puts local_variables
  end

  puts local_variables
end


obj = Myclass.new
obj.my_method

obj.instance_eval do
  @v = 3
end

puts obj.v

v3 = 10
obj.instance_exec(1,2,3) do |a, b, c|
  @v = v3+a+b+c
end

puts obj.v

inc = Proc.new {|x|x+1}

puts inc.call(2)

dec = lambda{|x| x-1}

puts dec.call(2)


func = eval  "lambda { " + "|a,b| a+b+1" + " }"

puts func.call(1,2)

proc1 = lambda {return 10}
proc2 = Proc.new {10}
proc3 = Proc.new {next 10}
proc3 = Proc.new {next 10}


def double(&proc)
  b = proc.call
  puts b
  return "ok"
end

puts double(&proc1)
puts double(&proc2)
#puts double(&proc3)


#proc.bind(obj)

#你好


def foo1
  proc = lambda{ "foo1"}
  info = proc.call() +" hello"
  return info
end


def foo2
  proc = lambda{ return "foo2"}
  info = proc.call() +" hello"
  return info
end


def foo3
  proc = Proc.new(){ next "foo3"}
  info = proc.call() +" hello"
  return info
end


def foo4
  proc = Proc.new{ return "foo4"}
  info = proc.call()  +" hello"
  return info
end



puts foo1()
puts foo2()
puts foo3()
puts foo4()

[1,2,3].each do |item|
  if item == 2
    next
  end

  print "#{item}  "
end
puts

[1,2,3].each do |item|
  if item == 2
    break
  end

  print "#{item}  "
end
puts

[1,2,3].each do |item|
  if item == 2
    return
  end

  print "#{item}  "
end
