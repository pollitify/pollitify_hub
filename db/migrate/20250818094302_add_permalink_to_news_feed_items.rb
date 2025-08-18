class AddPermalinkToNewsFeedItems < ActiveRecord::Migration[8.0]
  def change
    add_column :news_feed_items, :permalink, :string
  end
end