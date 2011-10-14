module PreLoginParams
  extend ActiveSupport::Concern

  module ClassMethods
    private

    def keep_params(resource, options = {})
      self.before_filter(options.slice(:only, :except)) do
        return if user_signed_in?
        session[resource] = params[resource]
        session[:pre_login_path] = request.referer
        authenticate_user!
      end
    end

    def load_params(resource, options = {})
      self.before_filter(options.slice(:only, :except)) do
        object = resource.to_s.capitalize.constantize
        self.instance_variable_set("@#{resource.to_s}", object.new(session[resource]))
        session[resource] = nil
        session[:pre_login_path] = nil
      end
    end
  end
end
