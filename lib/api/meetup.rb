require 'httparty'
module Api
  class Meetup
    def initialize(resource, config = {})
      @options = config
      @base_uri = "https://api.meetup.com/2/#{resource}"
    end

    def get(options = {})
      @options.merge!(options)
      HTTParty.get("#{@base_uri}?#{@options.to_query}")['results']
    end
  end
end
