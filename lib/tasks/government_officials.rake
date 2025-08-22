namespace :government_officials do
  # be rake government_officials_github:init --trace
  task :init => :environment do
    Rake::Task["government_officials:seed_from_github"].invoke
    Rake::Task["government_officials:seed_from_open_states_in"].invoke
    Rake::Task["government_officials_github:metrics"].invoke
  end
  
  # be rake government_officials:fix_indiana_government_official_types --trace
  task :fix_indiana_government_official_types => :environment do
    gos = GovernmentOfficial.where(government_official_type_id: 4).where(current_chamber: 'lower')
    gos.each do |go|
      go.government_official_type_id = GovernmentOfficialType.state_rep.id
      go.save
    end
  end
  
  # be rake government_officials:fix_indiana_government_official_titles --trace
  task :fix_indiana_government_official_titles => :environment do
    state_senators = GovernmentOfficial.where(government_official_type: GovernmentOfficialType.state_senator)
    state_representatives = GovernmentOfficial.where(government_official_type: GovernmentOfficialType.state_rep)
    
    state_senators.each do |s|
      s.title = "State Senator"
      s.save
    end

    state_representatives.each do |s|
      s.title = "State Representative"
      s.save
    end

  end
  
  # be rake government_officials:seed_from_open_states --trace
  task :seed_from_open_states => :environment do
    file_path = Rails.root.join('lib', 'tasks', 'data', 'open_states')
    Dir.glob(file_path.join("*.csv")).each do |csv_file|
      #
      # Skip over indiana because already loaded
      #
      next if Rails.env.development? && csv_file =~ /in\.csv/
      
      # csv_file is a String path (not Pathname)
      CSV.foreach(csv_file, headers: true) do |row|
        # process each row
        #debugger
        go_struct = OpenStruct.new(row)
        
        #
        # Handle official type and title
        #
        if row["current_chamber"] == "upper"
          go_struct[:government_official_type_id] = GovernmentOfficialType.state_senator.id
          go_struct[:title] = "State Senator"          
        else
          go_struct[:government_official_type_id] = GovernmentOfficialType.state_rep.id
          go_struct[:title] = "State Rep"
        end
        
        #
        # HACK but it works
        #
        state_abbreviation = csv_file.split("/").last.to_s.split('.')[0].upcase
        go_struct[:state_id] = State.where(abbreviation: state_abbreviation).first.id
        go_struct[:data_source] = csv_file.to_s
        
        #
        # Field mapping; done in order of the CSV columns
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
  task :seed_from_open_states_in => :environment do
    id_at_start = GovernmentOfficial.maximum(:id)
    
    file_path = Rails.root.join('lib', 'tasks', 'data', 'open_states', 'in.csv')
=begin
    
=end
    CSV.foreach(file_path, headers: true) do |row|
      #debugger
      go_struct = OpenStruct.new(row)
      go_struct[:government_official_type] = GovernmentOfficialType.state_senator
      #
      # HACK
      #
      state_abbreviation = file_path.basename.to_s.split('.')[0].upcase
      go_struct[:state_id] = State.where(abbreviation: state_abbreviation).first.id
      #debugger
      #
      #NO -- this is a state congressional district which is a lot smaller than a federal one
      #
      #go_struct[:congressional_district_id] = CongressionalDistrict.where(state_id: go_struct[:state_id], name: go_struct[:current_district]).first.id
      go_struct[:title] = "State Senator"
      go_struct[:data_source] = file_path.to_s
      go_struct[:full_name] = go_struct.delete_field(:name)
      political_party = PoliticalParty.find_by_name(row['current_party'])
      if political_party.nil?
        if row['current_party'] == 'Democratic'
          political_party = PoliticalParty.democratic
        end
        raise "blah -- can't find political party #{row['current_party']}" if political_party.nil?
      end
      go_struct.delete_field(:current_party)
      
      
      # status, political_party = PoliticalParty.find_or_create(OpenStruct.new(name: go_struct.current_party, go_struct.current_party.downcase))
      go_struct[:political_party_id] = political_party.id
      
      go_struct[:fid] = go_struct.delete_field(:id)
      go_struct[:district] = go_struct.delete_field(:current_district)
      go_struct[:first_name] = go_struct.delete_field(:given_name)
      go_struct[:last_name] = go_struct.delete_field(:family_name)
      if row["birth_date"].nil?
        go_struct.delete_field(:birth_date)
      else
        go_struct[:birthday] = Date.parse(go_struct.delete_field(:birth_date))
      end
      go_struct[:links] = go_struct.links.split(";").map(&:strip).reject(&:empty?)
      go_struct[:sources] = go_struct.sources.split(";").map(&:strip).reject(&:empty?)
      go_struct[:full_address] = go_struct.delete_field(:capitol_address)
      
      status, government_official = GovernmentOfficial.find_or_create(go_struct)
       
      #"capitol_address":nil "capitol_voice":nil "capitol_fax":nil "district_address":nil "district_voice":nil "district_fax":nil "twitter":nil "youtube":nil "instagram":nil "facebook":nil "wikidata":nil
      
      # raise row.inspect
      puts "Remember: if you need to delete -- your maximum id at start was #{id_at_start}"
      puts "delete all entries after that number"
    end
  end
end