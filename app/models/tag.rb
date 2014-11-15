class Tag < ActiveRecord::Base
  has_many(:ticket_tags)
  has_many(:tickets, through: :ticket_tags)

  has_many(:user_tags)
  has_many(:tags, through: :user_tags)

  validates(:name, uniqueness: true)
end
