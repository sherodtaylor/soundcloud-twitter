class User < ActiveRecord::Base
  attr_accessible :email, :name, :soundcloud_id, :soundcloud_token, :twitter_id, :twitter_token, :twitter_secret, :twitter_connect
  def self.omniauth_create(auth)
    create! do |user|
      if auth['provider'] == "soundcloud"
        user.name = auth['extra']["raw_info"]["full_name"]
        user.soundcloud_token = auth['credentials']['token']
        user.soundcloud_id = auth['extra']['raw_info']['id']
        user.twitter_connect = false
      end
    end
  end

  def self.omniauth_find(auth)
      User.where(:soundcloud_id => auth['extra']['raw_info']['id']).first
  end
end

