require 'codeclimate-test-reporter'
require 'simplecov'
SimpleCov.start do
  add_filter 'spec/'
  add_filter 'config/'
  formatter SimpleCov::Formatter::MultiFormatter.new([
                                                       SimpleCov::Formatter::HTMLFormatter,
    CodeClimate::TestReporter::Formatter
                                                     ])
end
ENV['ENV'] = 'test'
ENV['API_KEY'] = 'test'
require_relative '../config.rb'
require 'factory_girl'
require 'database_cleaner'

ActiveRecord::Base.logger = nil
ActiveRecord::Base.establish_connection(adapter:  'postgresql',
                                          database: 'postgres',
                                          encoding: 'unicode',
                                          pool: 5)

ActiveRecord::Base.connection.drop_database 'hubspot_test_db'
ActiveRecord::Base.connection.create_database 'hubspot_test_db'
ActiveRecord::Schema.verbose = false
load('db/schema.rb')

RSpec.configure do |config|
  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.expect_with :rspec do |expectations|
    # This option will default to `true` in RSpec 4. It makes the `description`
    # and `failure_message` of custom matchers include text for helper methods
    # defined using `chain`, e.g.:
    #     be_bigger_than(2).and_smaller_than(4).description
    #     # => "be bigger than 2 and smaller than 4"
    # ...rather than:
    #     # => "be bigger than 2"
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end

  config.before(:suite) do
    FactoryGirl.find_definitions
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.after(:suite) do
    ActiveRecord::Base.connection.drop_database 'hubspot_test_db'
  end

  config.include FactoryGirl::Syntax::Methods
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
end
