#encoding:utf-8

require 'uri'
require 'net/http'
require 'nokogiri'

html =  IO.read(File.open(File.expand_path("../files/iteye.html",__FILE__)))
doc = Nokogiri::HTML(html)
#删除javascirpt代码和css代码

doc.search("script").remove
doc.search("style").remove

# 获取页面上所有的链接
doc.css('a').each do |link|
  puts "#{link.content}, #{link['href']}"
end

puts doc.css("body")[0].content;

#打出 meta-keywords
puts doc.css('meta[name="keywords"]')[0]


require 'uri'

# The URL of the page with the links
page_url = 'http://foo.com/zee/zaw/zoom.html'

# A variety of links to test.
hrefs = %w[
  http://zork.com/             http://zork.com/#id
  http://zork.com/bar          http://zork.com/bar#id
  http://zork.com/bar/         http://zork.com/bar/#id
  http://zork.com/bar/jim.html http://zork.com/bar/jim.html#id
  /bar                         /bar#id
  /bar/                        /bar/#id
  /bar/jim.html                /bar/jim.html#id
  jim.html                     jim.html#id
  ../jim.html                  ../jim.html#id
  ../                          ../#id
  #id
]

hrefs.each do |href|
  root_href = URI.join(page_url,href).to_s
  puts "%-32s -> %s" % [ href, root_href ]
end
