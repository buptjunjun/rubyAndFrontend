require 'rubygems'
require 'active_record'
require 'yaml'
require 'logger'

#数据库建立连接,datable.yml是配置文件
dbconfig = YAML::load(File.open('database.yml'))

ActiveRecord::Base.establish_connection(dbconfig)
ActiveRecord::Base.logger = Logger.new(File.open('database.log', 'a'))
class User < ActiveRecord::Base
  self.table_name = "user"
end

puts User.find(1).name