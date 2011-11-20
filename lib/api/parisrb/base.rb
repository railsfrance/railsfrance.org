module Api
  module Parisrb

    class Base
      def initialize(params = {})
        params.merge!(key: Settings.api.meetup.key, group_urlname: 'parisrb')
        @api = Api::Vendors::Meetup.new(params)
      end

      def attributes_from_hash(hash, attributes)
        attributes.inject({}) do |h,k|
          a,m = k
          h[a] = hash.r(*m)
          h
        end
      end
    end

  end
end
