class Ticket < ActiveRecord::Base
  belongs_to(:user)

  has_many(:ticket_categories, dependent: :destroy)
  has_many(:categories, through: :ticket_categories)
  accepts_nested_attributes_for(:categories)
  
  has_many(:ticket_tags, dependent: :destroy)
  has_many(:tags, through: :ticket_tags)
  accepts_nested_attributes_for(:tags)

end
