class UserController < ApplicationController
  # GET /user/myticket
  def myticket
    @tickets = Ticket.where(user_id: User.get_user_id(session[:uid]))
  end
end
