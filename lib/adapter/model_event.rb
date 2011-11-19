require 'model_base'

module Adapter
  module Model
    module Event

      class Meetup < Adapter::Model::Base
        def initialize(*args)
          @api = Api::Meetup.new(:events)
          super(*args)
        end

        def get(options = {})
          @api.get(settings.merge(options))
        end

        private
        def settings
          params = @model.adapter_name.to_s.split('_')
          @settings ||= {
            key: Settings.adapter.try(params.first.to_sym).key,
            group_urlname: Settings.adapter.try(params.first.to_sym).
            try(params.second.to_sym).name,
          }
        end
      end

    end
  end
end
