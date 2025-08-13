json.extract! state, :id, :name, :abbreviation, :fid, :population, :congressional_district_count, :wikipedia_congressional_district_url, :wikipedia_congressional_district_map_url, :counties_count, :townships_count, :created_at, :updated_at
json.url state_url(state, format: :json)
