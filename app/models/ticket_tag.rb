class TicketTag < ActiveRecord::Base
  belongs_to(:ticket)
  belongs_to(:tag)

  validates(:tag_id, uniqueness: {scope: :ticket_id})
end
