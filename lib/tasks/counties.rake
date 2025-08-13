namespace :counties do
  
  # be rake counties:init --trace
  task :init => :environment do
    #Rake::Task["states:count"].invoke
    Rake::Task["counties:import"].invoke    
    Rake::Task["counties:add_zips_to_counties_from_cities"].invoke    
    
  end
  
  task :import => :environment do
    
    #"city","city_ascii","state_id","state_name","county_fips","county_name","lat","lng","population","density","source","military","incorporated","timezone","ranking","zips","id"

    County.destroy_all
    file_path = Rails.root.join('lib', 'tasks', 'data', 'uscounties.csv')

    CSV.foreach(file_path, headers: true) do |row|
      #debugger
      #"county","county_ascii","county_full","county_fips","state_id","state_name","lat","lng","population"
      county_struct = OpenStruct.new(
        name: row['county'],
        #fid: row['county'].downcase.gsub(/ +/,'_'),
        name_ascii: row['county_ascii'],
        name_full: row['county_full'],
        county_fips: row['county_fips'],
        state_id: State.find_by_name(row['state_name']).try(:id),
        state_abbreviation: row['state_id'],
        state_name: row['state_name'],
        lat: row['lat'],
        lng: row['lng'],
        population: row['population']
      )
      puts "About to process: #{row['county']} | #{row['state_name']} - #{county_struct}"
      
      factory = RGeo::Geographic.spherical_factory(srid: 4326)
      # coordinates: #<RGeo::Geographic::SphericalPointImpl:0xfde8 "POINT (39.9588 39.9588)">,
      point = factory.point(row['lat'], row['lng'])
      county_struct.coordinates = point
      #debugger
      status, county = County.find_or_create(county_struct)
    end
  end
  
  task :add_zips_to_counties_from_cities => :environment do
    County.all.each do |county|
      cities = City.where(county_fips: county.county_fips)
      cities.each do |city|
        if county.zips.blank?
          county.zips = city.zips
        else
          county.zips = "#{county.zips} #{city.zips}"
        end
        county.save
      end
    end
  end
  
  #
  # DO NOT USE
  #
  task :create_counties_from_cities => :environment do 
    County.destroy_all
    City.all.each do |city|
      county = County.where(name: city.county_name, state_id: city.state_id).first
      
      if county.nil?
        #County name:string state_name:string state:references population:integer county_fips:integer zips:text timezone:string
        # create via struct
        county_struct = OpenStruct.new(
          name: city.county_name,
          state_name: city.state_name,
          state_id: city.state_id, 
          population: city.population,
          county_fips: city.county_fips,
          zips: city.zips,
          timezone: city.timezone        
        )
        #debugger
        status, county = County.find_or_create(county_struct)
      else
        # update population and zips 
        county.population = county.population + city.population
        county.zips = "#{county.zips} #{city.zips}"
        county.save
      end
      
    end
  end
end