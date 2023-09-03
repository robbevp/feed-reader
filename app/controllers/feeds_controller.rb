# frozen_string_literal: true

class FeedsController < ApplicationController
  before_action :set_feed, only: %i[show edit update destroy]
  def index
    authorize Feed
    @feeds = policy_scope(Feed).left_joins(:entries).select('feeds.*',
                                                            'count(*) as entries_count').group(:id).order(:name)
  end

  def new
    authorize Feed
    @feed = Feed.new
  end

  def create
    authorize Feed
    @feed = Feed.new(permitted_attributes(Feed).merge(user: current_user))
    if @feed.save
      flash[:success] = t '.success'
      RefreshFeedJob.perform_later(@feed)
      redirect_to @feed
    else
      flash[:danger] = t '.danger'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @entries = @feed.entries.order(published_at: :desc)
  end

  def edit; end

  def update
    if @feed.update(permitted_attributes(@feed))
      flash[:success] = t '.success'
      redirect_to @feed
    else
      flash[:danger] = t '.danger'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # This method should not fail
    @feed.destroy!
    flash[:success] = t '.success'
    redirect_to feeds_path
  end

  private

  def set_feed
    @feed = policy_scope(Feed).find(params[:id])
    authorize @feed
  end
end
