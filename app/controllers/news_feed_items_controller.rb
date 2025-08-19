class NewsFeedItemsController < ApplicationController
  before_action :set_news_feed_item, only: %i[ show edit update destroy upvote downvote]
  
  #before_action :set_feed_item, only: %i[upvote downvote]

  def upvote
    @news_feed_item.upvote_by current_user
    redirect_back(fallback_location: root_path)
  end

  def downvote
    @news_feed_item.downvote_by current_user
    redirect_back(fallback_location: root_path)
  end


  # GET /news_feed_items or /news_feed_items.json
  def index
    @news_feed_items = NewsFeedItem.all
  end

  # GET /news_feed_items/1 or /news_feed_items/1.json
  def show
  end

  # GET /news_feed_items/new
  def new
    @news_feed_item = NewsFeedItem.new
  end

  # GET /news_feed_items/1/edit
  def edit
  end

  # POST /news_feed_items or /news_feed_items.json
  def create
    @news_feed_item = NewsFeedItem.new(news_feed_item_params)

    respond_to do |format|
      if @news_feed_item.save
        format.html { redirect_to @news_feed_item, notice: "News feed item was successfully created." }
        format.json { render :show, status: :created, location: @news_feed_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @news_feed_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /news_feed_items/1 or /news_feed_items/1.json
  def update
    respond_to do |format|
      if @news_feed_item.update(news_feed_item_params)
        format.html { redirect_to @news_feed_item, notice: "News feed item was successfully updated." }
        format.json { render :show, status: :ok, location: @news_feed_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @news_feed_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news_feed_items/1 or /news_feed_items/1.json
  def destroy
    @news_feed_item.destroy!

    respond_to do |format|
      format.html { redirect_to news_feed_items_path, status: :see_other, notice: "News feed item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news_feed_item
      @news_feed_item = NewsFeedItem.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def news_feed_item_params
      params.expect(news_feed_item: [ :title, :url, :summary, :published_at, :guid, :source, :news_feed_url_id, :image_url ])
    end
end
