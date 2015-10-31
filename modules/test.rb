require 'rubygems'
require 'active_record'
require 'yaml'
require 'logger'


s = "abcd<p></p><img src=x onerror=alert(/xss/) />test";
s1 = "abcd<img src=x />test";
s2 = "你好sss"
s3 = '<img title="Love" alt="Love" src="http://tv.baicizhan.com/bczbqplugin/imgs/tsj/t_0025.gif" style="font-size: 14px; color: rgb(0, 0, 0); line-height: 22.5px;">'

puts s2 =~ /\w*(<img src=)*/
(title='.*')