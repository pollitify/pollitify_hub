require "application_system_test_case"

class CongressionalDistrictTypesTest < ApplicationSystemTestCase
  setup do
    @congressional_district_type = congressional_district_types(:one)
  end

  test "visiting the index" do
    visit congressional_district_types_url
    assert_selector "h1", text: "Congressional district types"
  end

  test "should create congressional district type" do
    visit congressional_district_types_url
    click_on "New congressional district type"

    fill_in "Fid", with: @congressional_district_type.fid
    fill_in "Name", with: @congressional_district_type.name
    click_on "Create Congressional district type"

    assert_text "Congressional district type was successfully created"
    click_on "Back"
  end

  test "should update Congressional district type" do
    visit congressional_district_type_url(@congressional_district_type)
    click_on "Edit this congressional district type", match: :first

    fill_in "Fid", with: @congressional_district_type.fid
    fill_in "Name", with: @congressional_district_type.name
    click_on "Update Congressional district type"

    assert_text "Congressional district type was successfully updated"
    click_on "Back"
  end

  test "should destroy Congressional district type" do
    visit congressional_district_type_url(@congressional_district_type)
    click_on "Destroy this congressional district type", match: :first

    assert_text "Congressional district type was successfully destroyed"
  end
end
