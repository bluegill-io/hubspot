class Engagement < ActiveRecord::Base
  self.primary_key = 'id'
  belongs_to :owner
    
  ## need to fix with join tables
  # belongs_to :company
  # belongs_to :contact
  # belongs_to :deal
  has_many :company_engagements
  has_many :companies, through: :company_engagements
  
  has_many :engagement_contacts
  has_many :contacts, through: :engagement_contacts
  
  has_many :engagement_deals
  has_many :deals, through: :engagement_deals


  
end