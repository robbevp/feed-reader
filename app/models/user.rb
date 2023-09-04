# frozen_string_literal: true

class User < ApplicationRecord
  # NOTE: Delete when upgrading to rails 7.1
  attr_accessor :password_challenge

  has_secure_password

  has_many :feeds, dependent: :destroy

  before_validation :normalize_email

  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    # The basic regex to validate emails was taken from devise
                    # See: https://github.com/heartcombo/devise/blob/9f80dc2562524f744e8633b8562f2a0114efb32b/lib/generators/templates/devise.rb#L186
                    format: { with: /\A[^@\s]+@[^@\s]+\z/ }
  validates :password_digest, presence: true
  validates :password, length: { minimum: 12 }, allow_nil: true
  # NOTE: Delete when upgrading to rails 7.1
  validate :check_password_challenge

  # Reset password
  # NOTE: Replace with `generates_token_for` when upgrading to rails 7.1
  def self.token_verifier
    @token_verifier ||= Rails.application.message_verifier('feed_reader/user_token')
  end

  def self.find_by_password_reset_token(password_reset_token)
    payload = token_verifier.verified(password_reset_token)
    user = find_by(id: payload && payload[0])
    return nil if user.nil?

    salt = BCrypt::Password.new(user.password_digest).salt[-10..]
    user if payload == [user.id, salt]
  end

  def password_reset_token(expires_in: nil)
    # We use the current password digest to generate a token
    # This way a changed password, will cause the token to be invalid
    salt = BCrypt::Password.new(password_digest).salt[-10..]
    self.class.token_verifier.generate([id, salt], expires_in:)
  end

  private

  def normalize_email
    email&.strip!&.downcase!
  end

  def check_password_challenge
    return if password_challenge.nil?
    return if password_digest_was.present? && BCrypt::Password.new(password_digest_was).is_password?(password_challenge)

    errors.add(:password_challenge)
  end
end
