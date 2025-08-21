namespace :news_feed_items do
  # be rake news_feed_items:load_from_feed_items --trace
  task :load_from_feed_items => :environment do
    feed_items = FeedItem.order("id ASC")
    feed_items.each do |fi|
      nfi = NewsFeedItem.new(fi.attributes)
      nfi.news_feed_url_id = NewsFeedUrl.first.id
      if nfi.save
      else
        raise nfi.errors.full_messages.inspect
      end
    end
  end
  
  # be rake news_feed_items:set_authors_and_news_source_names --trace

end