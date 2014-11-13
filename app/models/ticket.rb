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
  paginates_per 10
  
  def tag_strings
    return tags.map{|t| t.name}.join(',')
  end

  # get tickets from keyword(event name)
  def self.get_tickets(keyword)
    ticket_sel = self.arel_table[:event_name].matches("%#{keyword}%")
    tickets = self.where(ticket_sel).order("created_at DESC")
    return tickets.uniq
  end
  
  def set_category(ids)
    if ids
      ids.each do |id|
        self.categories.append(Category.find_by(id: id))
      end
    end
  end

  def set_tag(names)
    if names
      names.split(",").uniq.each do |name|
        if tag = Tag.find_by(name: name.strip)
          self.tags.append(tag)
        else
          self.tags.build(name: name.strip)
        end
      end
    end
  end

end
