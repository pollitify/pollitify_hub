require "application_system_test_case"

class CitiesTest < ApplicationSystemTestCase
  setup do
    @city = cities(:one)
  end

  test "visiting the index" do
    visit cities_url
    assert_selector "h1", text: "Cities"
  end

  test "should create city" do
    visit cities_url
    click_on "New city"

    fill_in "Coordinates", with: @city.coordinates
    fill_in "County fips", with: @city.county_fips
    fill_in "County name", with: @city.county_name
    fill_in "Density", with: @city.density
    fill_in "External fid", with: @city.external_fid
    fill_in "Fid", with: @city.fid
    check "Incorporated" if @city.incorporated
    fill_in "Lat", with: @city.lat
    fill_in "Lng", with: @city.lng
    check "Military" if @city.military
    fill_in "Name", with: @city.name
    fill_in "Name ascii", with: @city.name_ascii
    fill_in "Population", with: @city.population
    fill_in "Ranking", with: @city.ranking
    fill_in "Source", with: @city.source
    fill_in "State fid", with: @city.state_fid
    fill_in "State", with: @city.state_id
    fill_in "State name", with: @city.state_name
    fill_in "Timezone", with: @city.timezone
    fill_in "Zips", with: @city.zips
    click_on "Create City"

    assert_text "City was successfully created"
    click_on "Back"
  end

  test "should update City" do
    visit city_url(@city)
    click_on "Edit this city", match: :first

    fill_in "Coordinates", with: @city.coordinates
    fill_in "County fips", with: @city.county_fips
    fill_in "County name", with: @city.county_name
    fill_in "Density", with: @city.density
    fill_in "External fid", with: @city.external_fid
    fill_in "Fid", with: @city.fid
    check "Incorporated" if @city.incorporated
    fill_in "Lat", with: @city.lat
    fill_in "Lng", with: @city.lng
    check "Military" if @city.military
    fill_in "Name", with: @city.name
    fill_in "Name ascii", with: @city.name_ascii
    fill_in "Population", with: @city.population
    fill_in "Ranking", with: @city.ranking
    fill_in "Source", with: @city.source
    fill_in "State fid", with: @city.state_fid
    fill_in "State", with: @city.state_id
    fill_in "State name", with: @city.state_name
    fill_in "Timezone", with: @city.timezone
    fill_in "Zips", with: @city.zips
    click_on "Update City"

    assert_text "City was successfully updated"
    click_on "Back"
  end

  test "should destroy City" do
    visit city_url(@city)
    click_on "Destroy this city", match: :first

    assert_text "City was successfully destroyed"
  end
end
