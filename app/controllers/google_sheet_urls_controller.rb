class GoogleSheetUrlsController < ApplicationController
  before_action :set_google_sheet_url, only: %i[ show edit update destroy ]

  # GET /google_sheet_urls or /google_sheet_urls.json
  def index
    @google_sheet_urls = GoogleSheetUrl.all
  end

  # GET /google_sheet_urls/1 or /google_sheet_urls/1.json
  def show
  end

  # GET /google_sheet_urls/new
  def new
    @google_sheet_url = GoogleSheetUrl.new
  end

  # GET /google_sheet_urls/1/edit
  def edit
  end

  # POST /google_sheet_urls or /google_sheet_urls.json
  def create
    @google_sheet_url = GoogleSheetUrl.new(google_sheet_url_params)

    respond_to do |format|
      if @google_sheet_url.save
        format.html { redirect_to @google_sheet_url, notice: "Google sheet url was successfully created." }
        format.json { render :show, status: :created, location: @google_sheet_url }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @google_sheet_url.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /google_sheet_urls/1 or /google_sheet_urls/1.json
  def update
    respond_to do |format|
      if @google_sheet_url.update(google_sheet_url_params)
        format.html { redirect_to @google_sheet_url, notice: "Google sheet url was successfully updated." }
        format.json { render :show, status: :ok, location: @google_sheet_url }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @google_sheet_url.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /google_sheet_urls/1 or /google_sheet_urls/1.json
  def destroy
    @google_sheet_url.destroy!

    respond_to do |format|
      format.html { redirect_to google_sheet_urls_path, status: :see_other, notice: "Google sheet url was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_google_sheet_url
      @google_sheet_url = GoogleSheetUrl.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def google_sheet_url_params
      params.expect(google_sheet_url: [ :name, :url, :options, :last_checked_at, :ip_address, :user_agent, :user_id ])
    end
end
