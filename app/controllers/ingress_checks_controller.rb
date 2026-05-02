# frozen_string_literal: true

class IngressChecksController < ApplicationController
  def index
    authorize IngressCheck
    @checks = policy_scope(IngressCheck).order(created_at: :desc)
  end

  def create
    authorize IngressCheck
    check = IngressCheck.create!
    SystemMailer.ingress_check(check).deliver_later

    redirect_to ingress_checks_path
  end
end
