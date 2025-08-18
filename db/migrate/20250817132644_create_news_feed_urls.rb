class CreateNewsFeedUrls < ActiveRecord::Migration[8.0]
  def change
    create_table :news_feed_urls do |t|
      t.string :name
      t.string :rss_url
      t.datetime :last_checked_at

      t.timestamps
    end
  end
end
