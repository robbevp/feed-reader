# frozen_string_literal: true

class CreateIngressChecks < ActiveRecord::Migration[8.0]
  def change
    create_table :ingress_checks do |t|
      t.text :public_id, null: false
      t.datetime :received_at
      t.timestamps

      t.index :public_id, unique: true
    end
  end
end
