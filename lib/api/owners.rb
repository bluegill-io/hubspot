## http://developers.hubspot.com/docs/methods/owners/get_owners
## Require at least 35 records
## GET /owners/v2/owners/
## Returns all of the owners that exist inside of HubSpot. Owners can be created from users inside of the application, owners passing through CRM integrations, or created via the API.

module Api
 class Owners < Base

    def retreive
      params = { hapikey: @key }
      response = Api::Rest.read_and_parse(@url, params)

      response.each do |owner|
        owner_params = format_json(owner)
        ::Owner.create(owner_params)
      end
    end

    private
    
    def format_json(owner)
      { 
        id: owner["ownerId"].to_i,
        first: owner["firstName"],
        last: owner["lastName"],
        email: owner["email"]
      }
    end
  end
end