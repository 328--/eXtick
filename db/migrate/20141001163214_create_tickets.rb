class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :event_name
      t.datetime :datetime
      t.string :place
      t.integer :price
      t.string :twitter_token

      t.timestamps
    end
  end
end
