# frozen_string_literal: true

class CreateProxiedImages < ActiveRecord::Migration[7.1]
  def change
    create_table :proxied_images do |t|
      t.string :url, null: false
      t.references :entry, null: false, foreign_key: true

      t.timestamps

      t.index %i[url entry_id], unique: true
    end

    reversible do |dir|
      dir.up do
        Entry.find_each { |e| DetectEntryImagesJob.perform_later(e) }
      end
    end
  end
end
