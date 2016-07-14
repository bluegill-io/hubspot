# frozen_string_literal: true
# http://developers.hubspot.com/docs/methods/companies/get_companies_modified
# Require at least 200 records
# GET /companies/v2/companies/recent/modified
# Returns a list of all companies sorted by the date
# the companies were most recently modified. This is particularly
# useful for ongoing syncs with HubSpot in which changes to
# companies must be captured in another system.

module Api
  class Companies < Base
    def initialize
      super ENV['COMPANY_URL']
    end

    def check_offset(response)
      response['hasMore']
    end

    def rerun(response)
      puts '== Companies Looping =='
      rerun_params = params.merge(offset: response['offset'].to_s)
      retreive(rerun_params)
    end

    def params
      super({ property: 'companyId;name;company_type;phone;', count: '100' })
    end

    def format_params
      {
        id: :companyId,
        name: :'properties.name.value',
        industry: :'properties.company_type.value',
        phone: :'properties.phone.value'
      }
    end
  end
end
