namespace :congressional_districts do 
  
  #rails g scaffold Speech name:string tags:string organization:references speaker:references user:references event:references body:text 
  
  # be rake congressional_districts:init --trace
  task :init => :environment do
    Rake::Task["congressional_districts:seed"].invoke
    Rake::Task["congressional_districts:metrics"].invoke
  end
  
  # be rake import_house:purge --trace
  task :purge => :environment do
    CongressionalDistrict.destroy_all
  end

  desc "TODO"
  # be rake import_house:g_people --trace
  task :seed => :environment do
    file_path = Rails.root.join('lib', 'tasks', 'data', 'congressional_districts.csv')
    row_ctr = 0
    first = true
    CSV.foreach(file_path, headers: true) do |row|
      #next if row_ctr == 0
      if first
         first = false
         next
      end
     state = State.find_by_name(row['State'])
     seats = row['Seats'].to_i

     1.upto(seats).each do |s|
       cd_struct = OpenStruct.new
       cd_struct.name = "#{s}"
       cd_struct.state_id = state.id
       #cd_struct.user_id = User.scott.id
       
       status, cd = CongressionalDistrict.find_or_create(cd_struct)
     end
   end
  end
  
  # be rake user:seed --trace
  task :seed_old_polly => :environment do
    
    congressional_district_structs = []

    congressional_district_structs << 
    OpenStruct.new(
      name: "1",
      state: "IN", 
      key_city: "Valparaiso",
      key_county: "Porter",
      user_id: User.scott.id
    )
    
    congressional_district_structs << 
    OpenStruct.new(
      name: "2",
      state: "IN", 
      key_city: "South Bend",
      key_county: "St. Joseph",
      user_id: User.scott.id
    )
    
    congressional_district_structs << 
    OpenStruct.new(
      name: "3",
      state: "IN", 
      key_city: "Fort Wayne",
      key_county: "Allen",
      user_id: User.scott.id
    )
    
    congressional_district_structs << 
    OpenStruct.new(
      name: "4",
      state: "IN", 
      key_city: "Lafayette",
      key_county: "Tippecanoe",
      user_id: User.scott.id
    )
    
    congressional_district_structs << 
    OpenStruct.new(
      name: "5",
      state: "IN", 
      key_city: "Muncie",
      key_county: "Hamilton",
      user_id: User.scott.id
    )
    
    congressional_district_structs << 
    OpenStruct.new(
      name: "6",
      state: "IN", 
      key_city: "Columbus / Rushville",
      key_county: "Bartholomew",
      user_id: User.scott.id
    )
    
    congressional_district_structs << 
    OpenStruct.new(
      name: "7",
      state: "IN", 
      key_city: "Indianapolis",
      key_county: "Marion",
      user_id: User.scott.id
    )
    
    congressional_district_structs << 
    OpenStruct.new(
      name: "8",
      state: "IN", 
      key_city: "Evansville",
      key_county: "Vanderburgh",
      user_id: User.scott.id
    )
    
    congressional_district_structs << 
    OpenStruct.new(
      name: "9",
      state: "IN", 
      key_city: "Greensburg / New Albany",
      key_county: "Decatur",
      user_id: User.scott.id
    )
    
    add_congressional_districts(congressional_district_structs)
  end
  
  def add_congressional_districts(congressional_district_structs) 
    congressional_district_structs.each do |congressional_district_struct|
      puts "Processing Congressional District:\n   #{congressional_district_struct.name}"
      
      status, congressional_district = CongressionalDistrict.find_or_create(congressional_district_struct)

    end
  end



  # be rake speaker:metrics
  task :metrics => :environment do
    klass = "CongressionalDistrict"
    puts "For object: #{klass.to_s}, there are #{klass.constantize.count} objects in the database"
  end
  
end

