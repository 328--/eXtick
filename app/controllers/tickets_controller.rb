class TicketsController < ApplicationController 
  before_action(:set_ticket, only: [:show, :edit, :update, :destroy])
  before_action(:set_tag, only: [:create, :update])
  
  # GET /tickets
  # GET /tickets.json
  def index
    @tickets = Ticket.all.order("created_at DESC")
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
  end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)
    @ticket[:tag_ids] = @tags
    puts ticket_params
    
    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
    ticket_formated = ticket_params
    ticket_formated["tag_ids"] = @tags
      if @ticket.update(ticket_formated)
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
    @searched_tickets = Ticket.where('event_name like ?', "%"+params[:search_item]+"%")
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
      @ticket[:tag_ids] = get_tag_name(@ticket.tag_ids)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:event_name, :datetime, :place, :price, :twitter_token, :category_id, :tag_ids)
    end

    def set_tag
      splits_tag = ticket_params[:tag_ids].to_s.split(",")
      tag_name = []
	splits_tag.each{|n|
	  tag_name << Tag.new(:name => n)
	}	
      Tag.import tag_name
      tag_text = Tag.arel_table[:name]
      tag_sel = tag_text.matches("#{splits_tag[0]}")
      for i in 1...splits_tag.length
        tag_sel = tag_sel.or(tag_text.matches("#{splits_tag[i]}"))
      end
      @tags = []
      Tag.where(tag_sel).select(:id).each{|t|
        @tags << t.id
      }	
    end

    def get_tag_name(tags)
      tag_names = "" 
      if !tags.blank?
        Tag.find(tags).each{|t|
          tag_names << "#{t.name},"
        }
      end

      return tag_names
    end

end
