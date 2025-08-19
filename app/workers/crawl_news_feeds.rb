class CrawlNewsFeeds
  include Sidekiq::Worker

  def perform(*args)
    NewsFeedUrl.crawl
    Rails.logger.info "Running CrawlNewsFeeds at #{Time.current}"
  end
end