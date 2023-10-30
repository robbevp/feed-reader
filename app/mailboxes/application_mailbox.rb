# frozen_string_literal: true

class ApplicationMailbox < ActionMailbox::Base
  routing(all: :newsletter)
end
