require "test_helper"


class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = FactoryBot.create(:user)
    #@user = User.create!(email: "user@example.com", password: "password")
    #@other_user = User.create!(email: "other@example.com", password: "password")
    @other_user = FactoryBot.create(:user)
    @news_feed_url = FactoryBot.create(:news_feed_url)
    @news_feed_item = NewsFeedItem.create!(title: "Test Item", url: "http://example.com", summary: "Summary", published_at: Time.now, news_feed_url_id: @news_feed_url.id)
    @comment = @news_feed_item.comments.create!(body: "Existing comment", user: @user)
  end

  # --------------------
  # CREATE ACTION TESTS
  # --------------------
  
  test "should create comment successfully" do
    sign_in @user
    post news_feed_item_comments_url(@news_feed_item), params: { comment: { body: "New comment" } }
    
    assert_response :redirect
    assert_redirected_to news_feed_items_path
    assert_equal "New comment", @news_feed_item.comments.last.body
    assert_equal @user, @news_feed_item.comments.last.user
  end

  test "should not create comment if body is empty" do
    sign_in @user
    post news_feed_item_comments_url(@news_feed_item), params: { comment: { body: "" } }
    
    assert_redirected_to news_feed_items_path
    assert_equal "Comment cannot be empty.", flash[:alert]
  end

  # test "should not create comment if already exists" do
  #   sign_in @user
  #
  #   mock_comment = Minitest::Mock.new
  #   mock_comment.expect(:already_exists?, true, [Hash])
  #
  #
  #   # Stub Comment.already_exists? to return true
  #   # Comment.stub :already_exists?, true do
  #   #   assert_no_difference "Comment.count" do
  #   #     post news_feed_item_comments_url(@news_feed_item), params: { comment: { body: "Existing comment" } }
  #   #   end
  #   # end
  #   #mock_comment.verify
  #   # Comment.stub(:already_exists?, true) do
  #   #   assert_no_difference "Comment.count" do
  #   #     post news_feed_item_comments_url(@news_feed_item), params: { comment: { body: "Existing comment" } }
  #   #   end
  #   # end
  # end

  # --------------------
  # DESTROY ACTION TESTS
  # --------------------
  
  test "should destroy comment if user owns it" do
    sign_in @user
    assert_difference "Comment.count", -1 do
      delete news_feed_item_comment_url(@news_feed_item, @comment)
    end
    
    assert_redirected_to news_feed_items_path
  end

  test "should not destroy comment if user does not own it" do
    sign_in @other_user
    assert_no_difference "Comment.count" do
      delete news_feed_item_comment_url(@news_feed_item, @comment)
    end
    
    assert_redirected_to news_feed_items_path
    assert_equal "Not authorized.", flash[:alert]
  end

  # test "should find the correct news_feed_item" do
  #   sign_in @user
  #   get news_feed_item_comments_url(@news_feed_item)
  #   assert_equal @news_feed_item, assigns(:news_feed_item)
  # end

  # --------------------
  # AUTHENTICATION TESTS
  # --------------------
  
  test "should redirect to sign in if not logged in for create" do
    post news_feed_item_comments_url(@news_feed_item), params: { comment: { body: "Test" } }
    assert_redirected_to new_user_session_path
  end

  test "should redirect to sign in if not logged in for destroy" do
    delete news_feed_item_comment_url(@news_feed_item, @comment)
    assert_redirected_to new_user_session_path
  end
end