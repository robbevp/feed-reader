# frozen_string_literal: true

class CreateFeeds < ActiveRecord::Migration[7.0]
  def change
    create_table :feeds do |t|
      t.references :user, foreign_key: true
      t.string :name, null: false
      t.text :url, null: false
      t.datetime :last_fetched_at

      t.timestamps
      t.index %i[url user_id], unique: true
    end
  end
end
