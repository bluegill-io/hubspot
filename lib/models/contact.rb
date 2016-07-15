# frozen_string_literal: true
#:nodoc
class Contact < ActiveRecord::Base
  after_commit :add_to_master_table
  
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

  def add_to_master_table
    params = MasterTable::ContactParams.new(self)
    MasterContact.create(params.valid_params)
  end
end
