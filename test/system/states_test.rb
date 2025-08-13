require "application_system_test_case"

class StatesTest < ApplicationSystemTestCase
  setup do
    @state = states(:one)
  end

  test "visiting the index" do
    visit states_url
    assert_selector "h1", text: "States"
  end

  test "should create state" do
    visit states_url
    click_on "New state"

    fill_in "Abbreviation", with: @state.abbreviation
    fill_in "Congressional district count", with: @state.congressional_district_count
    fill_in "Counties count", with: @state.counties_count
    fill_in "Fid", with: @state.fid
    fill_in "Name", with: @state.name
    fill_in "Population", with: @state.population
    fill_in "Townships count", with: @state.townships_count
    fill_in "Wikipedia congressional district map url", with: @state.wikipedia_congressional_district_map_url
    fill_in "Wikipedia congressional district url", with: @state.wikipedia_congressional_district_url
    click_on "Create State"

    assert_text "State was successfully created"
    click_on "Back"
  end

  test "should update State" do
    visit state_url(@state)
    click_on "Edit this state", match: :first

    fill_in "Abbreviation", with: @state.abbreviation
    fill_in "Congressional district count", with: @state.congressional_district_count
    fill_in "Counties count", with: @state.counties_count
    fill_in "Fid", with: @state.fid
    fill_in "Name", with: @state.name
    fill_in "Population", with: @state.population
    fill_in "Townships count", with: @state.townships_count
    fill_in "Wikipedia congressional district map url", with: @state.wikipedia_congressional_district_map_url
    fill_in "Wikipedia congressional district url", with: @state.wikipedia_congressional_district_url
    click_on "Update State"

    assert_text "State was successfully updated"
    click_on "Back"
  end

  test "should destroy State" do
    visit state_url(@state)
    click_on "Destroy this state", match: :first

    assert_text "State was successfully destroyed"
  end
end
