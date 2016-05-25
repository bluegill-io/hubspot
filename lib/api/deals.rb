## http://developers.hubspot.com/docs/methods/deals/get_deals_modified
## Require at least 1000 records
## GET /deals/v1/deal/recent/modified
## Get all deals in a portal sorted by their last modified date. You can use the count or offset parameters to further refine you search.

module Api
  class Deals < Base
    
    def self.needs_joins?
      true
    end

    def hash_access
      'results'
    end

    # results to true or false
    def check_offset(response)
      response['hasMore']
    end

    def rerun(response)
      offset = response['offset']
      rerun_params = self.params.merge({offset: offset.to_s})

      puts "Deals Looping #{offset}"
      self.retreive(rerun_params)
    end

    def params
      super({property: 'dealId;dealname;dealstage;closedate;bid_type;'\
        ' amount;margin_bid;job_code;property_year;win_loss;description;'\
        ' closed_lost_reason;closed_lost_won_percentage;final_contract_amount;'\
        ' margin_close;project_start_date;project_end_date;rooms;floors;'\
        ' project_manager;project_superintendent;associatedCompanyIds;associatedVids;',
        count: '250'})
    end
    
    def format_json
      {
        id: :dealId,
        deal_name: :'properties.dealname.value',
        close_date: :'properties.closedate.value',
        deal_stage_id: :'properties.dealstage.value',
        project_year: :'properties.property_year.value',
        project_start_date: :'properties.project_start_date.value',
        project_end_date: :'properties.project_end_date.value',
        rooms: :'properties.rooms.value',
        floors: :'properties.floors.value',
        project_manager: :'properties.project_manager.value',
        project_superintendent: :'properties.project_superintendent.value',
        bid_type: :'properties.bid_type.value',
        amount: :'properties.amount.value',
        margin_bid: :'properties.margin_bid.value',
        job_code: :'properties.job_code.value',
        win_loss: :'properties.win_loss.value',
        description: :'properties.description.value',
        closed_lost_reason: :'properties.closed_lost_reason.value',
        closed_lost_won_percentage: :'properties.closed_lost_won_percentage.value',
        final_contract_amount: :'properties.final_contract_amount.value',
        margin_close: :'properties.margin_close.value'
      }
    end

    def process_joins(db_record, json_record)
      save_contact_join(db_record, json_record)
      save_deal_join(db_record, json_record)
    end

    private

    def save_deal_join(new_deal, json_deal)
      return if json_deal[:"associations.associatedCompanyIds"].empty?
      json_deal[:"associations.associatedCompanyIds"].each do |id|
        new_deal.company_deals.find_or_create_by(company_id: id)
      end
    end

    def save_contact_join(new_deal, json_deal)
      return if json_deal[:"associations.associatedCompanyIds"].empty?
      json_deal[:"associations.associatedCompanyIds"].each do |vid|
        new_deal.deal_contacts.find_or_create_by(contact_id: vid)
      end
    end
  end
end
