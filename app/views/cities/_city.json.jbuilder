json.extract! city, :id, :name, :fid, :name_ascii, :state_fid, :state_name, :county_fips, :county_name, :lat, :lng, :coordinates, :population, :density, :source, :military, :incorporated, :timezone, :ranking, :external_fid, :state_id, :zips, :created_at, :updated_at
json.url city_url(city, format: :json)
