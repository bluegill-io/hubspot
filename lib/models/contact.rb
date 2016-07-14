# frozen_string_literal: true
#:nodoc
class Contact < ActiveRecord::Base
  self.primary_key = 'id'

  belongs_to :owner
  has_many :engagements

  has_many :deal_contacts
  has_many :deals, through: :deal_contacts

  has_many :engagement_contacts
  has_many :engagements, through: :engagement_contacts

  def formatted_owner
    owner.full_name if owner
  end
end
