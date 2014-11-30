class TicketsController < ApplicationController 
  before_action(:set_ticket, only: [:edit, :update, :destroy])
  before_action(:set_user_id, only: [:edit])
  before_action(:set_user, only: [:edit, :new])

  
  # GET /tickets
  def index
    @tickets = Ticket.order("created_at DESC").page(params[:ticket_page])
    @tickets_bot = TicketBot.order("created_at DESC").page(params[:ticket_bot_page])
  end

  # GET /tickets/new
  def new
    # this user did not login.
    if @user.blank?
      redirect_to(action: :index)
    else
      @ticket = Ticket.new
    end
  end

  def show
    redirect_to(action: :index)
  end
  
  # GET /tickets/1/edit
  def edit
    @tags = @ticket.tags
  end
  
  # POST /tickets
  def create
    param = params[:params]
    Ticket.transaction do
      @ticket = Ticket.new(ticket_params)
      
      @ticket.set_category(param[:categories])
      @ticket.set_tag(param[:tags])

      @ticket.save!
    end
    redirect_to(@ticket, notice: t('create_success'))
    rescue
    redirect_to(action: :new)
  end

  # PATCH/PUT /tickets/1
  def update
    param = params[:params]

    Ticket.transaction do
      @ticket.ticket_categories.delete_all
      @ticket.ticket_tags.delete_all
      
      @ticket.set_category(param[:categories])
      @ticket.set_tag(param[:tags])

      @ticket.update!(ticket_params)
    end
    redirect_to(@ticket, notice: t('update_success'))
    rescue
    redirect_to(action: :edit)
  end

  # DELETE /tickets/1
  def destroy
    @ticket.destroy
    redirect_to(tickets_url, notice: t('destroy_success'))
  end
  
  def search
    if params[:search_ticket]
      @tickets = Ticket.search_by_keyword(params[:keyword])
      
      unless params[:tag].blank?
        @tickets = @tickets.search_by_tag(params[:tag], params[:method])
      end
      @title =  params[:tag].blank? && params[:keyword].blank? ? I18n.t("new_tickets") : I18n.t("search_result")
      @tickets = @tickets.page(params[:ticket_page])
    end
    if params[:search_ticket_bot]
      @bot_tickets = TicketBot.search_by_keyword(params[:keyword]).page(params[:ticket_bot_page])
      @bot_title =  params[:keyword].blank? ? I18n.t("ticket_bot_index") : I18n.t("ticket_bot_result")
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  private
  def set_ticket
    @ticket = Ticket.find(params[:id])
  end
  
  # set user id to @id.
  private
  def set_user_id
    @id = User.get_user_id(session[:uid])
  end
  
  # set user to @user.
  private
  def set_user
    @user = User.find_by(uid: session[:uid])
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  private
  def ticket_params
    params.require(:ticket).permit(:event_name, :datetime, :place, :price, :note, :user_id, :sell_or_exchange)
  end

end
