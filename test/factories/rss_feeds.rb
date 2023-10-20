# frozen_string_literal: true

FactoryBot.define do
  factory :rss_feed do
    url { Faker::Internet.url }
    subscription { build(:subscription, subscribable: nil) }
  end
end
