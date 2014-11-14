class TicketBot < ActiveRecord::Base
  def self.create_with_status(status)
    create! do |ticketbot|
      ticketbot.screen_name = status.user.screen_name
      ticketbot.tweet_url = status.uri.to_s
      ticketbot.tweet = status.text
    end
  end

  paginates_per 10
end
