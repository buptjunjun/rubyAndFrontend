module M1
  def method(param)
    puts "method in M1 #{param}"
  end
end


module M2
  include M1
  def method
    super("lalal")
    puts "method in M2"
  end
end

obj = Object.new
obj.extend(M2)

obj.method



