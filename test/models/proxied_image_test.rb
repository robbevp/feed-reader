# frozen_string_literal: true

require 'test_helper'

class ProxiedImageTest < ActiveSupport::TestCase
  # Validations
  test 'should not be valid without a url' do
    image = build(:proxied_image, url: nil)

    assert_not_predicate image, :valid?
    assert_includes image.errors['url'], "can't be blank"
  end

  test 'should not save in database with an url that is not unique for entry' do
    entry = create(:entry)
    stub_request(:any, 'http://example.com/image.jpg')
      .to_return(body: Rails.root.join('test/fixtures/files/image.jpg').read)
    
    create(:proxied_image, entry:, url: 'http://example.com/image.jpg')

    assert_raises ActiveRecord::RecordNotUnique do
      # rubocop:disable Rails/SkipsModelValidations
      # We intentionally skip model validations to test the database constraint
      ProxiedImage.insert!(attributes_for(:proxied_image, entry_id: entry.id, url: 'http://example.com/image.jpg'))
      # rubocop:enable Rails/SkipsModelValidations
    end
  end
end
