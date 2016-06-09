require 'certified'
require 'pry'
require 'dotenv'
require 'net/http'
require 'openssl'
require 'json'
require 'pg'
require 'active_record'
require 'yaml'
require 'rake'
require 'spreadsheet'
Dotenv.load

# API
require './lib/api/base.rb'
require './lib/api/companies.rb'
require './lib/api/contacts.rb'
require './lib/api/deals.rb'
require './lib/api/engagements.rb'
require './lib/api/owners.rb'
require './lib/api/rest.rb'

# MODELS
require './lib/models/company.rb'
require './lib/models/company_deal.rb'
require './lib/models/company_engagement.rb'
require './lib/models/contact.rb'
require './lib/models/deal.rb'
require './lib/models/deal_contact.rb'
require './lib/models/deal_stage.rb'
require './lib/models/engagement.rb'
require './lib/models/engagement_contact.rb'
require './lib/models/engagement_deal.rb'
require './lib/models/owner.rb'

# EXCEL TABLES 
# (order is important here)
require './lib/excel/workbook.rb'
require './lib/excel/deals_table.rb'



include ActiveRecord::Tasks

root = File.expand_path '..', __FILE__
DatabaseTasks.env = ENV['ENV'] || 'development'
DatabaseTasks.database_configuration = YAML.load(File.read(File.join(root, 'config/database.yml')))
DatabaseTasks.db_dir = File.join root, 'db'
DatabaseTasks.root = root

ActiveRecord::Base.configurations = DatabaseTasks.database_configuration
ActiveRecord::Base.establish_connection DatabaseTasks.env.to_sym
