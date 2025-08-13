require "test_helper"

class FeaturesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @feature = FactoryBot.create(:feature)
    @user = FactoryBot.create(:user)
    @feature_category = FactoryBot.create(:feature_category, fid: "dddd")
  end
  
  test "should get index if not logged in" do
    get features_url
    assert_response :redirect
  end
  
  test "should get index if logged in" do
    sign_in @user
    get features_url
    assert_response :success
  end
  
  
  
  test "should get new if not logged in" do
    get new_feature_url
    assert_response :redirect
  end

  test "should get new if logged in" do
    sign_in @user
    get new_feature_url
    assert_response :success
  end



  test "should NOT create feature_category if not logged in" do
    assert_no_difference("Feature.count") do
      post domains_url, params: { feature: { name: "Foo", fid: "foo", feature_category_id: @feature_category.id } }
    end

    assert_response :redirect
  end

  test "should create feature_category if logged in" do
    sign_in @user
    assert_difference("Feature.count", 1) do
      post features_url, params: { feature: { name: "Foo1", fid: "foo2344343#{rand(10000)}", feature_category_id: @feature_category.id } }
    end

    assert_redirected_to feature_url(Feature.last)
  end



  test "should NOT show feature_category if NOT logged in" do
    get feature_url(@feature)
    assert_response :redirect
  end

  test "should show feature_category if logged in" do
    sign_in @user
    get feature_url(@feature)
    assert_response :success
  end



  test "should get edit if NOT logged in" do
    get edit_feature_url(@feature)
    assert_response :redirect
  end

  test "should get edit if logged in" do
    sign_in @user
    get edit_feature_url(@feature)
    assert_response :success
  end



  test "should update domain if not logged in" do
    patch feature_url(@feature), params: { feature: { name: "Foo", fid: "foo", feature_category_id: @feature_category.id } }
    assert_response :redirect
  end

  test "should update domain if logged in" do
    sign_in @user
    patch feature_url(@feature), params: { feature: { name: "Foo22", fid: "foo22", feature_category_id: @feature_category.id } }
    assert_redirected_to feature_url(@feature)
  end



  test "should NOT destroy feature_category if not logged in" do
    assert_difference("Feature.count", 0) do
      delete feature_url(@feature)
    end

    assert_response :redirect
  end
  
  test "should destroy feature_category if logged in" do
    sign_in @user
    assert_difference("Feature.count", -1) do
      delete feature_url(@feature)
    end

    assert_redirected_to features_url
  end
  
  
  # setup do
  #   @feature = features(:one)
  # end
  #
  # test "should get index" do
  #   get features_url
  #   assert_response :success
  # end
  #
  # test "should get new" do
  #   get new_feature_url
  #   assert_response :success
  # end
  #
  # test "should create feature" do
  #   assert_difference("Feature.count") do
  #     post features_url, params: { feature: { fid: @feature.fid, name: @feature.name } }
  #   end
  #
  #   assert_redirected_to feature_url(Feature.last)
  # end
  #
  # test "should show feature" do
  #   get feature_url(@feature)
  #   assert_response :success
  # end
  #
  # test "should get edit" do
  #   get edit_feature_url(@feature)
  #   assert_response :success
  # end
  #
  # test "should update feature" do
  #   patch feature_url(@feature), params: { feature: { fid: @feature.fid, name: @feature.name } }
  #   assert_redirected_to feature_url(@feature)
  # end
  #
  # test "should destroy feature" do
  #   assert_difference("Feature.count", -1) do
  #     delete feature_url(@feature)
  #   end
  #
  #   assert_redirected_to features_url
  # end
end
