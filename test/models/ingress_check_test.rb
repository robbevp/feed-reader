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
require 'test_helper'

class IngressCheckTest < ActiveSupport::TestCase
  # Callbacks
  test 'should set public_id on create' do
    check = IngressCheck.create

    assert_not_nil check.public_id
  end

  # Validations
  test 'should not save in database with a public id that is not unique' do
    check = create(:ingress_check)

    assert_raises ActiveRecord::RecordNotUnique do
      # rubocop:disable Rails/SkipsModelValidations
      # We intentionally skip model validations to test the database constraint
      IngressCheck.insert!({ public_id: check.public_id })
      # rubocop:enable Rails/SkipsModelValidations
    end
  end
end
