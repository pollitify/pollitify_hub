namespace :government_officials do
  # be rake government_officials_github:init --trace
  task :init => :environment do
    Rake::Task["government_officials:seed_federal_officials_from_github_data"].invoke
    Rake::Task["government_officials:metrics"].invoke
    Rake::Task["government_officials:seed_state_officials_from_open_states_data"].invoke
    Rake::Task["government_officials:metrics"].invoke
  end
  
  # be rake government_officials:fix_indiana_government_official_types --trace
  # task :fix_indiana_government_official_types => :environment do
  #   gos = GovernmentOfficial.where(government_official_type_id: 4).where(current_chamber: 'lower')
  #   gos.each do |go|
  #     go.government_official_type_id = GovernmentOfficialType.state_rep.id
  #     go.save
  #   end
  # end
  
  # be rake government_officials:fix_indiana_government_official_titles --trace
  # task :fix_indiana_government_official_titles => :environment do
  #   state_senators = GovernmentOfficial.where(government_official_type: GovernmentOfficialType.state_senator)
  #   state_representatives = GovernmentOfficial.where(government_official_type: GovernmentOfficialType.state_rep)
  #
  #   state_senators.each do |s|
  #     s.title = "State Senator"
  #     s.save
  #   end
  #
  #   state_representatives.each do |s|
  #     s.title = "State Representative"
  #     s.save
  #   end
  #
  # end
  
  
  
  
  
  
  task :seed_federal_officials_from_github_data => :environment do
    
    file_path = Rails.root.join('lib', 'tasks', 'data', 'github_master_data.csv')

    CSV.foreach(file_path, headers: true) do |row|
      
      #
      # Find the state
      #
      #debugger if Rails.env.development?
      state = State.find_by_abbreviation(row['state'])
      if state.nil?
        #debugger if Rails.env.development?
        puts "HIT STATE NIL -- creating from #{row['state']}"
        state_struct = OpenStruct.new()
        state_struct.name = row["state"]
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
      congressional_district_struct.congressional_district_type_id   = CongressionalDistrictType.federal.id
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
      go_struct = OpenStruct.new(row)
      go_struct.data_source = "github_master_data.csv"
      go_struct.birthday = Date.parse(go_struct.birthday)
      go_struct.congressional_district_id = congressional_district.id
      go_struct.government_official_type_id = government_official_type.id
      go_struct.political_party_id = political_party.id
      go_struct.district = go_struct.delete_field(:district)
      go_struct.delete_field(:type)
      go_struct.delete_field(:state)
      go_struct.state_id = state.id
      go_struct.title = GovernmentOfficial.get_title(row['type'])
      go_struct.phone_number = row['phone']
      go_struct.email_link = row['contact_form']
      go_struct.full_address = row['address']
      go_struct.job_type = row['type']
      
      status, government_official = GovernmentOfficial.find_or_create(go_struct)
      puts "Government official found: #{government_official.id}"
      #debugger if row['last_name'] == 'Carson'
      ##<CSV::Row "last_name":"Cantwell" "first_name":"Maria" "middle_name":nil "suffix":nil "nickname":nil "full_name":"Maria Cantwell" "birthday":"1958-10-13" "gender":"F" "type":"sen" "state":"WA" "district":nil "senate_class":"1" "party":"Democrat" "url":"https://www.cantwell.senate.gov" "address":"511 Hart Senate Office Building Washington DC 20510" "phone":"202-224-3441" "contact_form":"https://www.cantwell.senate.gov/public/index.cfm/email-maria" "rss_url":"http://www.cantwell.senate.gov/public/index.cfm/rss/feed" "twitter":"SenatorCantwell" "twitter_id":"117501995" "facebook":"senatorcantwell" "youtube":"SenatorCantwell" "youtube_id":"UCN52UDqKgvHRk39ncySrIMw" "mastodon":nil "bioguide_id":"C000127" "thomas_id":"00172" "opensecrets_id":"N00007836" "lis_id":"S275" "fec_ids":"S8WA00194,H2WA01054" "cspan_id":"26137" "govtrack_id":"300018" "votesmart_id":"27122" "ballotpedia_id":"Maria Cantwell" "washington_post_id":nil "icpsr_id":"39310" "wikipedia_id":"Maria Cantwell">
      #struct = OpenStruct.new
    end
  end


















  # be rake government_officials:seed_from_open_states --trace
  task :seed_state_officials_from_open_states_data => :environment do
    file_path = Rails.root.join('lib', 'tasks', 'data', 'open_states')
    Dir.glob(file_path.join("*.csv")).each do |csv_file|      
      # csv_file is a String path (not Pathname); affects state name extraction below
      CSV.foreach(csv_file, headers: true) do |row|
        #debugger if Rails.env.development?
        
        #
        # This is a data structure to represent what we are creating - a government official or go
        #
        go_struct = OpenStruct.new(row)
        
        #
        # Handle official type and title
        #
        if row["current_chamber"] == "upper"
          go_struct[:government_official_type_id] = GovernmentOfficialType.state_senator.id
          go_struct[:title] = "State Senator"          
        else
          go_struct[:government_official_type_id] = GovernmentOfficialType.state_rep.id
          go_struct[:title] = "State Representative"
        end
        
        #
        # HACK but it works
        #
        state_abbreviation = csv_file.split("/").last.to_s.split('.')[0].upcase
        state = State.where(abbreviation: state_abbreviation).first
        go_struct[:state_id] = state.id
        go_struct[:data_source] = csv_file.to_s
        
        #
        # HANDLE CONGRESSIONAL DISTRICT and STATE STYLE
        #
        congressional_district_struct = OpenStruct.new()
        congressional_district_struct.state_id = state.id
        congressional_district_struct.name = row['current_district']
        congressional_district_struct.congressional_district_type_id   = CongressionalDistrictType.state.id
        status, congressional_district = CongressionalDistrict.find_or_create(congressional_district_struct)
        puts "CongressionalDistrict found or created: #{congressional_district.id}"
        
        #
        # Field mapping; done in order of the CSV columns; the output of delete_field is the corresponding data
        #
        go_struct[:full_name] = go_struct.delete_field(:name)
        
        political_party = PoliticalParty.find_by_name(row['current_party'])
        if political_party.nil?
          if row['current_party'] == 'Democratic'
            political_party = PoliticalParty.democratic
          else
            # create new
            status, political_party = PoliticalParty.find_or_create(
              OpenStruct.new(name: row['current_party'], 
              fid: PoliticalParty.make_fid_from_name(row['current_party']))
            )
          end
        end
        go_struct.delete_field(:current_party)
        go_struct[:political_party_id] = political_party.id
        
        #
        # Remaining fields
        #
        go_struct[:fid] = go_struct.delete_field(:id)
        go_struct[:district] = go_struct.delete_field(:current_district)
        go_struct[:first_name] = go_struct.delete_field(:given_name)
        go_struct[:last_name] = go_struct.delete_field(:family_name)
        if row["birth_date"].nil?
          go_struct.delete_field(:birth_date)
        else
          go_struct[:birthday] = Date.parse(go_struct.delete_field(:birth_date))
        end
        if go_struct[:links].present?
          go_struct[:links] = go_struct.links.split(";").map(&:strip).reject(&:empty?)
        end
        if go_struct[:sources].present?
          go_struct[:sources] = go_struct.sources.split(";").map(&:strip).reject(&:empty?)
        end
        go_struct[:full_address] = go_struct.delete_field(:capitol_address)
      
        status, government_official = GovernmentOfficial.find_or_create(go_struct)
        
      end
    end
  end
  
  
  
  
  
  
  


        
        
        

        

        

        
        

        

        

  

  
  
  
  # be rake government_officials:seed_from_open_states_in --trace
