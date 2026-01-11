# frozen_string_literal: true

# == Schema Information
#
# Table name: mail_ingest_checks
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  public_id  :text             not null
#
# Indexes
#
#  index_mail_ingest_checks_on_public_id  (public_id) UNIQUE
#
FactoryBot.define do
  factory :ingress_check do
    # No attributes to define
  end
end
