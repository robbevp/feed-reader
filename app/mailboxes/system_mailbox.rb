# frozen_string_literal: true

class SystemMailbox < ApplicationMailbox
  def process
    case mail.subject
    when SystemMailer::INGRESS_CHECK_SUBJECT
      process_ingress_check
    end
  end

  private

  def process_ingress_check
    match = mail.decoded.match(/ID: ([\da-f]+)$/)
    return if match.nil?

    IngressCheck.find_by(public_id: match[1], received_at: nil)&.update!(received_at: DateTime.current)
  end
end
