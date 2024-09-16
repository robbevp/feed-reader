# frozen_string_literal: true

class AddEtagLastModifiedToRssFeeds < ActiveRecord::Migration[7.2]
  def change
    change_table :rss_feeds, bulk: true do |t|
      t.datetime :last_modified_at
      t.string :last_etag
    end
  end
end
