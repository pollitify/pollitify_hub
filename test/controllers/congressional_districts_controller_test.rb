require "test_helper"

class CongressionalDistrictsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @congressional_district = congressional_districts(:one)
  end

  test "should get index" do
    get congressional_districts_url
    assert_response :success
  end

  test "should get new" do
    get new_congressional_district_url
    assert_response :success
  end

  test "should create congressional_district" do
    assert_difference("CongressionalDistrict.count") do
      post congressional_districts_url, params: { congressional_district: { key_city: @congressional_district.key_city, key_county_id: @congressional_district.key_county_id, name: @congressional_district.name, state_id: @congressional_district.state_id } }
    end

    assert_redirected_to congressional_district_url(CongressionalDistrict.last)
  end

  test "should show congressional_district" do
    get congressional_district_url(@congressional_district)
    assert_response :success
  end

  test "should get edit" do
    get edit_congressional_district_url(@congressional_district)
    assert_response :success
  end

  test "should update congressional_district" do
    patch congressional_district_url(@congressional_district), params: { congressional_district: { key_city: @congressional_district.key_city, key_county_id: @congressional_district.key_county_id, name: @congressional_district.name, state_id: @congressional_district.state_id } }
    assert_redirected_to congressional_district_url(@congressional_district)
  end

  test "should destroy congressional_district" do
    assert_difference("CongressionalDistrict.count", -1) do
      delete congressional_district_url(@congressional_district)
    end

    assert_redirected_to congressional_districts_url
  end
end
