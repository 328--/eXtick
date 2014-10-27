class RemoveColumnsFromTickets < ActiveRecord::Migration
  def change
    remove_column :tickets, :category_id, :integer
    remove_column :tickets, :tag_ids, :text
    remove_column :tickets, :twitter_token, :string
  end
end
