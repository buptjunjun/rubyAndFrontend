#encoding:utf-8
require 'twitter'
require 'json'

consumerKey="fY7YfMdoW3vhbTxCxepQ"
consumerSecret="1Ywv34rGji5eesVFVgsO7S49NQqeKL4B941knZfQ"
accessToken="183513683-yDxOFqbVB0r1uTWs6W0I3zQNRfLoLcKmssbvswEI"
accessTokenSecret="DQoRWhjfP2Cdzj4YAqLHyYDmvFQxKIosXGy9OUgxhzs"

client = Twitter::REST::Client.new do |config|
  config.consumer_key        =  consumerKey
  config.consumer_secret     = consumerSecret
  config.access_token        =  accessToken
  config.access_token_secret =  accessTokenSecret
end

#当前登录的用户的tweets
#tweets = client.home_timeline

tweets = client.user_timeline("autocorrects")
tweets.each do |t|
  # user = User.new
  # u = t.user

  #是否是转发的
  if t.retweeted?
    r = t.retweeted_status
    puts "retweeted :#{t.retweeted_status}"
  end

  #这条微博里面的多媒体
  if t.media and t.media.size != 0
      t.media.each  do  |m|
        puts "m:"+m.media_url
      end
  end

  #全文
  puts t.full_text

  puts t.attrs
  puts "---"
end

