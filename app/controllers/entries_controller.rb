# frozen_string_literal: true

class EntriesController < ApplicationController
  before_action :set_entry_search, only: %i[index]
  before_action :set_entry, only: %i[show update destroy]

  def index
    authorize Entry
    @pagy, @entries = pagy(@entry_search.apply(policy_scope(Entry).includes(:subscription)).order(published_at: :desc))
    @category_options = policy_scope(Category)
  end

  def show; end

  def update
    @entry.update!(transformed_attributes)
    redirect_back_or_to @entry
  end

  def destroy
    @entry.destroy!
    redirect_to @entry.subscription
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

  def set_entry_search
    search_params = params.fetch(:search, {}).permit(policy(Entry).permitted_attributes_for_index)
    @entry_search = EntrySearch.new(**search_params)
    session[:entry_search] = @entry_search.to_h
  end
end
