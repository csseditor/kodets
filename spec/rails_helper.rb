ENV["RAILS_ENV"] ||= 'test'

if ENV["SIMPLECOV"]
  require 'simplecov'
  SimpleCov.start 'rails'
end

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'shoulda/matchers'
require 'capybara/rails'
require 'capybara/rspec'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.before(:suite) { FactoryGirl.lint }

  config.include Devise::TestHelpers, type: :controller
  config.include ControllerHelpers, type: :controller

  config.expect_with(:rspec) { |c| c.syntax = :expect }

  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
end
