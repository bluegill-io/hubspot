# TODO fix with DealsTable
module Excel
  class ContactsTable
    attr_accessor :sheet

    def initialize(excel_doc)
      self.sheet = excel_doc['--Contacts--']
      write_columns
    end

    private

    def write_columns
      Contact.all.each_with_index do |contact, i|
        row = i + 1
        update_content contact, row
      end
    end

    def update_content(contact, row)
      %w{ industry company first last job_title phone m_phone
        email owner
       }.each_with_index do |k, i|
        if k == "owner"
          # conditional needed so #full_name isn't called on 'nil' and blows up
          sheet[row][i].change_contents(contact.send(k).full_name) if contact.send(k) 
        else
          sheet[row][i].change_contents(contact.send(k))
        end
      end
      
      # associations
      sheet[row][9].change_contents(associated_deals(contact)) if contact.deals.present?
      sheet[row][10].change_contents(associated_engagements(contact)) if contact.engagements.present?
    end

    # Do we just need the deal name?
    def associated_deals(contact)
      assoc_deals = ''
      contact.deals.each do |deal|
        assoc_deals += "#{deal.deal_name}, "
      end
      assoc_deals
    end

    def associated_engagements(contact)
      assoc_engagements = ''
      contact.engagements.each do |engage|
        assoc_engagements += "#{engage.body}, "
      end
      assoc_engagements
    end
  end
end
