class Category < ActiveRecord::Base
  has_many(:ticket_categories)
  has_many(:tickets, through: :ticket_categories)
  
  validates :name, :uniqueness => true
end
