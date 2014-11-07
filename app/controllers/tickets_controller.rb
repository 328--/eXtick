class TicketsController < ApplicationController 
  before_action(:set_ticket, only: [:show, :edit, :update, :destroy])
  before_action(:set_user_id, only: [:edit, :update])
  before_action(:set_user, only: [:edit, :new, :update, :create])

  
  # GET /tickets
  # GET /tickets.json
  def index
    @tickets = Ticket.order("created_at DESC").page(params[:page]).per(Ticket::PagenatePer)
    @ticket = Ticket.new
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
    @ticket = Ticket.create(ticket_params)
    
    if @ticket.valid?
      param[:categories].each do |id|
        @ticket.categories << Category.find_by(id: id)
      end

      param[:tags].split(",").uniq.each do |name|
        @ticket.tags <<  Tag.find_or_create_by(name: name.strip)
      end
      
      redirect_to(@ticket, notice: t('success_message'))
    else
      redirect_to(action: :new)
    end
    
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    param = params[:params]

    TicketCategory.transaction do
      TicketCategory.delete_all(ticket_id: @ticket.id)
      if param[:categories]
        param[:categories].each do |id|
          @ticket.categories << Category.find_by(id: id)
        end
      end
    end
    
    TicketTag.transaction do
      TicketTag.delete_all(ticket_id: @ticket.id)
      param[:tags].split(",").uniq.each do |name|
        @ticket.tags <<  Tag.find_or_create_by(name: name.strip)
      end
    end
    
    if @ticket.update(ticket_params)
      redirect_to(@ticket, notice: 'Ticket was successfully updated.')
    else
      redirect_to(action: :edit)
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    redirect_to(tickets_url, notice: 'Ticket was successfully destroyed.')
  end
  
  def search
    tab_id = params[:tab_id]
    target = params[:target]
    searched_tickets = nil

    case tab_id
    when "keyword"
      ticket_sel = Ticket.arel_table[:event_name].matches("%#{target}%")
      searched_tickets = Ticket.where(ticket_sel).order("created_at DESC").page(params[:page]).per(Ticket::PagenatePer)
    when "tag"
      tags = params[:target].split(",")
      tag_sel = Tag.arel_table[:name].eq(tags[0])
      for i in 1...tags.length
        tag_sel = tag_sel.or(Tag.arel_table[:name].eq(tags[i]))
      end
      tickets = []
      Tag.where(tag_sel).order("created_at DESC").each do |t|
        tickets.concat(t.tickets)
      end
      searched_tickets = Kaminari.paginate_array(tickets.uniq).page(params[:page]).per(Ticket::PagenatePer)
    end

    @searched_tickets = searched_tickets
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_ticket
    @ticket = Ticket.find(params[:id])
  end
  
  # set user id to @id.
  def set_user_id
    @id = User.get_user_id(session[:uid])
  end
  
  # set user to @user.
  def set_user
    @user = User.find_by(uid: session[:uid])
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def ticket_params
    params.require(:ticket).permit(:event_name, :datetime, :place, :price, :note, :user_id)
  end
end
