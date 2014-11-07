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
      redirect_to action: :index
    else
      @ticket = Ticket.new
      @tags = ""
    end
  end
  
  # GET /tickets/1/edit
  def edit
    tag_ids = []
    TicketTag.where(ticket_id: @ticket.id).select("tag_id").each do |model|
      tag_ids << model.tag_id
    end
    @tags = get_tag_name(tag_ids)
  end

  # POST /tickets
  # POST /tickets.json
  def create
    param = params[:params]
    @ticket = Ticket.create(ticket_params)
    @tags = param[:tags]
#    @ticket.categories << Category.find_by(id: param[:category_id])
    
    if @ticket.valid?
      Array(param[:categories]).each do |id|
        @ticket.categories << Category.find_by(id: id)
      end

      param[:tags].split(",").uniq.each do |name|
        @ticket.tags <<  Tag.find_or_create_by(name: name.strip)
      end
      
      redirect_to(@ticket, notice: t('success_message'))
    else
      render :new
    end
    
  end

  # GET /tickets/myticket
  def myticket
    @tickets = Ticket.all.order("created_at DESC")
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    param = params[:params]
    @tags = param[:tags]

    respond_to do |format|
      TicketCategory.delete_all("ticket_id = '#{@ticket.id}'")
      Array(params[:params][:categories]).each do |id|
        @ticket.categories << Category.find_by(id: id)
      end

      TicketTag.delete_all("ticket_id = '#{@ticket.id}'")
      param[:tags].split(",").uniq.each do |name|
        @ticket.tags <<  Tag.find_or_create_by(name: name.strip)
      end

      if @ticket.update(ticket_params)
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
    
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
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
      Tag.where(tag_sel).order("created_at DESC").each{|t|
        tickets.concat(t.tickets)
      }
      searched_tickets = Kaminari.paginate_array(tickets.uniq).page(params[:page]).per(Ticket::PagenatePer)
    end

    @searched_tickets = searched_tickets
    respond_to do |format|
      format.html
      format.js
    end
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
    
    # get tag name from tag ID.
    def get_tag_name(tags)
      tag_names = ""
      if !tags.blank?
        Tag.find(tags).each{|t|
          tag_names << "#{t.name},"
        }
      end
      if !tag_names.blank?
        tag_names.chop!
      end
      return tag_names
    end  

  end
