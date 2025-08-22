namespace :political_parties do 
  
  #rails g scaffold Speech name:string tags:string organization:references speaker:references user:references event:references body:text 
  
  # be rake political_parties:init --trace
  task :init => :environment do
    Rake::Task["political_parties:seed"].invoke
    Rake::Task["political_parties:metrics"].invoke
  end
  
  # be rake user:seed --trace
  task :seed => :environment do
    
    political_parties = []

    political_parties << 
    OpenStruct.new(
      name: "Democrat",
      fid: "democrat",
      url: "https://democrats.org/"
    )

    political_parties << 
    OpenStruct.new(
      name: "Republican",
      fid: "republican",
      url: "https://www.rnc.org/"
    )

    political_parties << 
    OpenStruct.new(
      name: "MAGA",
      fid: "maga"
    )

    political_parties << 
    OpenStruct.new(
      name: "Independent",
      fid: "independent"
    )
    
    political_parties << 
    OpenStruct.new(
      name: "Green",
      fid: "green",
      url: "https://www.gp.org/"
    )
    
    political_parties << 
    OpenStruct.new(
      name: "DSA",
      fid: "dsa",
      url: "https://www.dsausa.org/"
    )
    
    political_parties << 
    OpenStruct.new(
      name: "Other",
      fid: "other"
    )
    
    political_parties << 
    OpenStruct.new( name: 'Nonpartisan', fid: 'nonpartisan')
    
    

    
    add_political_parties(political_parties)
  end
  
  def add_political_parties(political_parties) 
    political_parties.each do |political_party_struct|
      puts "Processing political_party_struct:\n   #{political_party_struct.name}"
      
      status, motion = PoliticalParty.find_or_create(political_party_struct)

    end
  end



  # be rake speaker:metrics
  task :metrics => :environment do
    klass = "PoliticalParty"
    puts "For object: #{klass.to_s}, there are #{klass.constantize.count} objects in the database"
  end
  
end

