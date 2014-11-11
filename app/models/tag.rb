class Tag < ActiveRecord::Base
  has_many(:ticket_tags)
  has_many(:tickets, through: :ticket_tags)

  validates(:name, uniqueness: true)

  # get tickets from tags 
  def self.get_tickets(tags, method)
    tags = tags.split(",")
    tag_sel = self.arel_table[:name].eq(tags[0])
    for i in 1...tags.length
      tag_sel = tag_sel.or(self.arel_table[:name].eq(tags[i]))
    end

    tickets = []
    self.where(tag_sel).each do |t|
      tickets.concat(t.tickets)
    end

    case method
    when "or"
      return tickets.uniq
    when "and"
      return tickets.group_by{|i| i}.reject{|k,v| v.length < tags.length}.keys
    end
  end

end
