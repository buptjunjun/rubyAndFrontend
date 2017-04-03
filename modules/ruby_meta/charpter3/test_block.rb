#encoding:utf-8

@ab = 1
class Utils

  def self.test
    aa= 3
    puts local_variables
  end

  def self.get_runnable_code(code)
    #eval ("lambda {#{code}}")
    p = Proc.new { puts self; puts local_variables;  }
  end
end

x = 1
y = 1
def my_method
  y = 2
  yield(y)
end

my_method do |y|
  x = 3
end

def test123(code)
#puts Utils.test

  proc =  eval ("lambda {#{code}}")

end


abcd=111
#p = Proc.new {puts self; puts local_variables;abcd+=111; puts abcd;puts 1212 }


puts p.inspect
puts "---"
local_variables
instance_eval {puts local_variables}
b = self.send :binding
puts p.to_s
eval(p.to_s,b)


def test_binding(binding)
  aacc = 1
  eval("abcd+=1212; puts abcd; puts @ab; ;",binding)
end

test_binding(send :binding)






