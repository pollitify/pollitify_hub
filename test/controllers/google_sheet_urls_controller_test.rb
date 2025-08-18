require "test_helper"

class GoogleSheetUrlsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @google_sheet_url = google_sheet_urls(:one)
  end

  test "should get index" do
    get google_sheet_urls_url
    assert_response :success
  end

  test "should get new" do
    get new_google_sheet_url_url
    assert_response :success
  end

  test "should create google_sheet_url" do
    assert_difference("GoogleSheetUrl.count") do
      post google_sheet_urls_url, params: { google_sheet_url: { ip_address: @google_sheet_url.ip_address, last_checked_at: @google_sheet_url.last_checked_at, name: @google_sheet_url.name, options: @google_sheet_url.options, url: @google_sheet_url.url, user_agent: @google_sheet_url.user_agent, user_id: @google_sheet_url.user_id } }
    end

    assert_redirected_to google_sheet_url_url(GoogleSheetUrl.last)
  end

  test "should show google_sheet_url" do
    get google_sheet_url_url(@google_sheet_url)
    assert_response :success
  end

  test "should get edit" do
    get edit_google_sheet_url_url(@google_sheet_url)
    assert_response :success
  end

  test "should update google_sheet_url" do
    patch google_sheet_url_url(@google_sheet_url), params: { google_sheet_url: { ip_address: @google_sheet_url.ip_address, last_checked_at: @google_sheet_url.last_checked_at, name: @google_sheet_url.name, options: @google_sheet_url.options, url: @google_sheet_url.url, user_agent: @google_sheet_url.user_agent, user_id: @google_sheet_url.user_id } }
    assert_redirected_to google_sheet_url_url(@google_sheet_url)
  end

  test "should destroy google_sheet_url" do
    assert_difference("GoogleSheetUrl.count", -1) do
      delete google_sheet_url_url(@google_sheet_url)
    end

    assert_redirected_to google_sheet_urls_url
  end
end
