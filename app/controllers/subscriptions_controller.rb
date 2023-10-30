# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: %i[show edit update destroy]
  def index
    authorize Subscription
    @subscriptions = policy_scope(Subscription)
                     .includes(:subscribable)
                     .left_joins(:entries)
                     .select('subscriptions.*', 'count(entries.id) as entries_count')
                     .group(:id).order(:name)
  end

  def new
    authorize Subscription
    @subscription = Subscription.new
  end

  def create
    authorize Subscription
    @subscription = Subscription.new(permitted_attributes(Subscription).merge(user: current_user))
    if @subscription.save
      flash[:success] = t '.success'
      redirect_to @subscription
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @pagy, @entries = pagy(@subscription.entries.order(published_at: :desc))
  end

  def edit; end

  def update
    if @subscription.update(permitted_attributes(@subscription))
      flash[:success] = t '.success'
      redirect_to @subscription
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # This method should not fail
    @subscription.destroy!
    flash[:success] = t '.success'
    redirect_to subscriptions_path
  end

  private

  def set_subscription
    @subscription = policy_scope(Subscription).find(params[:id])
    authorize @subscription
  end
end
