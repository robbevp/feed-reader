# frozen_string_literal: true

FactoryBot.define do
  factory :proxied_image do
    entry
    url { Faker::Internet.domain_name }
  end
end
