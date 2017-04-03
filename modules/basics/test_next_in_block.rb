



def foo()

end


def iterate(a)

  yield(a) if block_given?

end



[1,2,3].each do |i|
  iterate(i) do |item|

    next if i == 2
    puts "item=#{item}"

  end
end