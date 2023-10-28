# frozen_string_literal: true

FactoryBot.define do
  factory :subscription do
    name { Faker::Lorem.word }
    user
    subscribable factory: :rss_feed
  end
end
