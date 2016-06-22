module M1

  C = 10

  def method(param)
    puts "method in M1 #{param}"
  end
end


module M2
  include M1
  def method
    super("lalal")
    puts "method in M2"
    puts C
  end
end

module M3
  extend M1
end

obj = Object.new
obj.extend(M2)

obj.method("爱啦啦")


M3.method("m3 哈哈")
puts M3::C
