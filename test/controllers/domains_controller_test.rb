require "test_helper"

class DomainsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @domain = FactoryBot.create(:domain)
    @user = FactoryBot.create(:user)
  end
  
  test "should get index if not logged in" do
    get domains_url
    assert_response :redirect
  end
  
  test "should get index if logged in" do
    sign_in @user
    get domains_url
    assert_response :success
  end
  
  
  
  test "should get new if not logged in" do
    get new_domain_url
    assert_response :redirect
  end

  test "should get new if logged in" do
    sign_in @user
    get new_domain_url
    assert_response :success
  end



  test "should NOT create domain if not logged in" do
    assert_no_difference("Domain.count") do
      post domains_url, params: { domain: { name: @domain.name } }
    end

    assert_response :redirect
  end

  test "should create domain if logged in" do
    sign_in @user
    assert_difference("Domain.count", 1) do
      post domains_url, params: { domain: { name: "foo.com" } }
    end

    assert_redirected_to domain_url(Domain.last)
  end



  test "should show domain if NOT logged in" do
    get domain_url(@domain)
    assert_response :redirect
  end

  test "should show domain if logged in" do
    sign_in @user
    get domain_url(@domain)
    assert_response :success
  end



  test "should get edit if NOT logged in" do
    get edit_domain_url(@domain)
    assert_response :redirect
  end

  test "should get edit if logged in" do
    sign_in @user
    get edit_domain_url(@domain)
    assert_response :success
  end



  test "should update domain if not logged in" do
    patch domain_url(@domain), params: { domain: { name: @domain.name } }
    assert_response :redirect
  end

  test "should update domain if logged in" do
    sign_in @user
    patch domain_url(@domain), params: { domain: { name: @domain.name } }
    assert_redirected_to domain_url(@domain)
  end



  test "should NOT destroy domain if not logged in" do
    assert_difference("Domain.count", 0) do
      delete domain_url(@domain)
    end

    assert_response :redirect
  end
  
  test "should destroy domain if logged in" do
    sign_in @user
    assert_difference("Domain.count", -1) do
      delete domain_url(@domain)
    end

    assert_redirected_to domains_url
  end
end
