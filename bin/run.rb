#!/usr/bin/env ruby
require './config'
require 'rake'

rake = Rake.application
rake.init
rake.load_rakefile

rake['db:drop'].invoke()
rake['db:create'].invoke()
rake['db:migrate'].invoke()
rake['db:seed'].invoke()


Api::Companies.new(ENV['COMPANY_URL']).retreive
puts "Companies Done"
Api::Contacts.new(ENV['CONTACT_URL']).retreive
puts "Contacts Done"
Api::Deals.new(ENV['DEAL_URL']).retreive
puts "Deals Done"
Api::Engagements.new(ENV['ENGAGEMENT_URL']).retreive
puts "Engagements Done"
Api::Owners.new(ENV['OWNER_URL']).retreive
puts "Owners Done"