#   task :seed_from_open_states_in => :environment do
#     id_at_start = GovernmentOfficial.maximum(:id)
#
#     file_path = Rails.root.join('lib', 'tasks', 'data', 'open_states', 'in.csv')
# =begin
#
# =end
#     CSV.foreach(file_path, headers: true) do |row|
#       #debugger
#       go_struct = OpenStruct.new(row)
#       go_struct[:government_official_type] = GovernmentOfficialType.state_senator
#       #
#       # HACK
#       #
#       state_abbreviation = file_path.basename.to_s.split('.')[0].upcase
#       go_struct[:state_id] = State.where(abbreviation: state_abbreviation).first.id
#       #debugger
#       #
#       #NO -- this is a state congressional district which is a lot smaller than a federal one
#       #
#       #go_struct[:congressional_district_id] = CongressionalDistrict.where(state_id: go_struct[:state_id], name: go_struct[:current_district]).first.id
#       go_struct[:title] = "State Senator"
#       go_struct[:data_source] = file_path.to_s
#       go_struct[:full_name] = go_struct.delete_field(:name)
#       political_party = PoliticalParty.find_by_name(row['current_party'])
#       if political_party.nil?
#         if row['current_party'] == 'Democratic'
#           political_party = PoliticalParty.democratic
#         end
#         raise "blah -- can't find political party #{row['current_party']}" if political_party.nil?
#       end
#       go_struct.delete_field(:current_party)
#
#
#       # status, political_party = PoliticalParty.find_or_create(OpenStruct.new(name: go_struct.current_party, go_struct.current_party.downcase))
#       go_struct[:political_party_id] = political_party.id
#
#       go_struct[:fid] = go_struct.delete_field(:id)
#       go_struct[:district] = go_struct.delete_field(:current_district)
#       go_struct[:first_name] = go_struct.delete_field(:given_name)
#       go_struct[:last_name] = go_struct.delete_field(:family_name)
#       if row["birth_date"].nil?
#         go_struct.delete_field(:birth_date)
#       else
#         go_struct[:birthday] = Date.parse(go_struct.delete_field(:birth_date))
#       end
#       go_struct[:links] = go_struct.links.split(";").map(&:strip).reject(&:empty?)
#       go_struct[:sources] = go_struct.sources.split(";").map(&:strip).reject(&:empty?)
#       go_struct[:full_address] = go_struct.delete_field(:capitol_address)
#
#       status, government_official = GovernmentOfficial.find_or_create(go_struct)
#
#       #"capitol_address":nil "capitol_voice":nil "capitol_fax":nil "district_address":nil "district_voice":nil "district_fax":nil "twitter":nil "youtube":nil "instagram":nil "facebook":nil "wikidata":nil
#
#       # raise row.inspect
#       puts "Remember: if you need to delete -- your maximum id at start was #{id_at_start}"
#       puts "delete all entries after that number"
#     end
#   end
  
  # be rake user:metrics
  task :metrics => :environment do
    klass = "GovernmentOfficial"
    puts "For object: #{klass.to_s}, there are #{klass.constantize.count} objects in the database"
  end
end