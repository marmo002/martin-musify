require 'simplecov'
SimpleCov.start 'rails' do
  add_filter "/app/channels/application_cable/channel.rb"
  add_filter "/app/channels/application_cable/connection.rb"
  add_filter "app/jobs/application_job.rb"
  add_filter "app/jobs/load_ticketmaster_api_job.rb"
  add_filter "app/mailers/application_mailer.rb"
  add_filter "app/models/artist_social.rb"
  add_filter "app/workers/hard_worker.rb"

end unless ENV['NO_COVERAGE']
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.

  include FactoryBot::Syntax::Methods
  # Add more helper methods to be used by all tests here...
end
