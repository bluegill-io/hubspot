# frozen_string_literal: true
#:nodoc
class Deal < ActiveRecord::Base
  after_commit :add_to_master_deal_table

  self.primary_key = 'id'
  belongs_to :deal_stage

  has_many :company_deals
  has_many :companies, through: :company_deals

  has_many :deal_contacts
  has_many :contacts, through: :deal_contacts

  has_many :engagement_deals
  has_many :engagements, through: :engagement_deals

  include FormattableDealData

  def add_to_master_deal_table
    params = MasterTable::DealParams.new(self)
    MasterDeal.create(params.valid_params)
  end
end
