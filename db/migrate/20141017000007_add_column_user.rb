class AddColumnUser < ActiveRecord::Migration
  def change
    add_column(:users, :ticket_ids, :text)
  end
end
