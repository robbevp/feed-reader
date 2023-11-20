# frozen_string_literal: true

FactoryBot.define do
  factory :proxied_image do
    url { Faker::Internet.unique.domain_name }
  end
end
