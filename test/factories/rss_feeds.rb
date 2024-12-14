# frozen_string_literal: true

# == Schema Information
#
# Table name: rss_feeds
#
#  id               :bigint           not null, primary key
#  last_etag        :string
#  last_fetched_at  :datetime
#  last_modified_at :datetime
#  url              :text             not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
FactoryBot.define do
  factory :rss_feed do
    url { Faker::Internet.url }
    subscription { build(:subscription, subscribable: nil) }
  end
end
