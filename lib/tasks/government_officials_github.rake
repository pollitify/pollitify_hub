#last_name,first_name,middle_name,suffix,nickname,full_name,birthday,gender,type,state,district,senate_class,party,url,address,phone,contact_form,rss_url,twitter,twitter_id,facebook,youtube,youtube_id,mastodon,bioguide_id,thomas_id,opensecrets_id,lis_id,fec_ids,cspan_id,govtrack_id,votesmart_id,ballotpedia_id,washington_post_id,icpsr_id,wikipedia_id


namespace :government_officials_github do 
  
  #rails g scaffold Organization name:string city:string state:string location:string organization_type:string
  
  # be rake government_officials_github:init --trace
  task :init => :environment do
    Rake::Task["government_officials_github:seed"].invoke
    Rake::Task["government_officials_github:metrics"].invoke
  end
  
  # be rake government_officials_github:set_data_source --trace
  task :set_data_source => :environment do
    gos = GovernmentOfficial.all
    gos.each do |go|
      go.data_source = "github_master_data.csv"
      go.save
    end
  end
  
  # be rake government_officials_github:rename_existing_with_a_z --trace
  task :rename_existing_with_a_z => :environment do
    government_officials = GovernmentOfficial.all
    government_officials.each do |go|
      go.update_column(:full_name, "#{go.full_name}__z")
    end
  end
  
  # be rake government_officials_github:seed
  task :seed => :environment do
    file_path = Rails.root.join('lib', 'tasks', 'data', 'github_master_data.csv')

    CSV.foreach(file_path, headers: true) do |row|
      #
      # Find the state
      #
      state = State.find_by_abbreviation(row['state'])
      #raise "Foo: Cannot find state: #{row['state']}" if state.nil?
      if state.nil?
        #debugger
        puts "HIT STATE NIL -- creating from #{row['state']}"
        state_struct = OpenStruct.new()
        state_struct.abbreviation = row["state"]
        status, state = State.find_or_create(state_struct)
      end
      puts "State found: #{state.id} -- #{row['state']}"
      
      #
      # Find the congressional district
      #
      congressional_district_struct = OpenStruct.new()
      congressional_district_struct.state_id = state.id
      congressional_district_struct.name = row['district']
      status, congressional_district = CongressionalDistrict.find_or_create(congressional_district_struct)
      puts "CongressionalDistrict found or created: #{congressional_district.id}"
      
      #
      # Find the government_official_type
      #
      government_official_type_struct = OpenStruct.new
      government_official_type_struct.name = GovernmentOfficial.get_title(row['type'])
      government_official_type_struct.fid = GovernmentOfficial.get_type(row['type'])
      status, government_official_type = GovernmentOfficialType.find_or_create(government_official_type_struct)
      puts "GovernmentOfficialType found or created: #{government_official_type.id}"
      
      political_party = PoliticalParty.find_by_name(row['party'])
      raise "blah -- can't find #{row['party']}" if political_party.nil?
      
      #
      # Create the Government Official
      #
      government_official_struct = OpenStruct.new(row)
      government_official_struct.birthday = Date.parse(government_official_struct.birthday)
      government_official_struct.congressional_district_id = congressional_district.id
      government_official_struct.government_official_type_id = government_official_type.id
      government_official_struct.political_party_id = political_party.id
      government_official_struct.delete_field(:type)
      government_official_struct.delete_field(:state)
      government_official_struct.state_id = state.id
      government_official_struct.title = GovernmentOfficial.get_title(row['type'])
      government_official_struct.phone_number = row['phone']
      government_official_struct.email_link = row['contact_form']
      government_official_struct.full_address = row['address']
      government_official_struct.job_type = row['type']
      
      status, government_official = GovernmentOfficial.find_or_create(government_official_struct)
      puts "Government official found: #{government_official.id}"
      #debugger if row['last_name'] == 'Carson'
      ##<CSV::Row "last_name":"Cantwell" "first_name":"Maria" "middle_name":nil "suffix":nil "nickname":nil "full_name":"Maria Cantwell" "birthday":"1958-10-13" "gender":"F" "type":"sen" "state":"WA" "district":nil "senate_class":"1" "party":"Democrat" "url":"https://www.cantwell.senate.gov" "address":"511 Hart Senate Office Building Washington DC 20510" "phone":"202-224-3441" "contact_form":"https://www.cantwell.senate.gov/public/index.cfm/email-maria" "rss_url":"http://www.cantwell.senate.gov/public/index.cfm/rss/feed" "twitter":"SenatorCantwell" "twitter_id":"117501995" "facebook":"senatorcantwell" "youtube":"SenatorCantwell" "youtube_id":"UCN52UDqKgvHRk39ncySrIMw" "mastodon":nil "bioguide_id":"C000127" "thomas_id":"00172" "opensecrets_id":"N00007836" "lis_id":"S275" "fec_ids":"S8WA00194,H2WA01054" "cspan_id":"26137" "govtrack_id":"300018" "votesmart_id":"27122" "ballotpedia_id":"Maria Cantwell" "washington_post_id":nil "icpsr_id":"39310" "wikipedia_id":"Maria Cantwell">
      #struct = OpenStruct.new
      
    end
    
  end
  
  # be rake government_officials_github:metrics
  task :metrics => :environment do
    klass = "GovernmentOfficial"
    puts "For object: #{klass.to_s}, there are #{klass.constantize.count} objects in the database"
  end

end