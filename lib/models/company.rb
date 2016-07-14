# frozen_string_literal: true
#:nodoc
class Company < ActiveRecord::Base
  self.primary_key = 'id'
  has_many :company_deals
  has_many :deals, through: :company_deals
  has_many :company_engagements
  has_many :engagements, through: :company_engagements
end
