namespace :google_sheet_urls do 
  #
  # be rake google_sheet_urls:init --trace
  task :init => :environment do
    Rake::Task["google_sheet_urls:seed"].invoke
    Rake::Task["google_sheet_urls:metrics"].invoke
  end
  
  # be rake user:seed --trace
  task :seed => :environment do
    #
    # https://www.indianaresistancealliance.org/ -- whole web site to crawl
    # https://www.indianaresistancealliance.org/reps.php
    #
    
    google_sheet_urls = []
    
    google_sheet_urls << OpenStruct.new(
      name: "We the People Dissent Protest Map",
      url: "https://docs.google.com/spreadsheets/d/1f-30Rsg6N_ONQAulO-yVXTKpZxXchRRB2kD3Zhkpe_A/preview?utm_source=substack&utm_medium=email",
      user_id: User.scott.id
    )
    
    google_sheet_urls << OpenStruct.new(
      name: "Indiana Resistance Alliance",
      url: "https://docs.google.com/spreadsheets/d/134J05okcx_bCpTXhofKej2niv-DurfHPBnS8PV02TuQ/edit?gid=0#gid=0",
      user_id: User.scott.id
    )
    
    add_google_sheet_urls(google_sheet_urls)
  end
  
  def add_google_sheet_urls(google_sheet_urls) 
    google_sheet_urls.each do |google_sheet_url_struct|
      puts "Processing GoogleSheetUrl:\n   #{google_sheet_url_struct.name}"
      
      status, google_sheet_url = GoogleSheetUrl.find_or_create(google_sheet_url_struct)

    end
  end



  # be rake speaker:metrics
  task :metrics => :environment do
    klass = "GoogleSheetUrl"
    puts "For object: #{klass.to_s}, there are #{klass.constantize.count} objects in the database"
  end
  
end

