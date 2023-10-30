# frozen_string_literal: true

class ApplicationMailbox < ActionMailbox::Base
  routing(/\Anewsletter-\d+\+\h+@/i => :newsletter)
end
