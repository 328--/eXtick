class Tag < ActiveRecord::Base
  has_many(:ticket_tags)
  has_many(:tickets, through: :ticket_tags)

  validates(:name, uniqueness: true)

  def get_name
    name = []
    self.each do |tag|
      name << tag.name
    end
    return name
  end
end
