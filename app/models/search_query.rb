class SearchQuery
  
  #
  # Resolve strings to actual objects so can query by IDs
  #
  def self.get_objects(city_string, state_string)
    # Step 1: Normalize state from abbreviation to a state object
    state_status, state = SearchQuery.normalize_state(state_string)
    
    # Step 2: Normalize city from fishers to Fishers
    city_status, city = SearchQuery.normalize_city(city_string, state) if state_status == 200
    
    # Step 3: Get county (which is just a look up)
    county_status, county = SearchQuery.get_county(city) if city_status == 200
    
    return state, city, county if state_status == 200 && city_status == 200 && county_status == 200
  end
  
  #
  # todo deal with failure case
  #
  def self.normalize_state(state_string)
    if state_string =~ /^[A-Z][A-Z]$/
      state = State.where(abbreviation: state_string).first
    else
      state = State.where(name: state_string).first      
    end
    return 200, state if state
  end
  
  #
  # todo deal with failure case
  #
  def self.normalize_city(city_string, state)
    if city_string =~ /^[^A-Z]+$/
      city = City.where(name: city_string.capitalize, state_id: state.id).first
    else
      city = City.where(name: city_string, state_id: state.id).first
    end
    return 200, city if city    
  end
  
  #
  # todo deal with failure case
  #=  
  def self.get_county(city)
    return 200, city.county
  end
  
  
end
