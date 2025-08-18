json.extract! news_feed_url, :id, :name, :rss_url, :last_checked_at, :created_at, :updated_at
json.url news_feed_url_url(news_feed_url, format: :json)
