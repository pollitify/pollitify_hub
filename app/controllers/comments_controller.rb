class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_news_feed_item

  def create
    return if Comment.already_exists?(comment_params.merge(user: current_user))
    @comment = @news_feed_item.comments.build(comment_params.merge(user: current_user))
    if @comment.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_back fallback_location: news_feed_items_path }
      end
    else
      redirect_back fallback_location: news_feed_items_path, alert: "Comment cannot be empty."
    end
  end

  def destroy
    @comment = @news_feed_item.comments.find(params[:id])
    if @comment.user == current_user
      @comment.destroy
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_back fallback_location: news_feed_items_path }
      end
    else
      redirect_back fallback_location: news_feed_items_path, alert: "Not authorized."
    end
  end

  private

  def set_news_feed_item
    @news_feed_item = NewsFeedItem.find(params[:news_feed_item_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
