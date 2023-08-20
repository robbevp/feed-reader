# frozen_string_literal: true

require 'test_helper'

class GoodJobTest < ActiveSupport::TestCase
  test 'should not have any pending migrations' do
    assert_predicate GoodJob, :migrated?,
                     'GoodJob has pending migrations.' \
                     'Run `rails g good_job:update` and `rails db:migrate` to ensure all migrations are applied'
  end
end
