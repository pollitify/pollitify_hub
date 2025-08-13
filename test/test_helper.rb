ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    # Add more helper methods to be used by all tests here...
    include FactoryBot::Syntax::Methods
    
    #include Devise::Test::IntegrationHelpers # for integration tests (ActionDispatch::IntegrationTest)
    
    #include Devise::Test::ControllerHelpers
  end
end

class ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers
end
class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
end

class ActionController::TestCase
  include Devise::Test::ControllerHelpers
end

# GODDAMN MAGIC; github crazy hack 
# https://github.com/heartcombo/devise/issues/5705#issuecomment-2442370072
ActiveSupport.on_load(:action_mailer) do
  Rails.application.reload_routes_unless_loaded
end
