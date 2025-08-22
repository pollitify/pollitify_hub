class GovernmentOfficialsController < ApplicationController
  #before_action :do_nothing, only: %i[me]
  before_action :set_government_official, only: %i[ show edit update destroy ]
  
  # GET /government_officials or /government_officials.json
  def index
    #debugger
    #raise [current_user && current_user.state?].inspect
    if current_user && current_user.state?
      #raise "foo"
      #raise current_user.state.capitalize.inspect
      @government_officials = GovernmentOfficial.where(state_id: current_user.state_id).order("title ASC, full_name ASC")
      #GovernmentOfficial.where("state_name = #{current_user.state}").order("state_name ASC")
    else
      @government_officials = GovernmentOfficial.order("state_name ASC")
    end
  end
  
  # def me
  #   raise "foo"
  #   if current_user.nil?
  #     flash[:message] = "You need to be logged in to use this feature"
  #     redirect_to :new_user_session_url
  #   else
  #     @my_government_officials = []
  #     @my_government_officials = GovernmentOfficial.where(congressional_district_id: current_user.congressional_district.id).or(GovernmentOfficial.where(state_id: current_user.state_obj.id, government_official_type_id: GovernmentOfficialType.senator.id))
  #   end
  # end

  # GET /government_officials/1 or /government_officials/1.json
  def show
    @political_parties = PoliticalParty.all
    
  end
  
  def edit
    @political_parties = PoliticalParty.all
    @congressional_districts = @government_official.possible_congressional_districts
    
  end

  # GET /government_officials/new
  def new
    @government_official = GovernmentOfficial.new
    @political_parties = PoliticalParty.all
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
    @political_parties = PoliticalParty.all
    @congressional_districts = @government_official.possible_congressional_districts
    #@government_official.user_id = current_user.id
    #raise [@government_official.valid?, @government_official.errors.full_messages].inspect
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
      return if params[:id] == 'me'
      @government_official = GovernmentOfficial.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def government_official_params
      params.expect(government_official: [ :full_name, :first_name, :middle_name, :last_name, :title, :phone_number, :email_link, :full_address, :address1, :address2, :city, :state, :zip, :state_id, :government_official_type_id, :committees, :political_party_id, :congressional_district_id ])
    end

  # # GET /government_officials or /government_officials.json
  # def index
  #   @government_officials = GovernmentOfficial.all.page(params[:page])
  # end
  #
  # # GET /government_officials/1 or /government_officials/1.json
  # def show
  # end
  #
  # # GET /government_officials/new
  # def new
  #   @government_official = GovernmentOfficial.new
  # end
  #
  # # GET /government_officials/1/edit
  # def edit
  # end
  #
  # # POST /government_officials or /government_officials.json
  # def create
  #   @government_official = GovernmentOfficial.new(government_official_params)
  #
  #   respond_to do |format|
  #     if @government_official.save
  #       format.html { redirect_to @government_official, notice: "Government official was successfully created." }
  #       format.json { render :show, status: :created, location: @government_official }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @government_official.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # # PATCH/PUT /government_officials/1 or /government_officials/1.json
  # def update
  #   respond_to do |format|
  #     if @government_official.update(government_official_params)
  #       format.html { redirect_to @government_official, notice: "Government official was successfully updated." }
  #       format.json { render :show, status: :ok, location: @government_official }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @government_official.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # # DELETE /government_officials/1 or /government_officials/1.json
  # def destroy
  #   @government_official.destroy!
  #
  #   respond_to do |format|
  #     format.html { redirect_to government_officials_path, status: :see_other, notice: "Government official was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end
  #
  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_government_official
  #     @government_official = GovernmentOfficial.find(params.expect(:id))
  #   end
  #
  #   # Only allow a list of trusted parameters through.
  #   def government_official_params
  #     params.expect(government_official: [ :full_name, :first_name, :middle_name, :last_name, :title, :phone_number, :email_link, :full_address, :address1, :address2, :city, :state_name, :zip, :state_id, :government_official_type_id, :committees, :veteran, :political_party_id, :congressional_district_id, :suffix, :nickname, :birthday, :gender, :job_type, :district, :senate_class, :party, :url, :address, :phone, :contact_form, :rss_url, :twitter, :twitter_id, :facebook, :youtube, :youtube_id, :mastodon, :bluesky, :bluesky_id, :bioguide_id, :thomas_id, :opensecrets_id, :lis_id, :fec_ids, :cspan_id, :govtrack_id, :votesmart_id, :ballotpedia_id, :washington_post_id, :icpsr_id, :wikipedia_id ])
  #   end
end
