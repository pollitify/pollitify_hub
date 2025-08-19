require 'feedjira'
require "nokogiri"

class RssFeedFetcher
  def initialize(feed_url)
    @feed_url = feed_url
  end

  def fetch_and_store
    xml = Faraday.get(@feed_url).body
    feed = Feedjira.parse(xml)

    feed.entries.each do |entry|
      #debugger
      NewsFeedItem.find_or_create_by!(guid: entry.entry_id) do |item|
        cleaned_text = RssFeedFetcher.clean_text(entry.summary)
        
        item.title        = entry.title
        item.url          = entry.url
        item.summary      = entry.summary
        item.published_at = entry.published || Time.current
        item.image_url    = RssFeedFetcher.extract_image_url(cleaned_text)
        item.permalink    = RssFeedFetcher.extract_permalink(cleaned_text)
      end
    end
  end
  
  def self.clean_text(text)
    text.gsub(/\A<!\[CDATA\[|\]\]>\Z/, "")
  end
  
  def self.extract_permalink(cleaned_text)
    doc = Nokogiri::HTML.fragment(cleaned_text)

    # src attribute of first href
    doc.at("a")&.[]("href")
  end
  
  # RssFeedFetcher.extract_image_url(text)
  def self.extract_image_url(cleaned_text)
    doc = Nokogiri::HTML.fragment(cleaned_text)
    
    # src attribute of first image
    doc.at("img")&.[]("src")
  end
end