require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module RailsFrance
  class Application < Rails::Application

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += ["#{config.root}/lib/core_ext", "#{config.root}/lib/models",
      "#{config.root}/lib/controllers", "#{config.root.join}/app/presenters",
      "#{config.root.join}/lib/api"]

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    config.active_record.observers = :job_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.time_zone = 'Paris'

    # The default locale is :fr and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.available_locales = [:fr]
    config.i18n.load_path += Dir[Rails.root.join('config','locales', '**','*.{rb,yml}').to_s]
    config.i18n.default_locale = :fr

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password, :confirmation_password]

    config.middleware.use Rack::Gauges, :tracker => '4f292c3f844d522d4d000033'

    # 404 catch all routes
    config.after_initialize do |app|
      app.routes.append{ match '*a', :to => 'application#render_not_found' } unless config.consider_all_requests_local
    end

    # Devise mailer layout
    config.to_prepare do
      Devise::Mailer.layout "mail"
    end

    config.action_view.javascript_expansions[:defaults] = %w()

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'
  end
end
