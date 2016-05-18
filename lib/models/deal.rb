class Deal < ActiveRecord::Base
  self.primary_key = 'id'

  has_many :company_deals
  has_many :companies, through: :company_deals

  has_many :deal_contacts
  has_many :contacts, through: :deal_contacts

  has_many :engagement_deals
  has_many :engagements, through: :engagement_deals
end
