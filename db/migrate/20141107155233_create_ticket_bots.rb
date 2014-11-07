class CreateTicketBots < ActiveRecord::Migration
  def change
    create_table :ticket_bots do |t|
      t.string :screen_name
      t.text :tweet_url
      t.text :tweet

      t.timestamps
    end
  end
end
