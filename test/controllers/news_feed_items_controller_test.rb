require "test_helper"

class NewsFeedItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @news_feed_item = news_feed_items(:one)
  end

  test "should get index" do
    get news_feed_items_url
    assert_response :success
  end

  test "should get new" do
    get new_news_feed_item_url
    assert_response :success
  end

  test "should create news_feed_item" do
    assert_difference("NewsFeedItem.count") do
      post news_feed_items_url, params: { news_feed_item: { guid: @news_feed_item.guid, image_url: @news_feed_item.image_url, news_feed_url_id: @news_feed_item.news_feed_url_id, published_at: @news_feed_item.published_at, source: @news_feed_item.source, summary: @news_feed_item.summary, title: @news_feed_item.title, url: @news_feed_item.url } }
    end

    assert_redirected_to news_feed_item_url(NewsFeedItem.last)
  end

  test "should show news_feed_item" do
    get news_feed_item_url(@news_feed_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_news_feed_item_url(@news_feed_item)
    assert_response :success
  end

  test "should update news_feed_item" do
    patch news_feed_item_url(@news_feed_item), params: { news_feed_item: { guid: @news_feed_item.guid, image_url: @news_feed_item.image_url, news_feed_url_id: @news_feed_item.news_feed_url_id, published_at: @news_feed_item.published_at, source: @news_feed_item.source, summary: @news_feed_item.summary, title: @news_feed_item.title, url: @news_feed_item.url } }
    assert_redirected_to news_feed_item_url(@news_feed_item)
  end

  test "should destroy news_feed_item" do
    assert_difference("NewsFeedItem.count", -1) do
      delete news_feed_item_url(@news_feed_item)
    end

    assert_redirected_to news_feed_items_url
  end
end
