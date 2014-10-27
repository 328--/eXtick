class Category < ActiveRecord::Base
  has_many(:ticket_categorys)
  has_many(:tickets, through: :ticket_categorys)
  
  validates :name, :uniqueness => true
end
