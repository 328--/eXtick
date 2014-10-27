class CreateTicketCategories < ActiveRecord::Migration
  def change
    create_table :ticket_categories do |t|
      t.integer :ticket_id
      t.integer :category_id

      t.timestamps
    end
  end
end
