class NewsFeedUrl < ApplicationRecord
  
  has_many :news_feed_items
  
  IDENTITY_RELATIONSHIP = :all # could also be :all
  IDENTITY_COLUMNS = [:rss_url]
  include FindOrCreate
  
  validates_uniqueness_of :rss_url
  
  scope :ready_to_check, -> {
    if Rails.env.development?
      where("last_checked_at IS NULL OR last_checked_at < ?", 15.minutes.ago)
    else
      where("last_checked_at IS NULL OR last_checked_at < ?", 1.hours.ago)
    end
  }
  
  # NewsFeedUrl.crawl
  def self.crawl
    puts "At outer loop"
    NewsFeedUrl.all.each do |nfu|
      nfu.crawl
      nfu.last_checked_at = Time.now
    end
  end
  
  def crawl
    puts "Before crawl, total NewsFeedItems: #{NewsFeedItem.count}"
    #NewsFeedUrl.ready_to_check.find_each do |feed|
    NewsFeedUrl.find_each do |feed|
      # perform check...
      #feed.update!(last_checked_at: Time.current)
      puts "Ready to check: #{self.name} / #{self.rss_url}"
      
      feed.fetch_and_store
      
    end 
    puts " After crawl, total NewsFeedItems: #{NewsFeedItem.count}"
  end
  
  def fetch_and_store
    @feed_url = rss_url
    xml = Faraday.get(@feed_url).body
    feed = Feedjira.parse(xml)

    feed.entries.each do |entry|
      cleaned_text = RssFeedFetcher.clean_text(entry.summary)
      
      nfi_struct = OpenStruct.new
      nfi_struct.guid              = entry.entry_id
      nfi_struct.title             = entry.title
      nfi_struct.url               = entry.url
      nfi_struct.summary           = entry.summary
      nfi_struct.published_at      = entry.published || Time.current
      nfi_struct.image_url         = RssFeedFetcher.extract_image_url(cleaned_text)
      nfi_struct.permalink         = RssFeedFetcher.extract_permalink(cleaned_text)
      nfi_struct.news_feed_url_id  = NewsFeedUrl.first.id
      #debugger
      status, nfi_struct = NewsFeedItem.find_or_create(nfi_struct)
      
      if status == 200
        puts "Just stored: #{nfi_struct.id} -- #{entry.title}"
      else
        puts "Already exists: #{entry.title}"
      end
    end
  end
  
  def fetch_and_store_original
    @feed_url = rss_url
    xml = Faraday.get(@feed_url).body
    feed = Feedjira.parse(xml)

    feed.entries.each do |entry|
      NewsFeedItem.find_or_create_by!(guid: entry.entry_id) do |item|
        item.title        = entry.title
        item.url          = entry.url
        item.summary      = entry.summary
        item.published_at = entry.published || Time.current
        item.image_url    = RssFeedFetcher.extract_image_url(entry.summary)
        item.news_feed_url_id = NewsFeedUrl.first.id
        puts "Just stored: #{item.title}"
      end
    end
  end

  
end
