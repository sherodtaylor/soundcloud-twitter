class User < ActiveRecord::Base
  attr_accessible :email, :name, :soundcloud_id, :soundcloud_token, :twitter_id, :twitter_token
end
