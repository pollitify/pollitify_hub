namespace :cities do
  
  require 'csv'
  
  task :init => :environment do
    #Rake::Task["cities:count"].invoke
    Rake::Task["cities:import"].invoke    
  end
  
  # be rake cities:set_county_id --trace
  task :set_county_id => :environment do
    City.all.each do |city|
      puts "Processing city: #{city.id} --- #{city.name} in state: #{city.state_name}"
      county = County.where(name: city.county_name, state_id: city.state_id).first
      city.update_column(:county_id, county.id) if county
    end
  end
  
  # rake states:count --trace
  task :count => :environment do
    cities = City.all
    cities.each do |city|
      count = City.count
      #state.update_column(:congressional_district_count, count)
    end
  end
  
  
  
  # be rake cities:import --trace
  task :import => :environment do
    #"city","city_ascii","state_id","state_name","county_fips","county_name","lat","lng","population","density","source","military","incorporated","timezone","ranking","zips","id"


    file_path = Rails.root.join('lib', 'tasks', 'data', 'uscities.csv')

    CSV.foreach(file_path, headers: true) do |row|
      #debugger
      city_struct = OpenStruct.new(
        name: row['city'],
        fid: row['city'].downcase.gsub(/ +/,'_'),
        name_ascii: row['city_ascii'],
        state_fid: row['state_id'],
        state_name: row['state_name'],
        county_fips: row['county_fips'],
        county_name: row['county_name'],
        lat: row['lat'],
        lng: row['lng'],
        #coordinates: "[#{row['lat']}, #{row['lat']}]",
        population: row['population'], 
        density: row['density'],
        source: row['source'],
        military: City.get_boolean(row['military']),
        incorporated: City.get_boolean(row['incorporated']),
        timezone: row['timezone'],
        ranking: row['ranking'],
        external_fid: row['id'],
        state_id: State.find_by_name(row['state_name']).try(:id),
        zips: row['zips']
      )
      puts "About to process: #{row['city']} | #{row['state_name']} - #{city_struct}"
      
      factory = RGeo::Geographic.spherical_factory(srid: 4326)
      # coordinates: #<RGeo::Geographic::SphericalPointImpl:0xfde8 "POINT (39.9588 39.9588)">,
      point = factory.point(row['lat'], row['lng'])
      city_struct.coordinates = point
      #debugger
      status, city = City.find_or_create(city_struct)
      
      # if state.nil?
      #   debugger
      # end
      # status, state = State.find_or_create(state_struct)
      # state.wikipedia_congressional_district_url = state.generate_url(:wikipedia_congressional_district_url)
      # state.wikipedia_congressional_district_map_url = state.generate_url(:wikipedia_congressional_district_map_url)
      # state.save
    end
  end
  
end