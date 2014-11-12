class TicketBot < ActiveRecord::Base
  def self.create_with_status(status)
    create! do |ticketbot|
      ticketbot.screen_name = status.user.screen_name
      ticketbot.tweet_url = status.uri
      ticketbot.tweet = status.text
    end
  end
end
