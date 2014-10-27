class TicketCategory < ActiveRecord::Base
  belongs_to(:ticket)
  belongs_to(:category)
end
