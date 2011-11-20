require 'httparty'

module Api
  module Vendors

    class Meetup
      def initialize(params = {})
        @params = params
      end

      def get(resource, options = {})
        @params.merge!(options)
        HTTParty.get("https://api.meetup.com/2/#{resource}?#{@params.to_query}")['results']
      end
    end

  end
end
