require "application_system_test_case"

class GoogleSheetUrlsTest < ApplicationSystemTestCase
  setup do
    @google_sheet_url = google_sheet_urls(:one)
  end

  test "visiting the index" do
    visit google_sheet_urls_url
    assert_selector "h1", text: "Google sheet urls"
  end

  test "should create google sheet url" do
    visit google_sheet_urls_url
    click_on "New google sheet url"

    fill_in "Ip address", with: @google_sheet_url.ip_address
    fill_in "Last checked at", with: @google_sheet_url.last_checked_at
    fill_in "Name", with: @google_sheet_url.name
    fill_in "Options", with: @google_sheet_url.options
    fill_in "Url", with: @google_sheet_url.url
    fill_in "User agent", with: @google_sheet_url.user_agent
    fill_in "User", with: @google_sheet_url.user_id
    click_on "Create Google sheet url"

    assert_text "Google sheet url was successfully created"
    click_on "Back"
  end

  test "should update Google sheet url" do
    visit google_sheet_url_url(@google_sheet_url)
    click_on "Edit this google sheet url", match: :first

    fill_in "Ip address", with: @google_sheet_url.ip_address
    fill_in "Last checked at", with: @google_sheet_url.last_checked_at.to_s
    fill_in "Name", with: @google_sheet_url.name
    fill_in "Options", with: @google_sheet_url.options
    fill_in "Url", with: @google_sheet_url.url
    fill_in "User agent", with: @google_sheet_url.user_agent
    fill_in "User", with: @google_sheet_url.user_id
    click_on "Update Google sheet url"

    assert_text "Google sheet url was successfully updated"
    click_on "Back"
  end

  test "should destroy Google sheet url" do
    visit google_sheet_url_url(@google_sheet_url)
    click_on "Destroy this google sheet url", match: :first

    assert_text "Google sheet url was successfully destroyed"
  end
end
