require "application_system_test_case"

class NewsFeedUrlsTest < ApplicationSystemTestCase
  setup do
    @news_feed_url = news_feed_urls(:one)
  end

  test "visiting the index" do
    visit news_feed_urls_url
    assert_selector "h1", text: "News feed urls"
  end

  test "should create news feed url" do
    visit news_feed_urls_url
    click_on "New news feed url"

    fill_in "Last checked at", with: @news_feed_url.last_checked_at
    fill_in "Name", with: @news_feed_url.name
    fill_in "Rss url", with: @news_feed_url.rss_url
    click_on "Create News feed url"

    assert_text "News feed url was successfully created"
    click_on "Back"
  end

  test "should update News feed url" do
    visit news_feed_url_url(@news_feed_url)
    click_on "Edit this news feed url", match: :first

    fill_in "Last checked at", with: @news_feed_url.last_checked_at.to_s
    fill_in "Name", with: @news_feed_url.name
    fill_in "Rss url", with: @news_feed_url.rss_url
    click_on "Update News feed url"

    assert_text "News feed url was successfully updated"
    click_on "Back"
  end

  test "should destroy News feed url" do
    visit news_feed_url_url(@news_feed_url)
    click_on "Destroy this news feed url", match: :first

    assert_text "News feed url was successfully destroyed"
  end
end
