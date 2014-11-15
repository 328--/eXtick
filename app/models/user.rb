class User < ActiveRecord::Base
  has_many(:tickets)

  has_many(:user_tags, dependent: :destroy)
  has_many(:tags, through: :user_tags)
  
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

  def set_tag(ids)
    if ids
      self.tags.append(Tag.where(id: ids))
    end
  end

  def init_twitter
    return Twitter::REST::Client.new do |config|
      config.consumer_key = Settings.twitter.consumer_key
      config.consumer_secret = Settings.twitter.consumer_secret
      config.access_token = self.token
      config.access_token_secret = self.secret
    end
  end

end
