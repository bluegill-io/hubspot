# frozen_string_literal: true
## http://developers.hubspot.com/docs/methods/contacts/get_contacts
## Require at least 200 records
## GET /contacts/v1/lists/all/contacts/all
## For a given portal, return all contacts that have been created in the portal.
## A paginated list of contacts will be returned to you, with a maximum of 100 contacts per page.

module Api
  class Contacts < Base
    def initialize
      super ENV['CONTACT_URL'], false, 'contacts'
    end

    def check_offset(response)
      response['has-more']
    end

    def rerun(response)
      puts 'Contact Looping'
      rerun_params = params.merge(vidOffset: response['vid-offset'].to_s)
      retreive(rerun_params)
    end

    def params
      super({ count: '100' })
    end

    def opts
      '&property=vid&property=firstname&property=lastname&'\
      'property=email&property=phone&property=mobilephone&'\
      'property=hubspot_owner_id&property=industry&'\
      'property=company&property=jobtitle'
    end

    def format_params
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
