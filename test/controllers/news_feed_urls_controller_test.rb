require "test_helper"

class NewsFeedUrlsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @news_feed_url = news_feed_urls(:one)
  end

  test "should get index" do
    get news_feed_urls_url
    assert_response :success
  end

  test "should get new" do
    get new_news_feed_url_url
    assert_response :success
  end

  test "should create news_feed_url" do
    assert_difference("NewsFeedUrl.count") do
      post news_feed_urls_url, params: { news_feed_url: { last_checked_at: @news_feed_url.last_checked_at, name: @news_feed_url.name, rss_url: @news_feed_url.rss_url } }
    end

    assert_redirected_to news_feed_url_url(NewsFeedUrl.last)
  end

  test "should show news_feed_url" do
    get news_feed_url_url(@news_feed_url)
    assert_response :success
  end

  test "should get edit" do
    get edit_news_feed_url_url(@news_feed_url)
    assert_response :success
  end

  test "should update news_feed_url" do
    patch news_feed_url_url(@news_feed_url), params: { news_feed_url: { last_checked_at: @news_feed_url.last_checked_at, name: @news_feed_url.name, rss_url: @news_feed_url.rss_url } }
    assert_redirected_to news_feed_url_url(@news_feed_url)
  end

  test "should destroy news_feed_url" do
    assert_difference("NewsFeedUrl.count", -1) do
      delete news_feed_url_url(@news_feed_url)
    end

    assert_redirected_to news_feed_urls_url
  end
end
