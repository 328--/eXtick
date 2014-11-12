class TicketsController < ApplicationController 
  before_action(:set_ticket, only: [:show, :edit, :destroy])
  before_action(:set_user_id, only: [:edit])
  before_action(:set_user, only: [:edit, :new])

  
  # GET /tickets
  # GET /tickets.json
  def index
    @tickets = Ticket.order("created_at DESC").page(params[:page]).per(Ticket::PagenatePer)
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
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
  
  # GET /tickets/1/edit
  def edit
    @tags = @ticket.tags
  end
  
  # POST /tickets
  # POST /tickets.json
  def create
    param = params[:params]
    Ticket.transaction do
      @ticket = Ticket.new(ticket_params)
      
      @ticket.set_category(param[:categories])
      @ticket.set_tag(param[:tags])

      @ticket.save!
    end
    redirect_to(@ticket, notice: t('success_message'))
    rescue
    redirect_to(action: :new)
  end

  # PATCH/PUT /tickets/1
  def update
    param = params[:params]

    Ticket.transaction do
      @ticket.categories.delete_all
      @ticket.tags.delete_all
      
      @ticket.set_category(param[:categories])
      @ticket.set_tag(param[:tags])

      @ticket.update!(ticket_params)
    end
    redirect_to(@ticket, notice: 'Ticket was successfully updated.')
    rescue
    redirect_to(action: :edit)
  end

  # DELETE /tickets/1
  def destroy
    @ticket.destroy
    redirect_to(tickets_url, notice: 'Ticket was successfully destroyed.')
  end
  
  def search
    searched_tickets = nil
    case params[:tab_id]
    when "keyword"
      searched_tickets = Ticket.get_tickets(params[:target])
    when "tag"
      searched_tickets = Tag.get_tickets(params[:target], params[:method])
    end

    @searched_tickets = Kaminari.paginate_array(searched_tickets).page(params[:page]).per(Ticket::PagenatePer)

    respond_to do |format|
      format.html
      format.js
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
    params.require(:ticket).permit(:event_name, :datetime, :place, :price, :note, :user_id)
  end

end
