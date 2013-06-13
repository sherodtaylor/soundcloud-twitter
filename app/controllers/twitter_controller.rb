require 'twitter'
require 'open-uri'
class TwitterController < ApplicationController
  def stream
    q = params[:q]
    last_id = params[:last_id]
    if signed_in?
      client = Twitter::Client.new(
        :consumer_key => ENV['TWITTER_KEY'],
        :consumer_secret => ENV['TWITTER_SECRET'],
        :oauth_token => current_user.twitter_token,
        :oauth_token_secret => current_user.twitter_secret
      )
    end
    if last_id != nil
      json = client.search(q, { :since_id => last_id, :count => 10 })['statuses'].map{ |s| { link: s['user']['profile_background_image_url'], tweet: s['text'] } }
    else
      json = client.search(q, { :count => 10 })['statuses'].map{ |s| { link: s['user']['profile_background_image_url'], tweet: s['text'] } }
    end
    render :json => json.to_json
  end
end
