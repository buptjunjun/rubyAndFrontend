require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'
include Capybara::DSL


proxy_addr = '58.220.10.7'
proxy_port = 8012

Capybara.current_driver = :poltergeist

Capybara.register_driver :poltergeist do |app|
  #不下载图片
  options = {
      phantomjs_options: ['--load-images=no']
  }

  #设置超时时间
  Capybara::Poltergeist::Driver.new(app, timeout: 10)

end

session1 = Capybara::Session.new(:poltergeist)

#if session1.driver.respond_to?('agent') # mechanize only
  session1..driver.browser.set_proxy(proxy_addr, proxy_port)
  puts "Using proxy #{proxy_addr} #{proxy_port} from env"
#end

session1.visit('http://www.baidu.com')
puts "--------------"
puts(session1.html)

session2 = Capybara::Session.new(:poltergeist)
session2.visit('http://localhost:3000/jstest/jquery')
puts(session2.html)