class RemoveColumnsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :ticket_ids, :text
  end
end
