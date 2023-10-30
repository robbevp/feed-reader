# frozen_string_literal: true

require 'test_helper'

class NewsletterTest < ActiveSupport::TestCase
  # Callbacks
  test 'should set public_id on create' do
    newsletter = Newsletter.create

    assert_not_nil newsletter.public_id
  end

  # Validations
  test 'should not save in database with a public id that is not unique' do
    newsletter = create(:newsletter)

    assert_raises ActiveRecord::RecordNotUnique do
      # rubocop:disable Rails/SkipsModelValidations
      # We intentionally skip model validations to test the database constraint
      Newsletter.insert!({ public_id: newsletter.public_id })
      # rubocop:enable Rails/SkipsModelValidations
    end
  end

  # Methods
  test 'should construct expected mail address' do
    newsletter = create(:newsletter, public_id: 'abc')

    assert_equal "newsletter-#{newsletter.id}+abc@example.com", newsletter.email_address
  end
end
