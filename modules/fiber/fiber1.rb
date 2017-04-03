# encoding: UTF-8
require 'fiber'

f = Fiber.new do
  sleep(2)
  p "hello"
end

p f.alive? #true
f.resume #"hello" 执行协程
p f.alive? #false
#f.resume #in `resume': dead fiber called (FiberError)

#fiber 不能跨线程 只能在同一个线程中调
 # f = nil
 # Thread.new do
 #     f = Fiber.new{}
 #   end.join
 # f.resume #in `resume': fiber called across threads (FiberError)
 #

#yield 就是将一个正在执行的fiber挂起，然后将控制权交给他的调用者

f = Fiber.new do
  p 1
  Fiber.yield
  p 2
  Fiber.yield
  p 3
end

f.resume
sleep(3)
f.resume
f.resume