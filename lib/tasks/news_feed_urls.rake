namespace :news_feed_urls do 
  
  # be rake news_feed_urls:init --trace
  task :init => :environment do
    Rake::Task["news_feed_urls:seed"].invoke
    Rake::Task["news_feed_urls:metrics"].invoke
  end
  
  # be rake user:seed --trace
  task :seed => :environment do
    
    news_feed_urls = []
    
    # news_feed_urls << OpenStruct.new(
    #   name: '',
    #   fid: '',
    #   feature_category_id: '',
    #   description: ''
    # )
    
    news_feed_urls << OpenStruct.new(
      name: 'Memeorandum',
      rss_url: 'https://www.memeorandum.com/top_feed.xml',
    )
    
    add_news_feed_urls(news_feed_urls)
  end
  
  def add_news_feed_urls(news_feed_urls) 
    news_feed_urls.each do |news_feed_url_struct|
      puts "Processing NewsFeedUrl:\n   #{news_feed_url_struct.name}"
      
      status, news_feed_url = NewsFeedUrl.find_or_create(news_feed_url_struct)

    end
  end



  # be rake speaker:metrics
  task :metrics => :environment do
    klass = "NewsFeedUrl"
    puts "For object: #{klass.to_s}, there are #{klass.constantize.count} objects in the database"
  end
  
end

