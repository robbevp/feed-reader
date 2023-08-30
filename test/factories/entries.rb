# frozen_string_literal: true

FactoryBot.define do
  factory :entry do
    feed
    data { { title: 'Entry title' } }
    
    trait :with_all_details do
      author { Faker::Name.name }
      body { Faker::Lorem.paragraphs(number: 4) }
      external_id { Faker::Alphanumeric.unique.alphanumeric(number: 10) }
      summary { Faker::Lorem.paragraph(sentence_count: 2) }
      published_at { Faker::Time.between_dates(from: Date.current - 2.days, to: Date.current, period: :all) }
      title { Faker::Lorem.sentence(word_count: 3) }
      url { Faker::Internet.domain_name }
    end
  end
end
