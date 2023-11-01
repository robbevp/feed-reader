# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.references :parent, null: true, foreign_key: { to_table: :categories }

      t.timestamps

      t.index %i[name parent_id], unique: true
    end

    change_table :subscriptions, bulk: true do |t|
      t.string :category_text
      t.references :category, null: true, foreign_key: true
    end
  end
end
