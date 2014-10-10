class AddTagIdsToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :tag_ids, :text
  end
end
