namespace :feature_categories do 
  
  task :clear => :environment do
    FeatureCategory.destroy_all
  end
  
  # be rake feature_categories:init --trace
  task :init => :environment do
    Rake::Task["feature_categories:seed"].invoke
    Rake::Task["feature_categories:metrics"].invoke
  end
  
  # be rake user:seed --trace
  task :seed => :environment do
    
    feature_categories = []
    
    feature_categories << OpenStruct.new( name: 'Security', fid: 'security')
    feature_categories << OpenStruct.new( name: 'Financial', fid: 'financial')
    feature_categories << OpenStruct.new( name: 'Events', fid: 'events')
    feature_categories << OpenStruct.new( name: 'Office', fid: 'office')
    feature_categories << OpenStruct.new( name: 'General', fid: 'general')
    feature_categories << OpenStruct.new( name: 'Get Elected', fid: 'get_elected')
    feature_categories << OpenStruct.new( name: 'Raise Funds', fid: 'raise_funds')
    feature_categories << OpenStruct.new( name: 'Research', fid: 'research')
    feature_categories << OpenStruct.new( name: 'Group Communications', fid: 'group_communications')
    
    add_feature_categories(feature_categories)
  end
  
  def add_feature_categories(feature_categories) 
    feature_categories.each do |feature_category_struct|
      puts "Processing Feature Category:\n   #{feature_category_struct.name}"
      
      status, feature_category = FeatureCategory.find_or_create(feature_category_struct)

    end
  end



  # be rake speaker:metrics
  task :metrics => :environment do
    klass = "FeatureCategory"
    puts "For object: #{klass.to_s}, there are #{klass.constantize.count} objects in the database"
  end
  
end

