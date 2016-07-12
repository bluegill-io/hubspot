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
      %w{ deal_name description job_code formatted_close_date project_year amount
        formatted_margin_bid final_contract_amount formatted_margin_close bid_type
        win_loss closed_lost_won_percentage closed_lost_reason 
        formatted_project_start_date formatted_project_end_date 
        human_deal_stage project_manager project_superintendent 
        formatted_rooms formatted_floors
       }.each_with_index do |k, i|
        sheet[row][i].change_contents(deal.send(k))
      end
    end

  end
end
