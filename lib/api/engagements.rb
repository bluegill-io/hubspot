# frozen_string_literal: true
## http://developers.hubspot.com/docs/methods/engagements/get_engagement
## Require at least 50 records per person
## GET /engagements/v1/engagements/:engagementId
## Get an engagement (a task or activity) on an object in HubSpot. This data is often used for per rep productivity reporting or integration with other back-office tools.

module Api
  class Engagements < Base
    attr_accessor :join_hash

    def initialize
      super ENV['ENGAGEMENT_URL'], true
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

    def process_joins(id, json_obj)
      join_hash.each do |k, v|
        assoc_ids = json_obj[:"associations.#{v}"]
        unless assoc_ids.nil? || assoc_ids.empty?
          join_attr = v.to_s.underscore.singularize.to_sym
          save_join_table(id, k, join_attr, assoc_ids)
        end
      end
    end

    private

    def save_join_table(engage_id, assoc_table, join_attr, assoc_ids)
      assoc_ids.each do |id|
        Engagement.find(engage_id).send(assoc_table).create join_attr => id
      end
    end

    def join_hash
      {
        company_engagements: :companyIds,
        engagement_contacts: :contactIds,
        engagement_deals: :dealIds
      }
    end
  end
end
