Rails.application.config.middleware.use OmniAuth::Builder do
    provider :twitter, ENV["TWITTER_KEY"], ENV["TWITTER_SECRET"]
    provider :soundcloud, ENV['SOUNDCLOUD_CLIENT_ID'], ENV['SOUNDCLOUD_SECRET']
end

