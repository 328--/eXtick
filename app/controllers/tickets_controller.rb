class TicketsController < ApplicationController 
  before_action(:set_ticket, only: [:show, :edit, :update, :destroy])
  
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
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
    @id = User.get_user_id(session[:uid])
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

#    @ticket.categories << Category.find_by(id: param[:category_id])
    
    if @ticket.valid?
      param[:tags].to_s.split(",").uniq.each do |name|
        @ticket.tags <<  Tag.find_or_create_by(name: name.strip)
      end
      
      redirect_to(@ticket, notice: t('success_message'))
    else
      redirect_to :back
    end
    
  end

  # GET /tickets/myticket
  def myticket
    @tickets = Ticket.all.order("created_at DESC")
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
      TicketTag.delete_all("ticket_id = '#{@ticket.id}'")
      params[:params][:tags].to_s.split(",").uniq.each do |name|
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
    target = nil
    ticket_sel = nil

    case tab_id
    when "keyword"
      target = params[:target]
      ticket_sel = Ticket.arel_table[:event_name].matches("%#{target}%")
    when "tag"
      target = get_tag_id(params[:target])
      ticket_sel = Ticket.arel_table[:tag_ids].matches("%- #{target[0]}\n%")
      for i in 1...target.length
        ticket_sel = ticket_sel.or(Ticket.arel_table[:tag_ids].matches("%- #{target[i]}\n%"))
      end      
    end

    @searched_tickets = Ticket.where(ticket_sel).order("created_at DESC").page(params[:page]).per(Ticket::PagenatePer)

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

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:event_name, :datetime, :place, :price, :note, :user_id)
    end

    # get tag ID from tag name.
    def get_tag_id(tags)
      splits_tag = tags.to_s.split(",")
      tag_text = Tag.arel_table[:name]
      tag_sel = tag_text.matches("#{splits_tag[0]}")
      for i in 1...splits_tag.length
        tag_sel = tag_sel.or(tag_text.matches("#{splits_tag[i]}"))
      end
      tag_ids = []
      Tag.where(tag_sel).select(:id).each{|t|
        tag_ids << t.id.to_s
      }
      
      return tag_ids
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
