class SessionController < ApplicationController
  def callback
    auth = request.env['omniauth.auth']
    user = User.find_by_provider_and_uid(auth[:provider], auth[:uid]) || User.create_with_omniauth(auth)

    # check token. if provided token and secret != db's token and secret, update db.
    if (user.token != auth.credentials.token) || (user.secret != auth.credentials.secret)
      user.update(token: auth.credentials.token, secret: auth.credentials.secret)
    end
    session[:uid] = user.uid
    session[:name] = user.screen_name
    redirect_to(controller: "tickets")
  end
  
  def destroy
    reset_session
    redirect_to root_path
  end
end
