module Adapter
  module Model
    extend ActiveSupport::Concern
    autoload :Event, "model_event"

    def adapter
      check_adapter_name!
      @adapter ||= adapter_name_to_constant.new(self)
    end

    private
    def adapter_name_to_constant
      "Adapter::Model::#{self.class.name}::#{self.adapter_name.to_s.split('_').first.camelize}".constantize
    end

    def check_adapter_name!
      raise "'#{self.adapter_name}' is not a valid adapter_name!" if self.adapter_name.blank? #add more check
    end
  end
end
