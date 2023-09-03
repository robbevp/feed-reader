# frozen_string_literal: true

class EntriesController < ApplicationController
  before_action :set_entry, only: %i[show update]

  def index
    authorize Entry
    @entries = policy_scope(Entry).order(published_at: :desc).unread.limit(20)
  end

  def show; end

  def update
    @entry.update!(transformed_attributes)
    redirect_back_or_to @entry
  end

  private

  def set_entry
    @entry = policy_scope(Entry).find params[:id]
    authorize @entry
  end

  def transformed_attributes
    attrs = permitted_attributes(@entry)
    attrs[:read_at] = attrs.delete(:read) == 'true' ? DateTime.current : nil
    attrs
  end
end
