require "test_helper"

class LocationNormalizerTest < ActiveSupport::TestCase
  setup do
    @state = FactoryBot.create(:state, name: "Indiana", abbreviation: "IN")
    @county = FactoryBot.create(:county, name: "Hamilton", state: @state)
    @city = FactoryBot.create(:city, name: "Fishers", state: @state, county: @county)
  end
  
  test ".normalize location just for state" do
    state = LocationNormalizer.normalize(:state, "IN")
    assert_equal "Indiana", state.name
    assert_equal "State", state.class.name    
  end
  
  test ".normalize location for both city and state" do
    city = LocationNormalizer.normalize(:city, "IN", nil, "Fishers")
    assert_equal "Fishers", city.name
    assert_equal "City", city.class.name
  end
  
  test ".normalize location for both county and state" do
    county = LocationNormalizer.normalize(:county, "IN", "Hamilton")
    assert_equal "Hamilton", county.name
    assert_equal "County", county.class.name
  end
  
  test ".normalize_state when given IN" do
    state = LocationNormalizer.normalize_state("IN")
    assert_equal "Indiana", state.name
    assert_equal "State", state.class.name    
  end
  
  test ".normalize_state when given in" do
    state = LocationNormalizer.normalize_state("IN")
    assert_equal "Indiana", state.name
    assert_equal "State", state.class.name    
  end

  test ".normalize_state when given Indiana" do
    state = LocationNormalizer.normalize_state("Indiana")
    assert_equal "Indiana", state.name
    assert_equal "State", state.class.name    
  end

  test ".normalize_state when given INDIANA" do
    state = LocationNormalizer.normalize_state("INDIANA")
    assert_equal "Indiana", state.name
    assert_equal "State", state.class.name    
  end
  
  test ".normalize_state when given indiana" do
    state = LocationNormalizer.normalize_state("indiana")
    assert_equal "Indiana", state.name
    assert_equal "State", state.class.name    
  end
  
  test ".normalize_city when given Fishers" do
    city = LocationNormalizer.normalize_city("IN","Fishers")
    assert_equal "Fishers", city.name
    assert_equal "City", city.class.name    
  end

  test ".normalize_city when given fishers" do
    city = LocationNormalizer.normalize_city("INDIANA","fishers")
    assert_equal "Fishers", city.name
    assert_equal "City", city.class.name    
  end
  
  test ".normalize_county when given Hamilton" do
    county = LocationNormalizer.normalize_county("IN","Hamilton")
    assert_equal "Hamilton", county.name
    assert_equal "County", county.class.name    
  end

  test ".normalize_county when given hamilton" do
    county = LocationNormalizer.normalize_county("INDIANA","hamilton")
    assert_equal "Hamilton", county.name
    assert_equal "County", county.class.name    
  end
end
