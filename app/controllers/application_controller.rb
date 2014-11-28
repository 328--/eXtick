class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404  
  unless Rails.env.development?
    rescue_from Exception, with: :render_500
  end

  def render_404
    render status: 404, template: "errors/404"
  end

  def render_500
    render status: 500, template: "errors/500"
  end

end
