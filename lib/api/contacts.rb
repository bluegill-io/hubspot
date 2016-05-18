## http://developers.hubspot.com/docs/methods/contacts/get_contacts
## Require at least 200 records
## GET /contacts/v1/lists/all/contacts/all
## For a given portal, return all contacts that have been created in the portal. 
## A paginated list of contacts will be returned to you, with a maximum of 100 contacts per page.

module Api
  class Contacts < Base

    def hash_access
      'contacts'
    end

    def params
      super({property: '&property=vid&property=firstname&property=lastname&'\
      ' property=email&property=phone&property=mobilephone&'\
      ' property=hubspot_owner_id&property=industry&'\
      ' property=company&property=jobtitle&count=100'})
    end
    
    def format_json
      {
        id: :vid,
        first: :'properties.firstname.value',
        last: :'properties.lastname.value',
        email: :'properties.email.value',
        phone: :'properties.phone.value',
        m_phone: :'properties.mobilephone.value',
        owner_id: :'properties.hubspot_owner_id.value',
        industry: :'properties.industry.value',
        company: :'properties.company.value',
        job_title: :'properties.jobtitle.value'
      }
    end
  end
end
