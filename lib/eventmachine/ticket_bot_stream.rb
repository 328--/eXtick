require_relative '../../config/environment'

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

client.follow(329071124) do |status|
   puts "#{status.text}"
  unless status.retweet?
    TicketBot.create_with_status(status)
  end
end
