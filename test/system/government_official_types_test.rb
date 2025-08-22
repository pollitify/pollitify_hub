require "application_system_test_case"

class GovernmentOfficialTypesTest < ApplicationSystemTestCase
  setup do
    @government_official_type = government_official_types(:one)
  end

  test "visiting the index" do
    visit government_official_types_url
    assert_selector "h1", text: "Government official types"
  end

  test "should create government official type" do
    visit government_official_types_url
    click_on "New government official type"

    fill_in "Fid", with: @government_official_type.fid
    fill_in "Name", with: @government_official_type.name
    click_on "Create Government official type"

    assert_text "Government official type was successfully created"
    click_on "Back"
  end

  test "should update Government official type" do
    visit government_official_type_url(@government_official_type)
    click_on "Edit this government official type", match: :first

    fill_in "Fid", with: @government_official_type.fid
    fill_in "Name", with: @government_official_type.name
    click_on "Update Government official type"

    assert_text "Government official type was successfully updated"
    click_on "Back"
  end

  test "should destroy Government official type" do
    visit government_official_type_url(@government_official_type)
    click_on "Destroy this government official type", match: :first

    assert_text "Government official type was successfully destroyed"
  end
end
