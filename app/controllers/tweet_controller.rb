class TweetController < ApplicationController
  def update
    if session[:name]
      user = User.find_by(uid: session[:uid])
      twitter = Twitter::REST::Client.new do |config|
        config.consumer_key = Settings.twitter.consumer_key
        config.consumer_secret = Settings.twitter.consumer_secret
        config.access_token = user.token
        config.access_token_secret = user.secret
      end
      twitter.update(params[:message])
    end
    redirect_to root_path
  end
end
