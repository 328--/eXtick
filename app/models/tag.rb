class Tag < ActiveRecord::Base
  has_many(:ticket_tags)
  has_many(:tickets, through: :ticket_tags)

  validates(:name, uniqueness: true)

  # get tickets from tags 
  def self.get_tickets(tags, method)
    tags = tags.split(",")
    tag_sel = self.arel_table[:name].eq(tags[0])
    for i in 1...tags.length
      if method == "or" then
        tag_sel = tag_sel.or(self.arel_table[:name].eq(tags[i]))
      elsif method == "and" then
        tag_sel = tag_sel.and(self.arel_table[:name].eq(tags[i]))
      end
    end
    tickets = []
    self.where(tag_sel).each do |t|
      tickets.concat(t.tickets)
    end
    return tickets
  end
end
