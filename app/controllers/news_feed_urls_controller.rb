class NewsFeedUrlsController < ApplicationController
  before_action :set_news_feed_url, only: %i[ show edit update destroy ]

  # GET /news_feed_urls or /news_feed_urls.json
  def index
    @news_feed_urls = NewsFeedUrl.all
  end

  # GET /news_feed_urls/1 or /news_feed_urls/1.json
  def show
  end

  # GET /news_feed_urls/new
  def new
    @news_feed_url = NewsFeedUrl.new
  end

  # GET /news_feed_urls/1/edit
  def edit
  end

  # POST /news_feed_urls or /news_feed_urls.json
  def create
    @news_feed_url = NewsFeedUrl.new(news_feed_url_params)

    respond_to do |format|
      if @news_feed_url.save
        format.html { redirect_to @news_feed_url, notice: "News feed url was successfully created." }
        format.json { render :show, status: :created, location: @news_feed_url }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @news_feed_url.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /news_feed_urls/1 or /news_feed_urls/1.json
  def update
    respond_to do |format|
      if @news_feed_url.update(news_feed_url_params)
        format.html { redirect_to @news_feed_url, notice: "News feed url was successfully updated." }
        format.json { render :show, status: :ok, location: @news_feed_url }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @news_feed_url.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news_feed_urls/1 or /news_feed_urls/1.json
  def destroy
    @news_feed_url.destroy!

    respond_to do |format|
      format.html { redirect_to news_feed_urls_path, status: :see_other, notice: "News feed url was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news_feed_url
      @news_feed_url = NewsFeedUrl.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def news_feed_url_params
      params.expect(news_feed_url: [ :name, :rss_url, :last_checked_at ])
    end
end
