# frozen_string_literal: true

FactoryBot.define do
  factory :subscription do
    name { Faker::Lorem.word }
    user
    subscribable factory: :newsletter
  end
end
