#encoding:utf-8

#&my_proc
names = ["ada","bachalor","crystal"]
a =  names.map{|item|item.capitalize}
puts a.inspect

b =  names.map(&:capitalize.to_proc)
puts b.inspect

c =  names.map(&:capitalize)
puts c.inspect