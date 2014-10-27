class CreateTicketTags < ActiveRecord::Migration
  def change
    create_table :ticket_tags do |t|
      t.integer :ticket_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
