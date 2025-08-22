class GovernmentOfficialsController < ApplicationController
  before_action :set_government_official, only: %i[ show edit update destroy ]

  # GET /government_officials or /government_officials.json
  def index
    @government_officials = GovernmentOfficial.all.page(params[:page])
  end

  # GET /government_officials/1 or /government_officials/1.json
  def show
  end

  # GET /government_officials/new
  def new
    @government_official = GovernmentOfficial.new
  end

  # GET /government_officials/1/edit
  def edit
  end

  # POST /government_officials or /government_officials.json
  def create
    @government_official = GovernmentOfficial.new(government_official_params)

    respond_to do |format|
      if @government_official.save
        format.html { redirect_to @government_official, notice: "Government official was successfully created." }
        format.json { render :show, status: :created, location: @government_official }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @government_official.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /government_officials/1 or /government_officials/1.json
  def update
    respond_to do |format|
      if @government_official.update(government_official_params)
        format.html { redirect_to @government_official, notice: "Government official was successfully updated." }
        format.json { render :show, status: :ok, location: @government_official }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @government_official.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /government_officials/1 or /government_officials/1.json
  def destroy
    @government_official.destroy!

    respond_to do |format|
      format.html { redirect_to government_officials_path, status: :see_other, notice: "Government official was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_government_official
      @government_official = GovernmentOfficial.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def government_official_params
      params.expect(government_official: [ :full_name, :first_name, :middle_name, :last_name, :title, :phone_number, :email_link, :full_address, :address1, :address2, :city, :state_name, :zip, :state_id, :government_official_type_id, :committees, :veteran, :political_party_id, :congressional_district_id, :suffix, :nickname, :birthday, :gender, :job_type, :district, :senate_class, :party, :url, :address, :phone, :contact_form, :rss_url, :twitter, :twitter_id, :facebook, :youtube, :youtube_id, :mastodon, :bluesky, :bluesky_id, :bioguide_id, :thomas_id, :opensecrets_id, :lis_id, :fec_ids, :cspan_id, :govtrack_id, :votesmart_id, :ballotpedia_id, :washington_post_id, :icpsr_id, :wikipedia_id ])
    end
end
