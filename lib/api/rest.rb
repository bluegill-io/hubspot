# frozen_string_literal: true
module Api
  module Rest
    module_function

    def read_and_parse(url, params = {}, opts = nil)
      uri = URI.parse(url)
      uri.query = URI.encode_www_form(params)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      https.verify_mode = OpenSSL::SSL::VERIFY_NONE

      # this helps atleast with the contacts url by appending the
      # string of multiple '&property='
      uri.query += opts unless opts.nil?
      resp = Net::HTTP.get_response(uri)
      return parse_json(resp)
    rescue StandardError, JSON::ParserError => e
      puts e.message.to_s
      raise e
    end

    def parse_json(resp)
      JSON.parse(resp.body)
    end
  end
end
