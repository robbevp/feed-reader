# frozen_string_literal: true

class AddNonNullToEntriesExternalId < ActiveRecord::Migration[8.1]
  def change
    up_only do
      Entry.where(external_id: nil).find_each do |entry|
        entry.update!(external_id: entry.url)
      end
    end

    change_column_null :entries, :external_id, false
  end
end
