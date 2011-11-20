module Api
  module Parisrb

    class EventAdapter < Base

      ATTRIBUTES_MATCHER = {
        api_id: ["id"],
        title: ["name"],
        description: ["description"],
        street: ["venue", "address_1"],
        city: ["venue","city"],
        website: ["event_url"],
        date: ["time"],
        latitude: ["venue","lat"],
        longitude: ["venue","lon"],
        attendees_count: ["yes_rsvp_count"],
        api_name: ["group", "urlname"]
      }

      def self.synchronize_from_api
        self.new.synchronize_from_api
      end

      def synchronize_from_api
        @api.get(:events).each do |event_hash|
          event_hash = attributes_from_hash(event_hash, ATTRIBUTES_MATCHER)
          event_hash.merge!(date: Time.at(event_hash[:date]/1000))
          event = Event.find_or_initialize_by_api_id_and_api_name(
                                                       event_hash[:api_id],
                                                       event_hash[:api_name],
                                                       event_hash
                                                             )
          event.send :set_slug
          event.save! validate: false
        end
      end
    end

  end
end
