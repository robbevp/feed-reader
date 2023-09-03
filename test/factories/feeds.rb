# frozen_string_literal: true

FactoryBot.define do
  factory :feed do
    user
    name { Faker::Lorem.word }
    url { Faker::Internet.url }
  end
end
