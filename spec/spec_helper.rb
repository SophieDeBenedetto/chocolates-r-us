ENV["chocolates_r_us_environment"] = "test"

require_relative "../config/environment.rb"
require_relative "./support/csv_helper.rb"

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.include CSVHelper
end
