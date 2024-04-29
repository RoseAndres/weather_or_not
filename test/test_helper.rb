require 'simplecov'
SimpleCov.start 'rails'

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require 'vcr'

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...

    # ? VCR setup
    # ? this will record and playback HTTP requests made during tests, to prevent unnecessary API calls
    VCR.configure do |config|
      config.allow_http_connections_when_no_cassette = false
      config.cassette_library_dir = File.expand_path('cassettes', __dir__)
      config.hook_into :webmock
      config.ignore_request { ENV['DISABLE_VCR'] }
      config.ignore_localhost = true
      config.filter_sensitive_data('<APPID>') { Rails.application.credentials.dig(:open_weather, :api_key) }
      config.default_cassette_options = {
        record: :new_episodes
      }
    end
  end
end
