namespace :news_item do
  # be rake news_item:sample --trace
  task :sample => :environment do 
    
    # require 'numo/narray'
    #
    # # Create a dummy NVector class that points to Numo::DFloat (or NArray)
    # NVector = Class.new(Numo::DFloat)
    #
    # require 'kmeans-clusterer'
    # Example usage
    articles = [
      NewsItem.new("Apple announces new iPhone", "The new iPhone 15 is released today."),
      NewsItem.new("Tech stocks soar", "Apple and Microsoft lead the market surge."),
      NewsItem.new("Local sports update", "High school football game results."),
      NewsItem.new("iPhone 15 review", "The new iPhone 15 has amazing features.")
    ]

    tfidf = TfIdf.new(articles)
    vectors = articles.map { |a| tfidf.vector(a) }

    clusters = hierarchical_clustering(vectors, threshold: 0.25)

    clusters.each_with_index do |cluster, i|
      puts "Cluster #{i + 1}:"
      cluster.each do |idx|
        puts "  - #{articles[idx].title}"
      end
    end
  end
end
