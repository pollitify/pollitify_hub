namespace :users do
  # be rake users:add_location_fields_for_scott --trace
  task :add_location_fields_for_scott => :environment do
    state = LocationNormalizer.normalize(:state, "IN")
    county = LocationNormalizer.normalize(:county, "IN", "Hamilton")
    city = LocationNormalizer.normalize(:city, "IN", "Hamilton", "Fishers")
    u = User.scott
    u.state_id = state.id
    u.county_id = county.id
    u.city_id = city.id
    u.save
  end
end