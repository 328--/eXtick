class Ticket < ActiveRecord::Base
  belongs_to(:user)

  has_many(:ticket_categorys)
  has_many(:categorys, through: :ticket_categorys)
  
  has_many(:ticket_tags)
  has_many(:tags, through: :ticket_tags)
  
end
