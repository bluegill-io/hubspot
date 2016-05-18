## http://developers.hubspot.com/docs/methods/companies/get_companies_modified
## Require at least 200 records
## GET /companies/v2/companies/recent/modified
## Returns a list of all companies sorted by the date the companies were most recently modified. This is particularly useful for ongoing syncs with HubSpot in which changes to companies must be captured in another system.

module Api
  class Companies < Base

    def retreive
      params = { 
        hapikey: @key, 
        property: 'companyId;name;company_type;phone;'
      }

      response = Api::Rest.read_and_parse(@url, params)

      response['results'].each do |company|
        company_params = format_json(company)
        ::Company.create(company_params)
      end
    end

    private
    
    def format_json(co)
      { 
        id: co["companyId"].to_i,
        name: co["properties"]["name"]["value"],
        industry: co["properties"]["company_type"] ? co["properties"]["company_type"]["value"] : nil,
        phone: co["properties"]["phone"] ? co["properties"]["phone"]["value"] : nil
      }
    end
  end
end
