# frozen_string_literal: true

require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "rails/test_unit/railtie"
require "csv"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# This is the main application class that our code runs in
module Classroom
  class Application < Rails::Application
    # Attempt to config CORS
    # config.middleware.insert_before 0, Rack::Cors do
    #   allow do
    #     origins 'localhost:3001', /https*:\/\/.*?google\.com/
    #     resource '*', :headers => :any, :methods => :any
    #   end
    # end

    # This also configures session_options for use below
    config.session_store :cookie_store, key: "_interslice_session"

    # Required for all session management (regardless of session_store)
    config.middleware.use ActionDispatch::Cookies

    config.middleware.use config.session_store, config.session_options
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.exceptions_app = routes
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}")]

    # Permitted locales available for the application
    config.i18n.available_locales = [:en]

    # Set default locale
    config.i18n.default_locale = :en

    # Use default language as fallback if translation is missing
    config.i18n.fallbacks = true

    # Don't generate system test files.
    config.generators.system_tests = nil
  end
end
