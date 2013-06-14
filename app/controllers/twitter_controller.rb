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
      json = client.search(q, { :count => 2, :since => last_id })['statuses'].map{ |s| { pic: s['user']['profile_background_image_url'], tweet: s['text'], date: s['created_at'].strftime("%H:%M%P - %e %b %Y"), handle: s['user']['screen_name'], name: s['user']['name'], id: s['id'].to_s} }
    else
      json = client.search(q, { :count => 3 })['statuses'].map{ |s| { pic: s['user']['profile_background_image_url'], tweet: s['text'], date: s['created_at'].strftime("%H:%M%P - %e %b %Y"), handle: s['user']['screen_name'], name: s['user']['name'], id: s['id'].to_s} }
    end
    render :json => json.to_json
  end
end
