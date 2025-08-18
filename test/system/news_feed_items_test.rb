require "application_system_test_case"

class NewsFeedItemsTest < ApplicationSystemTestCase
  setup do
    @news_feed_item = news_feed_items(:one)
  end

  test "visiting the index" do
    visit news_feed_items_url
    assert_selector "h1", text: "News feed items"
  end

  test "should create news feed item" do
    visit news_feed_items_url
    click_on "New news feed item"

    fill_in "Guid", with: @news_feed_item.guid
    fill_in "Image url", with: @news_feed_item.image_url
    fill_in "News feed url", with: @news_feed_item.news_feed_url_id
    fill_in "Published at", with: @news_feed_item.published_at
    fill_in "Source", with: @news_feed_item.source
    fill_in "Summary", with: @news_feed_item.summary
    fill_in "Title", with: @news_feed_item.title
    fill_in "Url", with: @news_feed_item.url
    click_on "Create News feed item"

    assert_text "News feed item was successfully created"
    click_on "Back"
  end

  test "should update News feed item" do
    visit news_feed_item_url(@news_feed_item)
    click_on "Edit this news feed item", match: :first

    fill_in "Guid", with: @news_feed_item.guid
    fill_in "Image url", with: @news_feed_item.image_url
    fill_in "News feed url", with: @news_feed_item.news_feed_url_id
    fill_in "Published at", with: @news_feed_item.published_at.to_s
    fill_in "Source", with: @news_feed_item.source
    fill_in "Summary", with: @news_feed_item.summary
    fill_in "Title", with: @news_feed_item.title
    fill_in "Url", with: @news_feed_item.url
    click_on "Update News feed item"

    assert_text "News feed item was successfully updated"
    click_on "Back"
  end

  test "should destroy News feed item" do
    visit news_feed_item_url(@news_feed_item)
    click_on "Destroy this news feed item", match: :first

    assert_text "News feed item was successfully destroyed"
  end
end
