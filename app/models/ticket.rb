class Ticket < ActiveRecord::Base
  validate :ticket_validation

  def ticket_validation
    if event_name.empty?
      errors.add(:event_name, "can't be blank")
    end
    
  end

  belongs_to(:user)

  has_many(:ticket_categories, dependent: :destroy)
  has_many(:categories, through: :ticket_categories)
  accepts_nested_attributes_for(:categories)
  
  has_many(:ticket_tags, dependent: :destroy)
  has_many(:tags, through: :ticket_tags)
  accepts_nested_attributes_for(:tags)
  PagenatePer = 10

  def tags
    super.tap do |c|
      c.class_eval do
        def get_name
          name = []
          self.each do |tag|
            name << tag.name
          end
          return name
        end
      end
    end
  end
end
