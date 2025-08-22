require "test_helper"

class GovernmentOfficialTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @government_official_type = government_official_types(:one)
  end

  test "should get index" do
    get government_official_types_url
    assert_response :success
  end

  test "should get new" do
    get new_government_official_type_url
    assert_response :success
  end

  test "should create government_official_type" do
    assert_difference("GovernmentOfficialType.count") do
      post government_official_types_url, params: { government_official_type: { fid: @government_official_type.fid, name: @government_official_type.name } }
    end

    assert_redirected_to government_official_type_url(GovernmentOfficialType.last)
  end

  test "should show government_official_type" do
    get government_official_type_url(@government_official_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_government_official_type_url(@government_official_type)
    assert_response :success
  end

  test "should update government_official_type" do
    patch government_official_type_url(@government_official_type), params: { government_official_type: { fid: @government_official_type.fid, name: @government_official_type.name } }
    assert_redirected_to government_official_type_url(@government_official_type)
  end

  test "should destroy government_official_type" do
    assert_difference("GovernmentOfficialType.count", -1) do
      delete government_official_type_url(@government_official_type)
    end

    assert_redirected_to government_official_types_url
  end
end
