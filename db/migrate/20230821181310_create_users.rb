# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'citext'

    create_table :users do |t|
      t.citext :email, null: false
      t.string :password_digest, null: false
      t.boolean :admin, null: false, default: false

      t.timestamps

      t.index :email, unique: true
    end
  end
end
