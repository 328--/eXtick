require 'tweetstream'
require_relative '../../config/environment'

TweetStream.configure do |config|
  config.consumer_key       = Settings.twitter.consumer_key
  config.consumer_secret    = Settings.twitter.consumer_secret
  config.oauth_token        = Settings.twitter.access_token_key
  config.oauth_token_secret = Settings.twitter.access_token_secret
  config.auth_method        = :oauth
end


EM.run do
  TweetStream::Client.new.follow(329071124) do |status|
    TicketBot.create_with_status(status)
  end
end
