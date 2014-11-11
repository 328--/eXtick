class TicketBot < ActiveRecord::Base
  def self.create_with_status(status)
    create! do |ticketbot|
      ticketbot.screen_name = status.user.screen_name
      ticketbot.tweet_url = "https://twitter.com/#{status.user.screen_name}/status/#{status.id}"
      ticketbot.tweet = status.text
    end
  end
end
