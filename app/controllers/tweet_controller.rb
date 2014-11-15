class TweetController < ApplicationController
  def reply
    if session[:name]
      twitter = User.find_by(uid: session[:uid]).init_twitter
      twitter.update(params[:message])
    end
    redirect_to root_path
  end

end
