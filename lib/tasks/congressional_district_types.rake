namespace :congressional_district_types do 
  
  #rails g scaffold Speech name:string tags:string organization:references speaker:references user:references event:references body:text 
  
  # be rake congressional_district_types:init --trace
  task :init => :environment do
    Rake::Task["congressional_district_types:seed"].invoke
    Rake::Task["congressional_district_types:metrics"].invoke
  end
  
  # be rake import_house:purge --trace
  task :purge => :environment do
    raise "Foo"
    CongressionalDistrictType.destroy_all
  end

  # be rake congressional_districts:g_people --trace
  task :seed => :environment do
    congressional_district_type_structs = []
    
    congressional_district_type_structs << OpenStruct.new(
      name: "Federal",
      fid: "federal"
    )

    congressional_district_type_structs << OpenStruct.new(
      name: "State",
      fid: "state"
    )
    
    add_congressional_district_types(congressional_district_type_structs)       
  end
  
  
  def add_congressional_district_types(congressional_district_type_structs) 
    congressional_district_type_structs.each do |congressional_district_type_struct|
      puts "Processing Congressional District Type:\n   #{congressional_district_type_struct.name}"
      
      status, congressional_district_type = CongressionalDistrictType.find_or_create(congressional_district_type_struct)

    end
  end



  # be rake speaker:metrics
  task :metrics => :environment do
    klass = "CongressionalDistrictType"
    puts "For object: #{klass.to_s}, there are #{klass.constantize.count} objects in the database"
  end
  
end

