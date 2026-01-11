# frozen_string_literal: true

class ApplicationMailbox < ActionMailbox::Base
  routing(/^system@/ => :system)
  routing(all: :newsletter)
end
