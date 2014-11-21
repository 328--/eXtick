require 'clockwork'
require_relative '../../config/environment'

module Clockwork

  handler do |job|
    case job
    when 'ticket_bot_tweet_delete'
      day = Date::today-4
#      day = Date::today-7
      TicketBot.destroy_all(["created_at <= ? ",day])
    end
  end

#  every(1.day, 'ticket_bot_tweet_delete', :at => '05:00')
  every(10.second, 'ticket_bot_tweet_delete')
end
