class BaseController < ActionController::Base
  protect_from_forgery

  def login_required
    unless session[:name]
      redirect_to root_path
    end
  end

end
