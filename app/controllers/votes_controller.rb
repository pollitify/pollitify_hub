class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_news_feed_item

  # def create
  #   vote = @news_feed_item.votes.find_or_initialize_by(user: current_user)
  #   vote.value = params[:value].to_i
  #   if vote.save
  #     redirect_back fallback_location: feed_items_path, notice: "Vote recorded!"
  #   else
  #     redirect_back fallback_location: feed_items_path, alert: "Unable to vote."
  #   end
  # end
  
  def create
    @vote = @feed_item.votes.find_or_initialize_by(user: current_user)
    @vote.value = params[:value].to_i
    if @vote.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_back fallback_location: feed_items_path, notice: "Vote recorded!" }
      end
    else
      redirect_back fallback_location: feed_items_path, alert: "Unable to vote."
    end
  end

  private

  def set_news_feed_item
    @news_feed_item = NewsFeedItem.find(params[:news_feed_item_id])
  end
end
