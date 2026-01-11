# frozen_string_literal: true

class RunIngressCheckJob < ApplicationJob
  class MissingIngressChecksError < StandardError; end

  SEND_EVERY = 6.hours
  EXPECT_WITHIN = 1.hour
  DELETE_AFTER = 10.days

  queue_as :default

  def perform
    send_new_ingress_check!
    destroy_old_checks
    check_undelivered_checks
  end

  private

  def send_new_ingress_check!
    return if IngressCheck.exists?(created_at: SEND_EVERY.ago..)

    check = IngressCheck.create!
    SystemMailer.ingress_check(check).deliver_now
  end

  def check_undelivered_checks
    count = IngressCheck.where(received_at: nil, created_at: ..EXPECT_WITHIN.ago).count
    return if count.zero?

    raise MissingIngressChecksError, "#{count} checks are not yet delivered"
  end

  def destroy_old_checks
    IngressCheck.where(created_at: ..DELETE_AFTER.ago).find_each(&:destroy!)
  end
end
