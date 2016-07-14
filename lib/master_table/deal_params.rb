# frozen_string_literal: true
# TODO: - remove dupe code between this and contacts_table
module MasterTable
  class DealParams
    attr_accessor :deal
    attr_accessor :valid_params

    def initialize(deal)
      self.deal = deal
      self.valid_params = set_params
    end

    private

    def set_params
      new_params = deal.as_json(except: [:id, :deal_stage_id, :created_at, :updated_at])
      new_params.merge!(
        close_date: deal.formatted_close_date,
        margin_bid: deal.formatted_margin_bid,
        margin_close: deal.formatted_margin_close,
        project_start_date: deal.formatted_project_start_date,
        project_end_date: deal.formatted_project_end_date,
        floors: deal.formatted_floors,
        rooms: deal.formatted_rooms,
        deal_stage: deal.human_deal_stage,
        amount: deal.formatted_amount,
        final_contract_amount: deal.formatted_contract_amount
      )
      new_params
    end
  end
end
