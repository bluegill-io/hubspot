#:nodoc
class Contact < ActiveRecord::Base
  self.primary_key = 'id'

  belongs_to :owner
  has_many :engagements

  has_many :deal_contacts
  has_many :deals, through: :deal_contacts

  has_many :engagement_contacts
  has_many :engagements, through: :engagement_contacts
end
