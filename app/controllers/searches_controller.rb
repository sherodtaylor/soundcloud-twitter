require 'soundcloud'
require 'open-uri'
class SearchesController < ApplicationController
  def playlist
    # client = Soundcloud.new( :access_token => current_user.soundcloud_token )
    q = params[:q]
    uri = URI.parse("https://api.soundcloud.com/playlists.json?consumer_key=#{ENV['SOUNDCLOUD_CLIENT_ID']}&q=#{URI.escape(q)}&filter=all")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    status = http.request(request).body
    json = JSON.parse(status)
    render :json => json.first['permalink_url']
  end
end
