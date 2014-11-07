require 'tweetstream'
require 'pg'
require 'active_record'
require_relative '../../config/environment'

ActiveRecord::Base.establish_connection(
    adapter: 'postgresql',
    host: ENV['DB_HOSTNAME'],
    database: ENV['DB_NAME'],
    user: ENV['DB_USER_NAME'],
    password: ENV['DB_PASSWORD'],
)


TweetStream.configure do |config|
  config.consumer_key       = ENV["TWITTER_CS_KEY"]
  config.consumer_secret    = ENV["TWITTER_CS_SEC"]
  config.oauth_token        = ENV["TWITTER_AT_KEY"]
  config.oauth_token_secret = ENV["TWITTER_AT_SEC"]
  config.auth_method        = :oauth
end


EM.run do
  TweetStream::Client.new.follow(329071124) do |status|
    puts "#{status.text}"
    p "--------------"
    puts "#{status.user.screen_name}"
    p "--------------"
    puts "https://twitter.com/#{status.user.screen_name}/status/#{status.id}"
    p "--------------"
  end
end
