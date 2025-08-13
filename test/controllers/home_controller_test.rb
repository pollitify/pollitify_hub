require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get home_index_url
    assert_response :success
  end

  test "should get favicon.ico" do
    get "/favicon.ico"
    assert_response :success
  end

  test "should get favicon.png" do
    get "/favicon.png"
    assert_response :success
  end

  test "should get icon.svg" do
    get "/icon.svg"
    assert_response :success
  end

  test "should get robots.txt" do
    get "/robots.txt"
    assert_response :success
  end
  
  test "should show events"
  
  test "should show suggest button"do
    get home_index_url
    assert_response :success
    assert_select "div#suggest_button", true, "Expected to find a div with id='suggest_button'"
    
  end
  
  test "should show tagline" do
    get home_index_url
    assert_response :success
    assert_select "div#tagline", true, "Expected to find a div with id='tagline'"
    
  end
end
