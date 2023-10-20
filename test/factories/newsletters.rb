# frozen_string_literal: true

FactoryBot.define do
  factory :newsletter do
    subscription { build(:subscription, subscribable: nil) }
  end
end
