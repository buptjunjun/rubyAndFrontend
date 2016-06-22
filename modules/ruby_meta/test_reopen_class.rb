class TestClass
  def foo
    puts "foo1"
  end
end

TestClass.new.foo

if true
 class  TestClass
    def foo1
      puts "foo2"
    end
  end
end
TestClass.new.foo1
