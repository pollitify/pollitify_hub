require "test_helper"

class SearchQueryTest < ActiveSupport::TestCase
  setup do
    @state = FactoryBot.create(:state, name: "Indiana", abbreviation: "IN")
    @county = FactoryBot.create(:county, name: "Hamilton", state: @state)
    @city = FactoryBot.create(:city, name: "Fishers", state: @state, county: @county)
  end
  
  test ".normalize_state - when given an abbreviation return a state object" do 
    status, state = SearchQuery.normalize_state("IN")
    assert_equal 200, status
    assert_equal "Indiana", state.name
    assert_equal "State", state.class.name
  end

  test ".normalize_state - when given an name return a state object" do 
    status, state = SearchQuery.normalize_state("Indiana")
    assert_equal "Indiana", state.name
    assert_equal "State", state.class.name
  end
  
  test ".normalize_city - when given a lower case return a city object" do 
    status, city = SearchQuery.normalize_city("fishers", @state)
    assert_equal 200, status
    assert_equal "Fishers", city.name
    assert_equal "City", city.class.name
  end

  test ".normalize_city - when given a name return a city object" do 
    status, city = SearchQuery.normalize_city("Fishers", @state)
    assert_equal "Fishers", city.name
    assert_equal "City", city.class.name
  end
  
  test ".get_county - when given a name and a state, return the county object" do
    status, county = SearchQuery.get_county(@city)
    assert_equal 200, status
    assert_equal "Hamilton", county.name
    assert_equal "County", county.class.name
  end
  
end
