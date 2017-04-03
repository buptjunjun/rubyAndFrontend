


class MyClass
  @a = 1
  def self.n

  end

  def m

    @c = 3
    @@b = 2
    binding
  end

end


m1 = MyClass.new
b1 = m1.m
puts b1

eval("puts @c",b1)
eval("puts @@b",b1)
eval("puts @a",b1)


s = <<ABC
f = File.new("/tmp")
gets
ABC
$SAFE = 2
eval(s)

