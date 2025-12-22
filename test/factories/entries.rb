# frozen_string_literal: true

# == Schema Information
#
# Table name: entries
#
#  id              :bigint           not null, primary key
#  author          :text
#  body            :text
#  data            :jsonb            not null
#  published_at    :datetime
#  read_at         :datetime
#  summary         :text
#  title           :text
#  url             :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  external_id     :text             not null
#  subscription_id :bigint           not null
#
# Indexes
#
#  index_entries_on_external_id_and_subscription_id  (external_id,subscription_id) UNIQUE
#  index_entries_on_subscription_id                  (subscription_id)
#
# Foreign Keys
#
#  fk_rails_...  (subscription_id => subscriptions.id)
#
FactoryBot.define do
  factory :entry do
    subscription
    data { { title: 'Entry title' } }
    external_id { Faker::Alphanumeric.unique.alphanumeric(number: 10) }

    trait :read do
      read_at { DateTime.current }
    end

    trait :with_all_details do
      author { Faker::Name.name }
      body { Faker::Lorem.paragraphs(number: 4) }
      summary { Faker::Lorem.paragraph(sentence_count: 2) }
      published_at { Faker::Time.between_dates(from: Date.current - 2.days, to: Date.current, period: :all) }
      title { Faker::Lorem.sentence(word_count: 3) }
      url { Faker::Internet.domain_name }
    end
  end
end
