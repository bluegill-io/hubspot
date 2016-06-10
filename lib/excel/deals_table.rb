#:nodoc
module Excel
  #:nodoc
  class DealsTable
    attr_accessor :sheet

    def initialize(excel_doc)
      self.sheet = excel_doc.create_worksheet
      sheet.name = 'Deals'

      write_tables
    end

    private

    def write_tables
      sheet.row(0).concat %w(Name CloseDate Amount MarginBid
                             BidType WinLoss DealStage
                             LostWonPercentage ClosedLostReason
                             Companies Contacts)
      write_deal_columns
    end

    def write_deal_columns
      Deal.all.each_with_index do |deal, i|
        index = i + 1
        create_rows deal, index,
                    associated_companies(deal),
                    associated_contacts(deal)
      end
    end

    def create_rows(deal, index, assoc_comp, assoc_cont)
      sheet.row(index).push deal.deal_name, deal.close_date,
                            deal.amount, deal.margin_bid, deal.bid_type,
                            deal.win_loss, deal.deal_stage.human_readable,
                            deal.closed_lost_won_percentage,
                            deal.closed_lost_reason,
                            assoc_comp, assoc_cont
    end

    def associated_companies(deal)
      return unless deal.companies.present?
      assoc_company_names = ''
      deal.companies.each do |company|
        assoc_company_names += "#{company.name}, "
      end
      assoc_company_names
    end

    def associated_contacts(deal)
      return unless deal.contacts.present?
      assoc_contacts = ''
      deal.contacts.each do |contact|
        assoc_contacts += "#{[contact.first, contact.last].join(' ')}, "
      end
      assoc_contacts
    end
  end
end
