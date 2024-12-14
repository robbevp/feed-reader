# frozen_string_literal: true

# == Schema Information
#
# Table name: proxied_images
#
#  id         :bigint           not null, primary key
#  url        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_proxied_images_on_url  (url) UNIQUE
#
FactoryBot.define do
  factory :proxied_image do
    url { Faker::Internet.unique.domain_name }
  end
end
