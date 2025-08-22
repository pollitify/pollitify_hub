namespace :seed do
  
  # bundle exec rake seed:init --trace
  task :init => :environment do
    
    
    #
    # Core setup data
    #
    #Rake::Task["generate_passwords_env_file:init"].invoke
    Rake::Task["domains:init"].invoke
    Rake::Task["feature_categories:init"].invoke
    Rake::Task["features:init"].invoke
    Rake::Task["secure_chat_systems:init"].invoke
    Rake::Task["states:init"].invoke
    #Rake::Task["organizations:init"].invoke
    Rake::Task["cities:init"].invoke
    Rake::Task["counties:init"].invoke
    Rake::Task["cities:set_county_id"].invoke
    ###Rake::Task["users:init"].invoke
    Rake::Task["google_sheet_urls:init"].invoke
    Rake::Task["news_feed_urls:init"].invoke
    Rake::Task["political_parties:init"].invoke
    Rake::Task["congressional_districts:init"].invoke
    Rake::Task["government_official_types:init"].invoke
    Rake::Task["government_officials_github:init"].invoke
    Rake::Task["government_officials:seed_from_open_states"].invoke
    #Rake::Task["users:seed"].invoke
    

  end
  
  # be rake seed:metrics --trace
  task :metrics => :environment do
    klasses = [Domain, FeatureCategory, Feature]
    klasses.each do |klass|
      puts "#{klass.name} -- #{klass.count}"
    end
  end
end