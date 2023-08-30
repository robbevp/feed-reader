# frozen_string_literal: true

FactoryBot.define do
  factory :feed do
    user
    name { Faker::Lorem.word }
    url { Faker::Internet.domain_name }
  end
end
