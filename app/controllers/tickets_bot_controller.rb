class TicketsBotController < ApplicationController

  # GET /tickets
  def index
    @tickets_bot = TicketBot.order("created_at DESC").page(params[:page])
  end




end
