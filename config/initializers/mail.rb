# Assign the from email address in all environments
Rails.application.reloader.to_prepare do
  ActionMailer::Base.default_options = {from: ENV.fetch("FROM_EMAIL", "test@example.com")}

  if Rails.env.production?
    ActionMailer::Base.default_url_options[:host] = ENV.fetch("APP_DOMAIN", "example.com")
    ActionMailer::Base.smtp_settings.merge!({}) # TODO Rob email settings
  end
end
