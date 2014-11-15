class TicketTag < ActiveRecord::Base
  belongs_to(:ticket)
  belongs_to(:tag)

  validates(:tag_id, uniqueness: {scope: :ticket_id})

  def self.tag_cloud
    tags = self.includes(:tag).select(:tag_id).map{|tt| tt.tag.name}
    hash = Hash.new(0)
    tags.each{|x| hash[x]+=1}
    return hash.map{|name,num| [name,num]}.sort_by{|name,num| num}.reverse
  end
  
end
