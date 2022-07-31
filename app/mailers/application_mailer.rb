# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('FROM_EMAIL', 'test@example.com')
  layout 'mailer'

  # Include any view helpers from your main app to use in mailers here
  helper ApplicationHelper
end
