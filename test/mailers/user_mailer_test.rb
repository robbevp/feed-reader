# frozen_string_literal: true

require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  setup do
    @user = create(:user)
  end

  test 'should generate reset password mail' do
    mail = UserMailer.with(user: @user).reset_password

    assert_equal 'Reset your password', mail.subject
    assert_equal [@user.email], mail.to
    assert_equal ['noreply@example.org'], mail.from
  end

  test 'should include linked with signed id' do
    mail = UserMailer.with(user: @user).reset_password

    # Find the url with the signed id though regexp, as this url is not deterministic
    base_path = 'http://www.example.com/users/password/edit?token='
    signed_id_match = '[A-z0-9=]+--[a-z0-9]+'

    # Text part
    match = CGI.unescape(mail.text_part.body.to_s).match(/#{Regexp.quote base_path}(#{signed_id_match})/)

    assert_equal @user, User.find_by_token_for(:password_reset, match[1])

    # HTML part
    match = CGI.unescape(mail.html_part.body.to_s).match(/#{Regexp.quote base_path}(#{signed_id_match})/)

    assert_equal @user, User.find_by_token_for(:password_reset, match[1])
  end
end
