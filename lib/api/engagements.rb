## http://developers.hubspot.com/docs/methods/engagements/get_engagement
## Require at least 50 records per person
## GET /engagements/v1/engagements/:engagementId
## Get an engagement (a task or activity) on an object in HubSpot. This data is often used for per rep productivity reporting or integration with other back-office tools.

module Api
 class Engagements < Base

    def retreive
      params = { hapikey: @key,
        property: 'id;createdBy;createdAt;contactsIds;companyIds;dealsIds;body' }

      response = Api::Rest.read_and_parse(@url, params)
      response['results'].each do |engagement|
        engagement_params = format_json(engagement)
        new_engagement = ::Engagement.create(engagement_params)

        save_company_join(new_engagement, engagement)
        save_contact_join(new_engagement, engagement)
        save_contact_join(new_engagement, engagement)
      end
    end
    
    private

    def format_json(e)
      {   
        id: e["engagement"]["id"].to_i,
        post_at: e["engagement"]["createdAt"],
        body: e["metadata"]["body"],
        owner_id: e["engagement"]["createdBy"].to_i
      }
    end

    def save_company_join(new_en, en)
      if en["associations"] && en["associations"]["companyIds"]
        en["associations"]["companyIds"].each do |id|
          new_en.company_engagements.create(company_id: id)
        end
      end
    end

    def save_company_join(new_en, en)
      if en["associations"] && en["associations"]["contactIds"]
        en["associations"]["contactIds"].each do |id|
          new_en.engagement_contacts.create(contact_id: id)
        end
      end
    end

    def save_contact_join(new_en, en)
      if en["associations"] && en["associations"]["dealIds"]
        en["associations"]["dealIds"].each do |id|
          new_en.engagement_deals.create(deal_id: id)
        end
      end
    end
  end
end

