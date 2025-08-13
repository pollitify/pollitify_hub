class CountiesController < ApplicationController
  before_action :set_county, only: %i[ show edit update destroy ]

  # GET /counties or /counties.json
  def index
    @counties = County.all
  end

  # GET /counties/1 or /counties/1.json
  def show
  end

  # GET /counties/new
  def new
    @county = County.new
  end

  # GET /counties/1/edit
  def edit
  end

  # POST /counties or /counties.json
  def create
    @county = County.new(county_params)

    respond_to do |format|
      if @county.save
        format.html { redirect_to @county, notice: "County was successfully created." }
        format.json { render :show, status: :created, location: @county }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @county.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /counties/1 or /counties/1.json
  def update
    respond_to do |format|
      if @county.update(county_params)
        format.html { redirect_to @county, notice: "County was successfully updated." }
        format.json { render :show, status: :ok, location: @county }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @county.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /counties/1 or /counties/1.json
  def destroy
    @county.destroy!

    respond_to do |format|
      format.html { redirect_to counties_path, status: :see_other, notice: "County was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_county
      @county = County.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def county_params
      params.expect(county: [ :name, :name_ascii, :name_full, :county_fips, :state_id, :state_abbreviation, :state_name, :lat, :lng, :coordinates, :population ])
    end
end
