require 'rubygems'
require 'active_record'
require 'yaml'
require 'logger'

#数据库建立连接,datable.yml是配置文件
dbconfig = YAML::load(File.open('database.yml'))

ActiveRecord::Base.establish_connection(dbconfig)
ActiveRecord::Base.logger = Logger.new(File.open('database.log', 'a'))
class FetchProjectTaskUserStrategy < ActiveRecord::Base
  establish_connection "development"
  self.table_name = "fetch_project_task_user_strategy"
end

class Key
  attr_accessor project_id, task_id, user_id, type
  def key
    return "#{project_id}_#{task_id}_#{user_id}_#{type}"
  end
end

data_map = {}

all_data = FetchProjectTaskUserStrategy.all
all_data.each do |data|
  key = Key.new
  key.project_id = data.project_id
  key.task_id = data.task_id
  key.user_id = data.user_id
  key.type = data.type

  if data_map[key] == nil
    data_map[key] = [data]
  else
    data_map[key] << data
  end
end

puts data_map