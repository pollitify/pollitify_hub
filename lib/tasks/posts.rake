namespace :posts do 
  #
  # be rake posts:init --trace
  task :init => :environment do
    Rake::Task["posts:seed"].invoke
    Rake::Task["posts:metrics"].invoke
  end
  
  # be rake user:seed --trace
  task :seed => :environment do
    #
    # https://www.indianaresistancealliance.org/ -- whole web site to crawl
    # https://www.indianaresistancealliance.org/reps.php
    #
    
    posts = []
    
    posts << OpenStruct.new(
      user_id: User.scott.id, 
      content: "I attended my first protest.  We shouted, we marched and we held our signs high.  It was inspiring.",
      post_type: "event_attendance", 
      activity_date: Date.new(2025,2,3),
      location: "Indianapolis, IN"
    )
    

    add_posts(posts)
  end
  
  def add_posts(posts) 
    posts.each do |post|
      puts "Processing Post:\n   #{post.content}"
      
      status, post = Post.find_or_create(post)

    end
  end



  # be rake speaker:metrics
  task :metrics => :environment do
    klass = "Post"
    puts "For object: #{klass.to_s}, there are #{klass.constantize.count} objects in the database"
  end
  
end

