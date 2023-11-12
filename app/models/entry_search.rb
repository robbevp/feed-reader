# frozen_string_literal: true

class EntrySearch
  extend ActiveModel::Naming

  attr_reader :unread, :category_id

  def initialize(**values)
    values.symbolize_keys!
    @unread = ActiveModel::Type::Boolean.new.cast(values[:unread])
    @category_id = values[:category_id]
  end

  def apply(entry_scope)
    scopes.inject(entry_scope) { |entries, scope| entries.send(*scope) }
  end

  def to_hash
    { category_id:, unread: }.compact
  end

  alias unread? unread
  alias to_h to_hash

  private

  def scopes
    scopes = []
    scopes.push([:unread]) if unread?
    scopes.push([:by_category, category_id]) if category_id.present?
    scopes
  end
end
