module Api
  class Base
    attr_accessor :url
    attr_accessor :key
    
    def initialize(url)
      @url = url
      @key = ENV['API_KEY']
    end

    def self.needs_joins?
      false
    end

    def check_offset(*)
      false
    end

    def params(child_p = {})
      { hapikey: @key }.merge(child_p)
    end

    def retreive(loop_params = {})
      options = self.respond_to?(:opts) ? self.opts : nil

      # set api_params based on whether we're looping or not
      api_params = loop_params.empty? ? params : loop_params
      response = Api::Rest.read_and_parse(@url, api_params, options)

      records = hash_access.empty? ? response : response[hash_access] 
      records.each do |record|
        formatted = flatten_hash(record)
        valid_params = build_hash(format_params, formatted)
        ar_record = activerecord_model.find_or_create_by(valid_params)
        if self.class.needs_joins?
          self.process_joins(ar_record, formatted)
        end
      end

      # check response to see if we need to loop for offset
      # currently being used for Deals and Contacts
      if self.check_offset(response)
        self.rerun(response)
      end
    end
    
    private

    # build the hash per our database specs
    def build_hash(obj, formatted)
      obj.each_with_object({}) do |(key, value), new_obj|
        new_obj[key] = formatted[value]
      end
    end

    # flattena a multidimensial hash that we're getting on 
    # api response
    def flatten_hash(hash)
      hash.each_with_object({}) do |(key, value), new_object|
        # first check if it's an object
        if value.is_a? Hash
          flatten_hash(value).map do |h_key, h_value|
            new_object["#{key}.#{h_key}".to_sym] = h_value
          end
        # then check if it's an array of hashes
        elsif value.is_a?(Array) && value.first.is_a?(Hash)
          value.each do |v|
            flatten_hash(v).map do |h_key, h_value|
              new_object["#{key}.#{h_key}".to_sym] = h_value
            end
          end
        # then check if it's just an array (these are the places
        # where associated id's exist)
        elsif value.is_a?(Array) && !value.empty?
          new_object["#{key}".to_sym] = value
        # else just make it as it is
        else
          new_object[key.to_sym] = value
        end
      end
    end

    def activerecord_model
      model = self.class.to_s
      model.slice! "Api"
      return model.singularize.constantize
    end


  end
end
