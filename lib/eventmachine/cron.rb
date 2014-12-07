require 'clockwork'
require_relative '../../config/environment'

module Clockwork

  handler do |job|
    case job
    when 'ticket_bot_tweet_delete'
      day = Date::today-14
      TicketBot.destroy_all(["created_at <= ? ",day])
    when 'auto_ticket_delete'
      day = Date::today-30
      Ticket.destroy_all(["datetime <= ? ", day])
    end
  end

  every(1.day, 'ticket_bot_tweet_delete', :at => '05:00')
  every(1.day, 'ticket_delete', :at => '05:30')
end
