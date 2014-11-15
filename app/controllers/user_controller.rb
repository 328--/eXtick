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
      user = User.includes(:tags).find_by(uid: session[:uid])

      user.user_tags.delete_all

      user.set_tag(params[:tags])

      user.save!
    end
    redirect_to(root_path)
    rescue
    redirect_to(action: "watch_tag")
  end

end
