json.extract! county, :id, :name, :name_ascii, :name_full, :county_fips, :state_id, :state_abbreviation, :state_name, :lat, :lng, :coordinates, :population, :created_at, :updated_at
json.url county_url(county, format: :json)
