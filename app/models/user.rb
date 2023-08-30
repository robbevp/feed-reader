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
