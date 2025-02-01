# frozen_string_literal: true

class AddLastErrorToRssFeed < ActiveRecord::Migration[8.0]
  def change
    change_table :rss_feeds, bulk: true do |t|
      t.integer :error_count, default: 0, null: false
      t.string :latest_error
    end
  end
end
