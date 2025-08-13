require "test_helper"

class CountiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @county = counties(:one)
  end

  test "should get index" do
    get counties_url
    assert_response :success
  end

  test "should get new" do
    get new_county_url
    assert_response :success
  end

  test "should create county" do
    assert_difference("County.count") do
      post counties_url, params: { county: { coordinates: @county.coordinates, county_fips: @county.county_fips, lat: @county.lat, lng: @county.lng, name: @county.name, name_ascii: @county.name_ascii, name_full: @county.name_full, population: @county.population, state_abbreviation: @county.state_abbreviation, state_id: @county.state_id, state_name: @county.state_name } }
    end

    assert_redirected_to county_url(County.last)
  end

  test "should show county" do
    get county_url(@county)
    assert_response :success
  end

  test "should get edit" do
    get edit_county_url(@county)
    assert_response :success
  end

  test "should update county" do
    patch county_url(@county), params: { county: { coordinates: @county.coordinates, county_fips: @county.county_fips, lat: @county.lat, lng: @county.lng, name: @county.name, name_ascii: @county.name_ascii, name_full: @county.name_full, population: @county.population, state_abbreviation: @county.state_abbreviation, state_id: @county.state_id, state_name: @county.state_name } }
    assert_redirected_to county_url(@county)
  end

  test "should destroy county" do
    assert_difference("County.count", -1) do
      delete county_url(@county)
    end

    assert_redirected_to counties_url
  end
end
