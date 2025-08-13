require "test_helper"

class FeatureCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @feature_category = FactoryBot.create(:feature_category)
    @user = FactoryBot.create(:user)
  end
  
  test "should get index if not logged in" do
    get feature_categories_url
    assert_response :redirect
  end
  
  test "should get index if logged in" do
    sign_in @user
    get feature_categories_url
    assert_response :success
  end
  
  
  
  test "should get new if not logged in" do
    get new_feature_category_url
    assert_response :redirect
  end

  test "should get new if logged in" do
    sign_in @user
    get new_feature_category_url
    assert_response :success
  end



  test "should NOT create feature_category if not logged in" do
    assert_no_difference("FeatureCategory.count") do
      post domains_url, params: { feature_category: { name: "Foo", fid: "foo" } }
    end

    assert_response :redirect
  end

  test "should create feature_category if logged in" do
    sign_in @user
    assert_difference("FeatureCategory.count", 1) do
      post feature_categories_url, params: { feature_category: { name: "Foo1", fid: "foo1" } }
    end

    assert_redirected_to feature_category_url(FeatureCategory.last)
  end



  test "should NOT show feature_category if NOT logged in" do
    get feature_category_url(@feature_category)
    assert_response :redirect
  end

  test "should show feature_category if logged in" do
    sign_in @user
    get feature_category_url(@feature_category)
    assert_response :success
  end



  test "should get edit if NOT logged in" do
    get edit_feature_category_url(@feature_category)
    assert_response :redirect
  end

  test "should get edit if logged in" do
    sign_in @user
    get edit_feature_category_url(@feature_category)
    assert_response :success
  end



  test "should update domain if not logged in" do
    patch feature_category_url(@feature_category), params: { feature_category: { name: "Foo", fid: "foo" } }
    assert_response :redirect
  end

  test "should update domain if logged in" do
    sign_in @user
    patch feature_category_url(@feature_category), params: { feature_category: { name: "Foo22", fid: "foo22" } }
    assert_redirected_to feature_category_url(@feature_category)
  end



  test "should NOT destroy feature_category if not logged in" do
    assert_difference("FeatureCategory.count", 0) do
      delete feature_category_url(@feature_category)
    end

    assert_response :redirect
  end
  
  test "should destroy feature_category if logged in" do
    sign_in @user
    assert_difference("FeatureCategory.count", -1) do
      delete feature_category_url(@feature_category)
    end

    assert_redirected_to feature_categories_url
  end








  # setup do
  #   @feature_category = feature_categories(:one)
  # end
  #
  # test "should get index" do
  #   get feature_categories_url
  #   assert_response :success
  # end
  #
  # test "should get new" do
  #   get new_feature_category_url
  #   assert_response :success
  # end
  #
  # test "should create feature_category" do
  #   assert_difference("FeatureCategory.count") do
  #     post feature_categories_url, params: { feature_category: { name: @feature_category.name } }
  #   end
  #
  #   assert_redirected_to feature_category_url(FeatureCategory.last)
  # end
  #
  # test "should show feature_category" do
  #   get feature_category_url(@feature_category)
  #   assert_response :success
  # end
  #
  # test "should get edit" do
  #   get edit_feature_category_url(@feature_category)
  #   assert_response :success
  # end
  #
  # test "should update feature_category" do
  #   patch feature_category_url(@feature_category), params: { feature_category: { name: @feature_category.name } }
  #   assert_redirected_to feature_category_url(@feature_category)
  # end
  #
  # test "should destroy feature_category" do
  #   assert_difference("FeatureCategory.count", -1) do
  #     delete feature_category_url(@feature_category)
  #   end
  #
  #   assert_redirected_to feature_categories_url
  # end
end
