class RemoveIndexOnNewsFeedItemsUrl < ActiveRecord::Migration[8.0]
  def change
    remove_index :news_feed_items, name: "index_news_feed_items_on_url"
  end
end
