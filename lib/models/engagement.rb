# frozen_string_literal: true
#:nodoc
class Engagement < ActiveRecord::Base
  self.primary_key = 'id'
  belongs_to :owner
  has_many :company_engagements
  has_many :companies, through: :company_engagements
  has_many :engagement_contacts
  has_many :contacts, through: :engagement_contacts
  has_many :engagement_deals
  has_many :deals, through: :engagement_deals
end
