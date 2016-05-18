## http://developers.hubspot.com/docs/methods/deals/get_deals_modified
## Require at least 1000 records
## GET /deals/v1/deal/recent/modified
## Get all deals in a portal sorted by their last modified date. You can use the count or offset parameters to further refine you search.

module Api
  class Deals < Base
    
    def retreive
      params = { 
        hapikey: @key,
        property: 'dealId;dealname;dealstage;closedate;bid_type;'\
        ' amount;margin_bid;job_code;property_year;win_loss;description;'\
        ' closed_lost_reason;closed_lost_won_percentage;final_contract_amount;'\
        ' margin_close;project_start_date;project_end_date;rooms;floors;'\
        ' project_manager;project_superintendent;associatedCompanyIds;associatedVids;'
      }
      
      response = Api::Rest.read_and_parse(@url, params)
      response['results'].each do |deal|
        deal_params = format_json(deal)
        new_deal = ::Deal.create(deal_params)

        save_contact_join(new_deal, deal)
        save_deal_join(new_deal, deal)
      end
    end

    private

    def format_json(d)
      p = d["properties"]
      {
        id: d["dealId"].to_i,
        deal_name: p["dealname"] ? p['dealname']["value"] : nil,
        close_date: p["closedate"] ? p["closedate"]["value"] : nil,
        deal_stage: p["dealstage"] ? p["dealstage"]["value"] : nil,
        project_year: p["property_year"] ? p["property_year"]["value"] : nil,
        project_start_date: p["project_start_date"] ? p["project_start_date"]["value"] : nil,
        project_end_date: p["project_end_date"] ? p["project_end_date"]["value"] : nil,
        rooms: p["rooms"] ? p["rooms"]["value"] : nil,
        floors: p["floors"] ? p["floors"]["value"] : nil,
        project_manager: p["project_manager"] ? p["project_manager"]["value"] : nil,
        project_superintendent: p["project_superintendent"] ? p["project_superintendent"]["value"] : nil,
        bid_type: p["bid_type"] ? p["bid_type"]["value"] : nil,
        amount: p["amount"] ? p["amount"]["value"] : nil,
        margin_bid: p["margin_bid"] ? p["margin_bid"]["value"] : nil,
        job_code: p["job_code"] ? p["job_code"]["value"] : nil,
        win_loss: p["win_loss"] ? p["win_loss"]["value"] : nil,
        description: p["description"] ? p["description"]["value"] : nil,
        closed_lost_reason: p["closed_lost_reason"] ? p["closed_lost_reason"]["value"] : nil,
        closed_lost_won_percentage: p["closed_lost_won_percentage"] ? p["closed_lost_won_percentage"]["value"] : nil,
        final_contract_amount: p["final_contract_amount"] ? p["final_contract_amount"]["value"] : nil,
        margin_close: p["fmargin_close"] ? p["fmargin_close"]["value"] : nil
      }
    end

    def save_deal_join(new_deal, json_deal)
      if json_deal["associations"] && json_deal["associations"]["associatedCompanyIds"]
        json_deal["associations"]["associatedCompanyIds"].each do |id|
          new_deal.company_deals.create(company_id: id)
        end
      end
    end

    def save_contact_join(new_deal, json_deal)
      if json_deal["associations"] && json_deal["associations"]["associatedVids"]
        json_deal["associations"]["associatedVids"].each do |vid|
          new_deal.deal_contacts.create(contact_id: vid)
        end
      end
    end
  end
end
