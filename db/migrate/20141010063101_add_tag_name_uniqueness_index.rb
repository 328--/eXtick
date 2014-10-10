class AddTagNameUniquenessIndex < ActiveRecord::Migration
  def change
  end
  def self.up
    add_index :tags, :name, :unique => true
  end

  def self.down
    remove_index :tags, :name
  end
end
