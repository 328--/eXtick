class UserController < ApplicationController
  # GET /user/myticket
  def myticket
    @tickets = Ticket.where(user_id: User.get_user_id(session[:uid]))
  end

  def watch_tag
    @user = User.includes(:tags).find_by(uid: session[:uid])
    @register_tags = @user.tags.map(&:id)
    @tags = Tag.all
  end

  def update
    User.transaction do
    end  
  end
end
