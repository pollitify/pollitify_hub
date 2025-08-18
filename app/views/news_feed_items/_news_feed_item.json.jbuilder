json.extract! news_feed_item, :id, :title, :url, :summary, :published_at, :guid, :source, :news_feed_url_id, :image_url, :created_at, :updated_at
json.url news_feed_item_url(news_feed_item, format: :json)
