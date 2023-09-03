# frozen_string_literal: true

class CreateEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :entries do |t|
      t.jsonb :data, null: false
      t.text :title
      t.text :author
      t.text :summary
      t.text :body
      t.text :external_id
      t.datetime :published_at
      t.text :url

      # Internal data
      t.references :feed, null: false, foreign_key: true

      # User interaction data
      t.datetime :read_at

      t.timestamps
      t.index %i[external_id feed_id], unique: true
    end
  end
end
