class Ticket < ActiveRecord::Base
  serialize :tag_ids
end
