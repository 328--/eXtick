class TicketBot < ActiveRecord::Base
  def self.create_with_status(status)
    create! do |ticketbot|
      ticketbot.screen_name = status.user.screen_name
      ticketbot.tweet_url = status.uri.to_s
      ticketbot.tweet = status.text.gsub(/^ *@Ticket_bot */,'')
    end
  end

  # search keyword for tweets
  def self.search_by_keyword(keyword)
    return self.where("tweet like ?", "%#{keyword}%").order("created_at DESC")
  end

  paginates_per 10
end
