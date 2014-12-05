require_relative '../../config/environment'

cli = Twitter::REST::Client.new do |config|
  config.consumer_key        = Settings.twitter.consumer_key
  config.consumer_secret     = Settings.twitter.consumer_secret
  config.access_token        = Settings.twitter.access_token_key
  config.access_token_secret = Settings.twitter.access_token_secret
end

TweetStream.configure do |config|
  config.consumer_key       = Settings.twitter.consumer_key
  config.consumer_secret    = Settings.twitter.consumer_secret
  config.oauth_token        = Settings.twitter.access_token_key
  config.oauth_token_secret = Settings.twitter.access_token_secret
  config.auth_method        = :oauth
end

client = TweetStream::Client.new

client.on_inited do
  puts "Connected"
end

client.on_reconnect do |timeout, retries|
  puts "reconnecting"
end

client.on_error do |message|
  puts message
end

client.on_event(:follow) do |event|
  fan = event[:source][:screen_name]
  cli.follow(fan)
  puts "follow : "+fan
end

client.userstream
