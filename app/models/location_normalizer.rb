class LocationNormalizer
  
  def self.normalize(type, state_string, county_string=nil, city_string=nil)
    if type == :state
      return LocationNormalizer.normalize_state(state_string)
    end
    
    if type == :county
      return LocationNormalizer.normalize_county(state_string, county_string)
    end
    
    if type == :city
      return LocationNormalizer.normalize_city(state_string, city_string)
    end
  end
  
  def self.normalize_state(state_string)
    state_string_stripped = state_string.strip
    if state_string_stripped.size == 2
      state = State.where(abbreviation: state_string_stripped.upcase).first
      return state if state
    else
      state = State.where(name: state_string_stripped.capitalize).first
      return state if state
    end
    return nil
  end
  
  def self.normalize_county(state_string, county_string)
    state = LocationNormalizer.normalize_state(state_string)
    county_string_stripped = county_string.strip
    county = County.where(state_id: state.id, name: county_string_stripped.capitalize).first
    return county if county 
  end  
  
  def self.normalize_city(state_string, city_string)
    state = LocationNormalizer.normalize_state(state_string)
    city_string_stripped = city_string.strip
    city = City.where(state_id: state.id, name: city_string_stripped.capitalize).first
    return city if city 
  end  
end
