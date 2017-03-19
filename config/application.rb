require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TableApi
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.action_mailer.default_url_options = { :host => 'localhost:3000' }
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.perform_deliveries = true
    ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.smtp_settings = {
       :address => "smtp.gmail.com",
       :port => 587,
       :domain => "gmail.com",
       :authentication => 'plain',
       :user_name => "stevenoscarolson@gmail.com",
       :password => "NewSong44",
       :enable_starttls_auto => true
    }

    # Get that webtoken file in lib
    config.autoload_paths << Rails.root.join('lib')
    config.eager_load_paths << Rails.root.join('lib')
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*',
            :headers => :any,
            :methods => [:get, :post, :delete, :put, :options]
      end
    end
  end
end
