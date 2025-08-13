require "application_system_test_case"

class OrganizationsTest < ApplicationSystemTestCase
  setup do
    @organization = organizations(:one)
  end

  test "visiting the index" do
    visit organizations_url
    assert_selector "h1", text: "Organizations"
  end

  test "should create organization" do
    visit organizations_url
    click_on "New organization"

    check "Active" if @organization.active
    fill_in "Billing", with: @organization.billing
    fill_in "City", with: @organization.city
    fill_in "Domain", with: @organization.domain_id
    fill_in "Features", with: @organization.features
    fill_in "Fid", with: @organization.fid
    fill_in "Name", with: @organization.name
    fill_in "Organization website domain", with: @organization.organization_website_domain
    fill_in "Organization website url", with: @organization.organization_website_url
    fill_in "Polly domain", with: @organization.polly_domain
    fill_in "Polly url", with: @organization.polly_url
    fill_in "Secure chat system", with: @organization.secure_chat_system_id
    fill_in "State", with: @organization.state
    fill_in "Sub domain", with: @organization.sub_domain
    fill_in "Your domain or ours", with: @organization.your_domain_or_ours
    click_on "Create Organization"

    assert_text "Organization was successfully created"
    click_on "Back"
  end

  test "should update Organization" do
    visit organization_url(@organization)
    click_on "Edit this organization", match: :first

    check "Active" if @organization.active
    fill_in "Billing", with: @organization.billing
    fill_in "City", with: @organization.city
    fill_in "Domain", with: @organization.domain_id
    fill_in "Features", with: @organization.features
    fill_in "Fid", with: @organization.fid
    fill_in "Name", with: @organization.name
    fill_in "Organization website domain", with: @organization.organization_website_domain
    fill_in "Organization website url", with: @organization.organization_website_url
    fill_in "Polly domain", with: @organization.polly_domain
    fill_in "Polly url", with: @organization.polly_url
    fill_in "Secure chat system", with: @organization.secure_chat_system_id
    fill_in "State", with: @organization.state
    fill_in "Sub domain", with: @organization.sub_domain
    fill_in "Your domain or ours", with: @organization.your_domain_or_ours
    click_on "Update Organization"

    assert_text "Organization was successfully updated"
    click_on "Back"
  end

  test "should destroy Organization" do
    visit organization_url(@organization)
    click_on "Destroy this organization", match: :first

    assert_text "Organization was successfully destroyed"
  end
end
