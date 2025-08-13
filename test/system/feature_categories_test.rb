require "application_system_test_case"

class FeatureCategoriesTest < ApplicationSystemTestCase
  setup do
    @feature_category = feature_categories(:one)
  end

  test "visiting the index" do
    visit feature_categories_url
    assert_selector "h1", text: "Feature categories"
  end

  test "should create feature category" do
    visit feature_categories_url
    click_on "New feature category"

    fill_in "Name", with: @feature_category.name
    click_on "Create Feature category"

    assert_text "Feature category was successfully created"
    click_on "Back"
  end

  test "should update Feature category" do
    visit feature_category_url(@feature_category)
    click_on "Edit this feature category", match: :first

    fill_in "Name", with: @feature_category.name
    click_on "Update Feature category"

    assert_text "Feature category was successfully updated"
    click_on "Back"
  end

  test "should destroy Feature category" do
    visit feature_category_url(@feature_category)
    click_on "Destroy this feature category", match: :first

    assert_text "Feature category was successfully destroyed"
  end
end
