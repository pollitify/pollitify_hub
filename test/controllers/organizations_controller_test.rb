require "test_helper"

class OrganizationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @organization = FactoryBot.create(:organization)
    @user = FactoryBot.create(:user)
    @state = FactoryBot.create(:state)
    #@organization_category = FactoryBot.create(:organization_category, fid: "dddd")
  end
  
  test "should get index if not logged in" do
    get organizations_url
    assert_response :redirect
  end
  
  test "should get index if logged in" do
    sign_in @user
    get organizations_url
    assert_response :success
  end
  
  
  
  test "should get new if not logged in" do
    get new_organization_url
    assert_response :redirect
  end

  test "should get new if logged in" do
    sign_in @user
    get new_organization_url
    assert_response :success
  end



  test "should NOT create organization if not logged in" do
    assert_no_difference("Organization.count") do
      post domains_url, params: { organization: { active: @organization.active, billing: @organization.billing, city: @organization.city, domain_id: @organization.domain_id, features: @organization.features, fid: @organization.fid, name: @organization.name, organization_website_domain: @organization.organization_website_domain, organization_website_url: @organization.organization_website_url, polly_domain: @organization.polly_domain, polly_url: @organization.polly_url, secure_chat_system_id: @organization.secure_chat_system_id, state: @organization.state, sub_domain: @organization.sub_domain, email: "foo@bar.com", username: "foo", first_name: "scott", last_name: "hawkins", password: "password123", password_confirmation: "password123" } }
    end

    assert_response :redirect
  end

  test "should create organization if logged in" do
    sign_in @user
    assert_difference("Organization.count", 1) do
      post organizations_url, params: { organization: { active: @organization.active, billing: @organization.billing, city: @organization.city, domain_id: @organization.domain_id, features: @organization.features, fid: "12324", name: "1234", organization_website_domain: @organization.organization_website_domain, organization_website_url: @organization.organization_website_url, polly_domain: @organization.polly_domain, polly_url: @organization.polly_url, secure_chat_system_id: @organization.secure_chat_system_id, state_id: @state.id, sub_domain: @organization.sub_domain, email: "foo@bar.com", username: "foo", first_name: "scott", last_name: "hawkins", password: "password123", password_confirmation: "password123" } }
    end

    assert_redirected_to organization_url(Organization.last)
  end



  test "should NOT show organization if NOT logged in" do
    get organization_url(@organization)
    assert_response :redirect
  end

  test "should show organization if logged in" do
    sign_in @user
    get organization_url(@organization)
    assert_response :success
  end



  test "should get edit if NOT logged in" do
    get edit_organization_url(@organization)
    assert_response :redirect
  end

  test "should get edit if logged in" do
    sign_in @user
    get edit_organization_url(@organization)
    assert_response :success
  end



  test "should update domain if not logged in" do
    patch organization_url(@organization), params: { organization: { active: @organization.active, billing: @organization.billing, city: @organization.city, domain_id: @organization.domain_id, features: @organization.features, fid: "12324", name: "1234", organization_website_domain: @organization.organization_website_domain, organization_website_url: @organization.organization_website_url, polly_domain: @organization.polly_domain, polly_url: @organization.polly_url, secure_chat_system_id: @organization.secure_chat_system_id, state_id: @state.id, sub_domain: @organization.sub_domain, email: "foo@bar.com", username: "foo", first_name: "scott", last_name: "hawkins", password: "password123", password_confirmation: "password123" } }
    assert_response :redirect
  end

  test "should update domain if logged in" do
    sign_in @user
    patch organization_url(@organization), params: { organization: { active: @organization.active, billing: @organization.billing, city: @organization.city, domain_id: @organization.domain_id, features: @organization.features, fid: "12324", name: "1234", organization_website_domain: @organization.organization_website_domain, organization_website_url: @organization.organization_website_url, polly_domain: @organization.polly_domain, polly_url: @organization.polly_url, secure_chat_system_id: @organization.secure_chat_system_id, state_id: @state.id, sub_domain: @organization.sub_domain, email: "foo@bar.com", username: "foo", first_name: "scott", last_name: "hawkins", password: "password123", password_confirmation: "password123" } }
    assert_redirected_to organization_url(@organization)
  end



  test "should NOT destroy organization if not logged in" do
    assert_difference("Organization.count", 0) do
      delete organization_url(@organization)
    end

    assert_response :redirect
  end
  
  test "should destroy organization if logged in" do
    sign_in @user
    assert_difference("Organization.count", -1) do
      delete organization_url(@organization)
    end

    assert_redirected_to organizations_url
  end
  
  
  # setup do
  #   @organization = create(:organization)
  # end
  #
  # test "should get index" do
  #   get organizations_url
  #   assert_response :success
  # end
  #
  # test "should get new" do
  #   get new_organization_url
  #   assert_response :success
  # end
  #
  # test "should create organization" do
  #   assert_difference("Organization.count") do
  #     post organizations_url, params: { organization: { active: @organization.active, billing: @organization.billing, city: @organization.city, domain_id: @organization.domain_id, features: @organization.features, fid: @organization.fid, name: @organization.name, organization_website_domain: @organization.organization_website_domain, organization_website_url: @organization.organization_website_url, polly_domain: @organization.polly_domain, polly_url: @organization.polly_url, secure_chat_system_id: @organization.secure_chat_system_id, state: @organization.state, sub_domain: @organization.sub_domain, your_domain_or_ours: @organization.your_domain_or_ours } }
  #   end
  #
  #   assert_redirected_to organization_url(Organization.last)
  # end
  #
  # test "should show organization" do
  #   get organization_url(@organization)
  #   assert_response :success
  # end
  #
  # test "should get edit" do
  #   get edit_organization_url(@organization)
  #   assert_response :success
  # end
  #
  # test "should update organization" do
  #   patch organization_url(@organization), params: { organization: { active: @organization.active, billing: @organization.billing, city: @organization.city, domain_id: @organization.domain_id, features: @organization.features, fid: @organization.fid, name: @organization.name, organization_website_domain: @organization.organization_website_domain, organization_website_url: @organization.organization_website_url, polly_domain: @organization.polly_domain, polly_url: @organization.polly_url, secure_chat_system_id: @organization.secure_chat_system_id, state: @organization.state, sub_domain: @organization.sub_domain, your_domain_or_ours: @organization.your_domain_or_ours } }
  #   assert_redirected_to organization_url(@organization)
  # end
  #
  # test "should destroy organization" do
  #   assert_difference("Organization.count", -1) do
  #     delete organization_url(@organization)
  #   end
  #
  #   assert_redirected_to organizations_url
  # end
end
