# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'instrumentmarket.com<donotreply@instrumentmarket.com>'
  layout 'mailer'
end
