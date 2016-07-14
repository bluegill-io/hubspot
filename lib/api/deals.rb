# frozen_string_literal: true
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
        deal_stage_id: :'properties.dealstage.value',
        project_year: :'properties.property_year.value'
      }.merge!(additional_deal_params)
    end

    def process_joins(id, json_obj)
      join_hash.each_with_index do |k, i|
        assoc_ids = json_obj[:"associations.#{k[1]}"]
        return if assoc_ids.nil? || assoc_ids.empty?
        join_attr = i == 0 ? :company_id : :contact_id
        save_join_table(id, k[0], join_attr, assoc_ids)
      end
    end

    private

    def additional_deal_params
      deal_params.each_with_object({}) { |k, deal| deal[k] = :"properties.#{k}.value" }
    end

    def deal_params
      Deal.column_names - %w(id deal_stage_id deal_name close_date project_year updated_at created_at)
    end

    def save_join_table(deal_id, assoc_table, join_attr, assoc_ids)
      assoc_ids.each do |id|
        Deal.find(deal_id).send(assoc_table).create join_attr => id
      end
    end

    def join_hash
      {
        company_deals: :associatedCompanyIds,
        deal_contacts: :associatedVids
      }
    end
  end
end
