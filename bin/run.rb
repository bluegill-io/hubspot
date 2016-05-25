#!/usr/bin/env ruby
require './config'

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


## create excel spreadsheet
book = Spreadsheet::Workbook.new
sheet1 = book.create_worksheet

sheet1.name = 'Deals'
sheet1.row(0).concat %w{Name CloseDate Amount MarginBid BidType WinLoss DealStage LostWonPercentage ClosedLostReason Companies Contacts}

Deal.all.each_with_index do |deal, i|
  index = i + 1

  # multiple companies per deal
  assoc_company_names = '' 
  if deal.companies.present?
    deal.companies.each do |company|
      assoc_company_names += "#{company.name},"
    end
  end

  # multiple companies per deal
  assoc_contacts = '' 
  if deal.contacts.present?
    deal.contacts.each do |contact|
      assoc_contacts += "#{[contact.first, contact.last].join(' ')},"
    end
  end
  
  sheet1.row(index).push(deal.deal_name, deal.close_date, 
    deal.amount, deal.margin_bid, deal.bid_type, 
    deal.win_loss, deal.deal_stage.human_readable, 
    deal.closed_lost_won_percentage, deal.closed_lost_reason, 
    assoc_company_names, assoc_contacts)
end

book.write './boom.xls'

