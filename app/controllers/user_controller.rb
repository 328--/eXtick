class UserController < ApplicationController
  # GET /user/myticket
  def myticket
    @tickets = Ticket.where(user_id: get_user_id(session[:uid]))
  end
  
  private
  begin

    # get user ID from uid
    def get_user_id(uid)
      return User.find_by(uid: uid).id
    end

  end
end
