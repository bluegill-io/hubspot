module Api
  class Base
    attr_accessor :url
    attr_accessor :key
    
    def initialize(url)
      @url = url
      @key = ENV['API_KEY']
    end
    
  end
end
