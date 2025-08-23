require "test_helper"

class CongressionalDistrictTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @congressional_district_type = congressional_district_types(:one)
  end

  test "should get index" do
    get congressional_district_types_url
    assert_response :success
  end

  test "should get new" do
    get new_congressional_district_type_url
    assert_response :success
  end

  test "should create congressional_district_type" do
    assert_difference("CongressionalDistrictType.count") do
      post congressional_district_types_url, params: { congressional_district_type: { fid: @congressional_district_type.fid, name: @congressional_district_type.name } }
    end

    assert_redirected_to congressional_district_type_url(CongressionalDistrictType.last)
  end

  test "should show congressional_district_type" do
    get congressional_district_type_url(@congressional_district_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_congressional_district_type_url(@congressional_district_type)
    assert_response :success
  end

  test "should update congressional_district_type" do
    patch congressional_district_type_url(@congressional_district_type), params: { congressional_district_type: { fid: @congressional_district_type.fid, name: @congressional_district_type.name } }
    assert_redirected_to congressional_district_type_url(@congressional_district_type)
  end

  test "should destroy congressional_district_type" do
    assert_difference("CongressionalDistrictType.count", -1) do
      delete congressional_district_type_url(@congressional_district_type)
    end

    assert_redirected_to congressional_district_types_url
  end
end
