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

    # flatten a multidimensial hash that we're getting on 
    def flatten_hash(hash)
      hash.each_with_object({}) do |(key, value), new_object|
        # hash
        if value.is_a? Hash
          reflatten(key, value, new_object)
        # array of hashes
        elsif value.is_a?(Array) && value.first.is_a?(Hash)
          value.each do |val|
            reflatten(key, val, new_object)
          end
        # array of ids - this is associated models
        elsif value.is_a?(Array) && !value.empty?
          set_key_value(key, value, new_object)
        # already flat
        else
          set_key_value(key, value, new_object)
        end
      end
    end

    def set_key_value(key, value, hash)
      hash[key.to_sym] = value
    end

    def reflatten(key, value, hash)
      flatten_hash(value).map do |h_key, h_value|
        hash["#{key}.#{h_key}".to_sym] = h_value
      end
    end

    def activerecord_model
      model = self.class.to_s
      model.slice! "Api"
      return model.singularize.constantize
    end


  end
end
