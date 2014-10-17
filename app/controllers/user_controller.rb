class UserController < ApplicationController
  # GET /user/myticket
  def myticket
    @tickets = Ticket.all.order("created_at DESC")
  end
end
