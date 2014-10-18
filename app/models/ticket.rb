class Ticket < ActiveRecord::Base
  belongs_to :user

  serialize :tag_ids
end
