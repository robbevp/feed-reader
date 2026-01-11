# frozen_string_literal: true

class SystemMailer < ApplicationMailer
  INGRESS_CHECK_SUBJECT = 'INGRESS CHECK'

  def ingress_check(check)
    @check = check
    mail to: "system@#{Rails.application.config.inbound_email_domain}",
         subject: INGRESS_CHECK_SUBJECT
  end
end
