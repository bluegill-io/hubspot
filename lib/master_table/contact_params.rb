# frozen_string_literal: true
module MasterTable
  class ContactParams
    attr_accessor :contact
    attr_accessor :valid_params

    def initialize(contact)
      self.contact = contact
      self.valid_params = set_params
    end

    private

    def set_params
      new_params = contact.as_json(except: [:id, :owner_id, :created_at, :updated_at])
      new_params[:owner] = contact.formatted_owner

      # associations
      new_params[:engagements] = associated_engagements if contact.engagements.present?
      new_params[:deals] = associated_deals if contact.deals.present?
      new_params
    end

    def associated_deals
      assoc_deals = ''
      contact.deals.each do |deal|
        assoc_deals += "#{deal.deal_name}, "
      end
      assoc_deals.strip
    end

    def associated_engagements
      assoc_engagements = ''
      contact.engagements.each do |engage|
        assoc_engagements += "#{engage.body}, "
      end
      assoc_engagements.strip
    end
  end
end
