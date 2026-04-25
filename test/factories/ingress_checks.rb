# frozen_string_literal: true

# == Schema Information
#
# Table name: ingress_checks
#
#  id          :bigint           not null, primary key
#  received_at :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  public_id   :text             not null
#
# Indexes
#
#  index_ingress_checks_on_public_id  (public_id) UNIQUE
#
FactoryBot.define do
  factory :ingress_check do
    trait :received do
      received_at { DateTime.current }
    end
  end
end
