# frozen_string_literal: true

class CreateNewsletters < ActiveRecord::Migration[7.1]
  def change
    create_table :newsletters do |t|
      t.string :public_id, null: false
      t.timestamps
      t.index :public_id, unique: true
    end
  end
end
