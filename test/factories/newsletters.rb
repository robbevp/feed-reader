# frozen_string_literal: true

# == Schema Information
#
# Table name: newsletters
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  public_id  :string           not null
#
# Indexes
#
#  index_newsletters_on_public_id  (public_id) UNIQUE
#
FactoryBot.define do
  factory :newsletter do
    subscription { build(:subscription, subscribable: nil) }
  end
end
