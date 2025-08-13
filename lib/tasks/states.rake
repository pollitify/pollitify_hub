namespace :states do
  
  require 'csv'
  
  task :init => :environment do
    #Rake::Task["states:count"].invoke
    Rake::Task["states:import_population"].invoke    
  end
  
  # rake states:count --trace
  task :count => :environment do
    states = State.all
    states.each do |state|
      count = CongressionalDistrict.where(state_id: state.id).count
      state.update_column(:congressional_district_count, count)
    end
  end
  
  task :import_population => :environment do
    #ABBR,State,Population,NumCounties

    file_path = Rails.root.join('lib', 'tasks', 'data', 'state_population_and_counties.csv')

    CSV.foreach(file_path, headers: true) do |row|
      state_struct = OpenStruct.new(
        name: row['State'],
        abbreviation: row['ABBR'],
        population: row['Population'],
        fid: row['State'].downcase,
        counties_count: row['NumCounties']
      )
      status, state = State.find_or_create(state_struct)
      state.wikipedia_congressional_district_url = state.generate_url(:wikipedia_congressional_district_url)
      state.wikipedia_congressional_district_map_url = state.generate_url(:wikipedia_congressional_district_map_url)
      state.save
    end
  end
  
end