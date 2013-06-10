# Load the rails application
require File.expand_path('../application', __FILE__)

# API KEY Loader
if ::Rails.env == ("development" || "test")
  YAML.load_file("#{::Rails.root}/config/initializers/api_keys.yaml")[::Rails.env].each {|k,v| ENV[k]=v}
end
# Initialize the rails application
SoundcloudTwitter::Application.initialize!
