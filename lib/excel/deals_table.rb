# TODO - remove dupe code between this and contacts_table
module Excel
  class DealsTable
    attr_accessor :sheet

    def initialize(excel_doc)
      self.sheet = excel_doc['--Deals--']
      write_columns
    end

    private

    def write_columns
      Deal.all.each_with_index do |deal, i|
        row = i + 1
        update_content deal, row
      end
    end

    def update_content(deal, row)
      %w{ deal_name description job_code close_date project_year amount
        margin_bid final_contract_amount margin_close bid_type
        win_loss closed_lost_reason closed_lost_won_percentage project_start_date
        project_end_date deal_stage project_manager project_superintendent rooms floors
       }.each_with_index do |k, i|
        if k == "deal_stage"
          sheet[row][i].change_contents(deal.send(k).human_readable)
        else
          sheet[row][i].change_contents(deal.send(k))
        end
      end
      
      # associations
      sheet[row][20].change_contents(associated_companies(deal)) if deal.companies.present?
      sheet[row][21].change_contents(associated_contacts(deal)) if deal.contacts.present?
    end

    def associated_companies(deal)
      assoc_company_names = ''
      deal.companies.each do |company|
        assoc_company_names += "#{company.name}, "
      end
      assoc_company_names
    end

    def associated_contacts(deal)
      assoc_contacts = ''
      deal.contacts.each do |contact|
        assoc_contacts += "#{[contact.first, contact.last].join(' ')}, "
      end
      assoc_contacts
    end
  end
end
