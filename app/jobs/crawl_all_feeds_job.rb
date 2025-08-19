class CrawlAllFeedsJob < ApplicationJob
  queue_as :default

  def perform
    #debugger
    NewsFeedUrl.crawl
    NewsFeedUrl.where("last_checked_at IS NULL OR last_checked_at < ?", 1.hours.ago)
               .find_each do |feed|
      FetchRssFeedJob.perform_later(feed.id)
    end
  end
end