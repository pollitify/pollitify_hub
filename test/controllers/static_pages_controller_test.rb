require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get about" do
    get about_path
    assert_response :success
  end

  test "should get contact" do
    get contact_path
    assert_response :success
  end

  test "should get faqs" do
    get faqs_path
    assert_response :success
  end

  test "should get product_features" do
    get product_features_path
    assert_response :success
  end
end
