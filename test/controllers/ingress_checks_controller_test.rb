# frozen_string_literal: true

require 'test_helper'

class IngressChecksControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in create(:user, :admin)
    @check = IngressCheck.create!
  end

  test 'should get index' do
    get ingress_checks_path

    assert_response :success

    assert_dom '.table__cell', text: @check.id.to_s
  end

  test 'should create new check' do
    assert_difference 'IngressCheck.count' do
      post ingress_checks_path
    end

    assert_enqueued_emails 1
  end
end
