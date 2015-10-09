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
