class Ticket < ActiveRecord::Base
  validate :ticket_validation

  def ticket_validation
    if event_name.empty?
      errors.add(:event_name, "can't be blank")
    end
    
  end

  belongs_to(:user)

  has_many(:ticket_categories, dependent: :destroy)
  has_many(:categories, through: :ticket_categories)
  accepts_nested_attributes_for(:categories)
  
  has_many(:ticket_tags, dependent: :destroy)
  has_many(:tags, through: :ticket_tags)
  accepts_nested_attributes_for(:tags)
  PagenatePer = 10
  
  def tag_strings
    return tags.map{|t| t.name}.join(',')
  end

  # get tickets from keyword(event name)
  def self.get_tickets(keyword)
    ticket_sel = self.arel_table[:event_name].matches("%#{keyword}%")
    tickets = self.where(ticket_sel).order("created_at DESC")
    return tickets.uniq
  end
  
end
