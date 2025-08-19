class FetchRssFeedJob < ApplicationJob
  queue_as :default

  def perform(news_feed_url_id)
    feed = NewsFeedUrl.find(news_feed_url_id)
    RssFeedFetcher.new(feed).fetch_and_store
  end
end