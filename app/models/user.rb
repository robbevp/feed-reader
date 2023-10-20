# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  generates_token_for :password_reset, expires_in: 1.hour do
    BCrypt::Password.new(password_digest).salt.last(10)
  end

  has_many :subscriptions, dependent: :destroy
  has_many :entries, through: :subscriptions

  normalizes :email, with: ->(email) { email&.strip&.downcase }

  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    # The basic regex to validate emails was taken from devise
                    # See: https://github.com/heartcombo/devise/blob/9f80dc2562524f744e8633b8562f2a0114efb32b/lib/generators/templates/devise.rb#L186
                    format: { with: /\A[^@\s]+@[^@\s]+\z/ }
  validates :password_digest, presence: true
  validates :password, length: { minimum: 12 }, allow_nil: true
end
