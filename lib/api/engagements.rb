## http://developers.hubspot.com/docs/methods/engagements/get_engagement
## Require at least 50 records per person
## GET /engagements/v1/engagements/:engagementId
## Get an engagement (a task or activity) on an object in HubSpot. This data is often used for per rep productivity reporting or integration with other back-office tools.

module Api
  class Engagements < Base
    def hash_access
      'results'
    end

    def self.needs_joins?
      true
    end

    # results to true or false
    def check_offset(response)
      response['hasMore']
    end

    def rerun(response)
      puts 'Engagements Looping'
      rerun_params = params.merge(offset: response['offset'].to_s)
      retreive(rerun_params)
    end

    def params
      super({ property: 'id;createdBy;createdAt;contactsIds;companyIds;dealsIds;body', count: '50' })
    end

    def format_params
      {
        id: :"engagement.id",
        post_at: :"engagement.createdAt",
        body: :"metadata.body",
        owner_id: :"engagement.createdBy"
      }
    end

    def process_joins(db_record, json_record)
      save_company_join(db_record, json_record)
      save_contact_join(db_record, json_record)
      save_deal_join(db_record, json_record)
    end

    private

    def save_company_join(new_en, en)
      return if en[:"associations.companyIds"].empty?
      en[:"associations.companyIds"].each do |id|
        new_en.company_engagements.create(company_id: id)
      end
    end

    def save_contact_join(new_en, en)
      return if en[:"associations.contactIds"].empty?
      en[:"associations.contactIds"].each do |id|
        new_en.engagement_contacts.create(contact_id: id)
      end
    end

    def save_deal_join(new_en, en)
      return if en[:"associations.dealIds"].empty?
      en[:"associations.dealIds"].each do |id|
        new_en.engagement_deals.create(deal_id: id)
      end
    end
   end
end
