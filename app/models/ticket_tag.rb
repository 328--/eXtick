class TicketTag < ActiveRecord::Base
  belongs_to(:ticket)
  belongs_to(:tag)

  validates(:tag_id, uniqueness: {scope: :ticket_id})

    
  def self.uniq_ids
    return self.select(:tag_id).uniq.map{|tt| tt.tag_id}
  end

  def self.tag_cloud
    self.uniq_ids.map{|id| [Tag.find(id).name, self.where(tag_id: id).count]}.sort_by{|name,num| num}.reverse
  end

end
