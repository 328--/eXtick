class User < ActiveRecord::Base
  has_many(:tickets)
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.screen_name = auth["info"]["nickname"]
      user.token = auth["credentials"]["token"]
      user.secret = auth["credentials"]["secret"]
    end
  end

  # get user ID from uid
  def self.get_user_id(uid)
    user = self.find_by(uid: uid)
    return user ? user.id : ""
  end
end
