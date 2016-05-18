## http://developers.hubspot.com/docs/methods/contacts/get_contacts
## Require at least 200 records
## GET /contacts/v1/lists/all/contacts/all
## For a given portal, return all contacts that have been created in the portal. 
## A paginated list of contacts will be returned to you, with a maximum of 100 contacts per page.

module Api
  class Contacts < Base

    def retreive
      params = { hapikey: @key }
      opts = '&property=vid&property=firstname&property=lastname&'\
             ' property=email&property=phone&property=mobilephone&'\
             ' property=hubspot_owner_id&property=industry&'\
             ' property=company&property=jobtitle&count=100'

      response = Api::Rest.read_and_parse(@url, params, opts)
      response['contacts'].each do |contact|
        contact_params = format_json(contact)
        ::Contact.create(contact_params)
      end
    end

    private
    
    def format_json(c)
      g = c['properties']
      {
        id: c["vid"].to_i,
        first: g["firstname"] ? g["firstname"]["value"] : nil,
        last: g["lastname"] ? g["lastname"]["value"] : nil,
        email: g["email"] ? g["email"]["value"] : nil,
        phone: g["phone"] ? g["phone"]["value"] : nil,
        m_phone: g["mobilephone"] ? g["mobilephone"]["value"] : nil,
        owner_id: g["hubspot_owner_id"] ? g["hubspot_owner_id"]["value"] : nil,
        industry: g["industry"] ? g["industry"]["value"] : nil,
        company: g["company"] ? g["company"]["value"] : nil,
        job_title: g["jobtitle"] ? g["jobtitle"]["value"] : nil
      }
    end
  end
end
