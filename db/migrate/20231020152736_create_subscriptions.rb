# frozen_string_literal: true

class CreateSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :subscriptions do |t|
      t.string :name, null: false
      t.references :user, null: false, foreign_key: true
      t.references :subscribable, polymorphic: true, null: false

      t.timestamps
    end

    rename_table :feeds, :rss_feeds

    change_table :entries, bulk: true do |t|
      t.references :subscription, foreign_key: true, null: true
      t.index %i[external_id subscription_id], unique: true
      t.remove_index %i[external_id feed_id], unique: true
    end

    change_table :rss_feeds, bulk: true do |t|
      t.change_null :user_id, true
      t.change_null :name, true
      t.remove_index %i[url user_id], unique: true
    end

    reversible do |dir|
      dir.up do
        RssFeed.find_each do |feed|
          subscription = Subscription.create!(name: feed.name, user_id: feed.user_id, subscribable: feed)
          # rubocop:disable Rails/SkipsModelValidations
          # We don't want callbacks or validations here
          Entry.where(feed_id: feed.id).update_all(subscription_id: subscription.id)
          # rubocop:enable Rails/SkipsModelValidations
        end
      end
      dir.down do
        RssFeed.find_each do |feed|
          subscription = feed.subscription
          feed.update(name: subscription.name, user_id: subscription.user_id)
          subscription.entries.update(feed_id: feed.id)
        end
      end
    end

    change_column_null :entries, :subscription_id, false

    change_table :rss_feeds, bulk: true do |t|
      t.remove_references :user, foreign_key: true, null: true
      t.remove :name, null: true, type: :string
    end

    change_table :entries, bulk: true do |t|
      t.remove :feed_id, type: :bigint, null: true
    end
  end
end
