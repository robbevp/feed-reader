# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :bigint
#
# Indexes
#
#  index_categories_on_name_and_parent_id  (name,parent_id) UNIQUE
#  index_categories_on_parent_id           (parent_id)
#
# Foreign Keys
#
#  fk_rails_...  (parent_id => categories.id)
#
FactoryBot.define do
  factory :category do
    name { Faker::Lorem.unique.word }
  end
end
