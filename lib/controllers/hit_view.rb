module HitView
  extend ActiveSupport::Concern

  module ClassMethods
    def hit_view
      self.after_filter({ only: [:show] }) do |controller|
        self.instance_variable_get("@#{self.class.name.chomp('Controller').singularize.underscore}").hit_view(request.user_agent, request.ip)
      end
    end
  end
end
