require 'simplecov'
SimpleCov.start 'rails'
# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
# require 'webmock/rspec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

#SoundCloud Mocking
soundcloud = {
  "provider" => "soundcloud",
  "uid" => 12345678,
  "info" => {
    "name" => "Soundcloud User",
    "nickname" => "soundclouder",
    "image" => "https://the.image.url",
    "location" => "Soundcloud Town"
  },
  "credentials" => {
    "token" => "123-321",
    "expires" => false
  },
  "extra" => {
    "raw_info" => {
      "id" => 12345678,
      "kind" => "user",
      "permalink" => "soundclouder",
      "username" => "soundclouder",
      "full_name" => "Sherod Taylor",
    }
  }
}
OmniAuth.config.add_mock(:soundcloud, soundcloud)

#Twitter Mocking
twitter = {
  "provider" => "twitter",
  "uid" => 12345678,
  "info" => {
    "name" => "Sherod Taylor",
    "nickname" => "sherodtaylor"
  },
  "credentials" => {
    "token" => "123-321",
    "expires" => false
  },
  "extra" => {
    "raw_info" => {
      "id" => 12345678,
      "full_name" => "Sherod Taylor",
    }
  }
}
OmniAuth.config.add_mock(:twitter, twitter)
RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
end
