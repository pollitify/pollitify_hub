namespace :government_official_types do 
  
  #rails g scaffold Organization name:string city:string state:string location:string organization_type:string
  
  # be rake government_official_types:init --trace
  task :init => :environment do
    Rake::Task["government_official_types:seed"].invoke
    Rake::Task["government_official_types:metrics"].invoke
  end
  
  
  # be rake government_official_types:seed --trace
  task :seed => :environment do
    
    government_official_type_structs = []
    
    government_official_type_structs << 
    OpenStruct.new(
      name: "Congress Person",
      fid: "congress_person"
    )
    
    government_official_type_structs << 
    OpenStruct.new(
      name: "Senator",
      fid: "senator"
    )
    
    government_official_type_structs << 
    OpenStruct.new(
      name: "Staff",
      fid: "staff"
    )
    
    government_official_type_structs << 
    OpenStruct.new(
      name: "State Senator",
      fid: "state_senator"
    )

    government_official_type_structs << 
    OpenStruct.new(
      name: "State Representative",
      fid: "state_representative"
    )
    
    add_government_official_types(government_official_type_structs)
  end
  
  def add_government_official_types(government_official_type_structs) 
    government_official_type_structs.each do |government_official_type_struct|
      puts "Processing visibility_struct:\n   #{government_official_type_struct.name}"

      status, government_official_type_struct = GovernmentOfficialType.find_or_create(government_official_type_struct)
    end
  end

  # be rake user:metrics
  task :metrics => :environment do
    klass = "GovernmentOfficialType"
    puts "For object: #{klass.to_s}, there are #{klass.constantize.count} objects in the database"
  end
  
end

