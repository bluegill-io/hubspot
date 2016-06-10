## http://developers.hubspot.com/docs/methods/deals/get_deals_modified
## Require at least 1000 records
## GET /deals/v1/deal/recent/modified
## Get all deals in a portal sorted by their last modified date. You can use the count or offset parameters to further refine you search.

module Api
  class Deals < Base
    def initialize
      super ENV['DEAL_URL'], true
    end

    # results to true or false
    def check_offset(response)
      response['hasMore']
    end

    def rerun(response)
      offset = response['offset']
      rerun_params = params.merge(offset: offset.to_s)

      puts "== Deals Looping #{offset} =="
      retreive(rerun_params)
    end

    def params
      properties = 'dealId;dealname;dealstage;closedate;'\
                  'associatedCompanyIds;associatedVids;' + deal_params.join(';')
      super({ property: properties, count: '250' })
    end

    def format_params
      {
        id: :dealId,
        deal_name: :'properties.dealname.value',
        close_date: :'properties.closedate.value',
        deal_stage_id: :'properties.dealstage.value'
      }.merge!(additional_deal_params)
    end

    def process_joins(db_record, json_record)
      save_contact_join(db_record, json_record)
      save_deal_join(db_record, json_record)
    end

    private

    def additional_deal_params
      deal_params.each_with_object({}) { |k, deal| deal[k] = :"properties.#{k}.value" }
    end

    def deal_params
      Deal.column_names - %w(id deal_stage_id deal_name close_date updated_at created_at)
    end

    def save_deal_join(new_deal, json_deal)
      return if json_deal[:"associations.associatedCompanyIds"].empty?
      json_deal[:"associations.associatedCompanyIds"].each do |id|
        new_deal.company_deals.find_or_create_by(company_id: id)
      end
    end

    def save_contact_join(new_deal, json_deal)
      return if json_deal[:"associations.associatedVids"].empty?
      json_deal[:"associations.associatedVids"].each do |vid|
        new_deal.deal_contacts.find_or_create_by(contact_id: vid)
      end
    end
  end
end
