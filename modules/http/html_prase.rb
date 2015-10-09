#encoding:utf-8

require 'uri'
require 'net/http'

#连接
uri = URI('http://www.iteye.com')

#代理
proxy_addr = '58.220.10.7'
proxy_port = 80

#打开一个连接,并设置代理
http = Net::HTTP.new(uri.host, nil, proxy_addr, proxy_port);

http.read_timeout=10 #设置读取超时时间
http.open_timeout=10 #设置链接超时时间

res = http.start { |http|
  request = Net::HTTP::Get.new uri
  request['User-Agent'] = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.93 Safari/537.36"
  request["Accept-Language"]="en-US,en;q=0.8,zh-CN;q=0.6,zh;q=0.4"
  response = http.request request # Net::HTTPResponse object
  #puts response.body
}
puts res.code #http staus
puts res.body #内容
