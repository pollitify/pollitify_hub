class CreateNewsFeedItems < ActiveRecord::Migration[8.0]
  def change
    if Rails.env.production? 
      create_table :news_feed_items do |t|
        t.string :title
        t.string :url
        t.text :summary
        t.datetime :published_at
        t.string :guid
        t.string :source
        t.references :news_feed_url, foreign_key: true
        t.string :image_url

        t.timestamps
      end
      add_index :news_feed_items, :url, unique: true
      add_index :news_feed_items, :guid
    end
  end
end
