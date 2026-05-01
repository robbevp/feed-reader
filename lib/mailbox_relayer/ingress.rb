# frozen_string_literal: true

require_relative 'relayer'

# NOTE: This `main` method in this file does exactly the same as `rails action_mailbox:ingress:postfix`
# The only changes compared to that rake task are to make this work without relying on rails and linting fixes

def string_blank?(string)
  !string.is_a?(String) || string.empty?
end

# rubocop:disable Rails/Exit, Rails/Output
def main
  url, password = ENV.values_at('URL', 'INGRESS_PASSWORD')

  if string_blank?(url) || string_blank?(password)
    print '4.3.5 URL and INGRESS_PASSWORD are required'
    exit 1
  end

  MailboxRelayer::Relayer.new(url: url, password: password).relay(STDIN.read).tap do |result|
    print "#{result.status_code} #{result.message}"
    exit result.success?
  end
end
# rubocop:enable Rails/Exit, Rails/Output

main
