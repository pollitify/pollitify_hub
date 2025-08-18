class FixComments < ActiveRecord::Migration[8.0]
  def change
    add_reference :comments, :news_feed_item, null: false, foreign_key: true
    remove_column :comments, :feed_item_id
  end
end