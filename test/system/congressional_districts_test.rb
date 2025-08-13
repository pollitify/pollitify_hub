require "application_system_test_case"

class CongressionalDistrictsTest < ApplicationSystemTestCase
  setup do
    @congressional_district = congressional_districts(:one)
  end

  test "visiting the index" do
    visit congressional_districts_url
    assert_selector "h1", text: "Congressional districts"
  end

  test "should create congressional district" do
    visit congressional_districts_url
    click_on "New congressional district"

    fill_in "Key city", with: @congressional_district.key_city
    fill_in "Key county", with: @congressional_district.key_county_id
    fill_in "Name", with: @congressional_district.name
    fill_in "State", with: @congressional_district.state_id
    click_on "Create Congressional district"

    assert_text "Congressional district was successfully created"
    click_on "Back"
  end

  test "should update Congressional district" do
    visit congressional_district_url(@congressional_district)
    click_on "Edit this congressional district", match: :first

    fill_in "Key city", with: @congressional_district.key_city
    fill_in "Key county", with: @congressional_district.key_county_id
    fill_in "Name", with: @congressional_district.name
    fill_in "State", with: @congressional_district.state_id
    click_on "Update Congressional district"

    assert_text "Congressional district was successfully updated"
    click_on "Back"
  end

  test "should destroy Congressional district" do
    visit congressional_district_url(@congressional_district)
    click_on "Destroy this congressional district", match: :first

    assert_text "Congressional district was successfully destroyed"
  end
end
