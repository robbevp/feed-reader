# frozen_string_literal: true

class JoinTableProxiedImagesEntries < ActiveRecord::Migration[7.1]
  def change
    create_join_table :proxied_images, :entries

    reversible do |dir|
      dir.up do
        ProxiedImage.select(:url, 'array_agg(id) as ids',
                            'array_agg(entry_id) as entry_ids').group(:url).each do |group|
          ids = group.ids
          keep = ProxiedImage.find(ids.pop)
          keep.entry_ids = group[:entry_ids].compact
          keep.save!

          ProxiedImage.where(id: ids).destroy_all
        end
      end
      dir.down do
        ProxiedImage.find_each do |image|
          ids = image.entry_ids
          image.update(entry_id: ids.pop)
          ids.each do |entry_id|
            copy = image.dup
            copy.entry_id = entry_id
            copy.save!
          end
        end
      end
    end

    remove_index :proxied_images, %i[url entry_id], unique: true

    change_table :proxied_images, bulk: true do |t|
      t.remove_references :entry
      t.index :url, unique: true
    end
  end
end
