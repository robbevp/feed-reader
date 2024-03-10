# frozen_string_literal: true

class EntrySearch
  extend ActiveModel::Naming

  attr_reader :include_read, :category_id

  def initialize(**values)
    values.symbolize_keys!
    @include_read = ActiveModel::Type::Boolean.new.cast(values[:include_read])
    @category_id = values[:category_id]
  end

  def apply(entry_scope)
    scopes.inject(entry_scope) { |entries, scope| entries.send(*scope) }
          .order(published_at: :desc, id: :asc)
  end

  def next(entry_scope, current)
    apply(entry_scope).where.not(id: current.id).find_by(published_at: ..current.published_at)
  end

  def previous(entry_scope, current)
    apply(entry_scope).reverse_order.where.not(id: current.id).find_by(published_at: current.published_at..)
  end

  def to_hash
    { category_id:, include_read: }.compact
  end

  alias include_read? include_read
  alias to_h to_hash

  private

  def scopes
    scopes = []
    scopes.push([:unread]) unless include_read?
    scopes.push([:by_category, category_id]) if category_id.present?
    scopes
  end
end
