class AddNewSourceNameAndAuthorToNewsFeedItems < ActiveRecord::Migration[8.0]
  def change
    add_column :news_feed_items, :author, :string
    add_column :news_feed_items, :news_source_name, :string
  end
end
