# frozen_string_literal: true

# == Schema Information
#
# Table name: subscriptions
#
#  id                :bigint           not null, primary key
#  category_text     :string
#  name              :string           not null
#  subscribable_type :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  category_id       :bigint
#  subscribable_id   :bigint           not null
#  user_id           :bigint           not null
#
# Indexes
#
#  index_subscriptions_on_category_id   (category_id)
#  index_subscriptions_on_subscribable  (subscribable_type,subscribable_id)
#  index_subscriptions_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :subscription do
    name { Faker::Lorem.word }
    user
    subscribable factory: :newsletter
  end
end
