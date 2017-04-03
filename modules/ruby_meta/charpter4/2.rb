class Object
  def eigenclass
    class << self; self; end
  end
end


puts "123".eigenclass