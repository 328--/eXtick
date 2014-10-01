class SessionController < ApplicationController
  def callback
    auth = request.env['omniauth.auth']
    session[:name] = auth['info']['nickname']
    session[:url] = auth['info']['urls']
    session[:twitter_token] = auth['credentials']['token']
    redirect_to :controller => 'tickets'
  end
  
  def destroy
    reset_session
    redirect_to root_path
  end
end
